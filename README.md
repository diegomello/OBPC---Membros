# ⛪ Sistema de Cadastro de Membros e Emissão de Credenciais

Aplicação web completa e responsiva (**PWA**) para cadastro de membros de igreja, gestão hierárquica eclesiástica (pré-cadastro), painel administrativo e geração automatizada de credenciais prontas para impressão (formato cartão PVC **CR80** e grade em **Folha A4**) com QR Code para validação pública de autenticidade.

---

## 🛠️ Tecnologias Utilizadas

- **Front-end:** [React](https://react.dev/) + [Vite](https://vitejs.dev/) + [TypeScript](https://www.typescriptlang.org/) + [TailwindCSS](https://tailwindcss.com/) + PWA (Service Worker & Manifest)
- **Back-end:** [Node.js](https://nodejs.org/) + [Express](https://expressjs.com/) + [TypeScript](https://www.typescriptlang.org/)
- **Banco de Dados:** [PostgreSQL](https://www.postgresql.org/)
- **Documentos & Credenciais:** Geração de PDF e cartão PVC CR80 com [pdf-lib](https://pdf-lib.js.org/) + [QRCode](https://github.com/soldair/node-qrcode)
- **Segurança:** Autenticação JWT, criptografia com bcrypt, RBAC (Admin e Secretaria), Helmet, CORS e Rate Limiting

---

## 🚀 Próximos Passos e Instruções Práticas

### Passo 1: Subir o Projeto para o seu GitHub
O repositório já está preparado com arquivos `.gitignore`, `.env.example` e `.gitkeep` em todas as pastas.

1. **Instalar o Git** (caso ainda não possua):
   ```powershell
   winget install --id Git.Git -e --source winget
   ```
2. **Inicializar e subir os arquivos:**
   ```bash
   git init
   git add .
   git commit -m "feat: conclusao de todos os modulos M0 ao M7 do sistema"
   git branch -M main
   git remote add origin https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git
   git push -u origin main
   ```

---

### Passo 2: Executar e Testar Localmente na Sua Máquina
Certifique-se de que o **Node.js LTS** esteja instalado (`winget install OpenJS.NodeJS.LTS -e`).

1. **Subir o Banco de Dados PostgreSQL:**
   ```bash
   docker compose up db -d
   ```
   *(Ou utilize uma instância local do PostgreSQL e execute a migração em `backend/src/database/migrations/001_initial_schema.sql` e seed `backend/src/database/seeds/001_initial_admin.sql`)*.

2. **Iniciar o Back-end (API Node.js + Express):**
   ```bash
   cd backend
   npm install
   npm run dev
   ```
   > API disponível em `http://localhost:3001` (Healthcheck: `http://localhost:3001/api/health`).

3. **Iniciar o Front-end Web / PWA (React + Vite):**
   ```bash
   cd ../frontend
   npm install
   npm run dev
   ```
   > Aplicação disponível em `http://localhost:5173`.

---

### Passo 3: Roteiro de Primeiro Acesso e Homologação
Siga este roteiro sequencial na primeira utilização do sistema:

1. **Acesso do Administrador Padrão:**
   - **E-mail:** `admin@igreja.org.br`
   - **Senha:** `Admin@123456`
2. **Confirmação Cadastral Obrigatória:**
   - Revise o nome, telefone e confirme o perfil antes de entrar no painel.
3. **Alimentação do Pré-Cadastro (Ordem Lógica):**
   - 1º **Superintendências** ➔ 2º **Cidades** (vinculadas) ➔ 3º **Igrejas** (com Pastor Presidente) ➔ 4º **Cargos Ministeriais**.
4. **Cadastro de Membro no Celular (PWA):**
   - Abra o link do formulário público de membros, preencha as 6 etapas, tire a foto 3x4 e confirme o aceite LGPD para obter o protocolo.
5. **Emissão de Credencial:**
   - Acesse o painel da secretaria, localize o membro e clique em **🪪 Emitir Credencial**.
   - Visualize o cartão em tamanho real CR80 (85,6 x 54 mm), dispare a impressão e confirme o diálogo para avançar o status para `IMPRESSA`.
6. **Validação do QR Code:**
   - Aponte a câmera de qualquer smartphone para o QR Code da credencial e verifique a autenticidade na página pública de validação.

---

### Passo 4: Publicação em Produção (Deploy VPS)
Para colocar o sistema online na internet sob domínio próprio com HTTPS e backups automáticos:
- Consulte o guia completo e detalhado em **[`docs/guia_de_publicacao.md`](docs/guia_de_publicacao.md)**.
- Subida simplificada via container: `docker compose up -d --build`.

---

## 📂 Estrutura do Repositório

```text
├── backend/                         # Servidor da API REST
│   ├── Dockerfile                   # Build multi-stage para produção
│   ├── .env.example                 # Modelo das variáveis de ambiente
│   ├── src/
│   │   ├── config/                  # Conexão com PostgreSQL, JWT e variáveis
│   │   ├── controllers/             # Controladores das rotas
│   │   ├── database/
│   │   │   ├── migrations/          # Scripts de evolução e criação das tabelas
│   │   │   └── seeds/               # Admin inicial e dados para teste
│   │   ├── middlewares/             # Auth JWT, RBAC, Rate Limit, Upload Multer
│   │   ├── models/                  # Interfaces, schemas e tipagens
│   │   ├── routes/                  # Rotas da API (públicas e administrativas)
│   │   ├── services/                # Regras de negócio, PDF, QR Code e notificações
│   │   └── utils/                   # Validações, sanitizadores e formatadores
│   └── uploads/photos/              # Armazenamento protegido de fotos 3x4
│
├── frontend/                        # Interface Web Responsiva e PWA
│   ├── Dockerfile                   # Build multi-stage com Nginx
│   ├── nginx.conf                   # Configuração Nginx com roteamento SPA e segurança
│   ├── .env.example                 # Modelo das variáveis de ambiente
│   ├── public/                      # Manifest PWA, service worker, ícones
│   └── src/
│       ├── assets/                  # Imagens, logotipos e ilustrações
│       ├── components/              # Componentes comuns, formulários e credencial CR80
│       ├── context/                 # Contextos globais (AuthContext)
│       ├── pages/                   # Telas de login, formulário público, admin e validação
│       └── services/                # Configuração de clientes HTTP
│
├── docs/                            # Guias de deploy e relatórios de homologação (M1 ao M7)
├── docker-compose.yml               # Orquestração (Frontend + Backend + PostgreSQL)
├── Plano_de_Desenvolvimento_e_Testes.pdf # Planejamento completo em PDF
├── Proximos_Passos_e_Instrucoes.pdf      # Guia executivo dos próximos passos em PDF
└── README.md
```

---

## 📄 Licença

Este projeto é desenvolvido para uso eclesiástico e institucional. Consulte os responsáveis para detalhes sobre distribuição e uso.

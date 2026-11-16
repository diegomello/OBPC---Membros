@echo off
setlocal enabledelayedexpansion
title Sistema Igreja OBPC - Inicializador de Testes
echo ========================================================
echo   INICIANDO O SISTEMA - IGREJA O BRASIL PARA CRISTO
echo ========================================================
echo.

:: 1. Garantir que o Node.js padrao de C:\Program Files\nodejs esteja no PATH da sessao
set "PATH=C:\Program Files\nodejs;%APPDATA%\npm;%PATH%"

:: 2. Testar presenca do Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    if exist "C:\Program Files\nodejs\node.exe" (
        set "PATH=C:\Program Files\nodejs;%PATH%"
    ) else (
        echo [ERRO] Node.js nao foi localizado em "C:\Program Files\nodejs".
        pause
        exit /b
    )
)

echo [OK] Node.js detectado com sucesso:
node -v
echo.

echo ========================================================
echo Escolha o modo de execucao:
echo [1] Iniciar FRONTEND Completo (React + Vite na porta 5173) - Recomendado
echo [2] Iniciar TUDO (Backend API + Frontend)
echo ========================================================
set /p MODO="Digite 1 ou 2 (Padrao: 1): "
if "%MODO%"=="" set MODO=1

if "%MODO%"=="1" (
    echo.
    echo Iniciando o Front-end Web (Vite + React)...
    cd /d "%~dp0frontend"
    start "OBPC - Frontend Web" cmd /k "set PATH=C:\Program Files\nodejs;%APPDATA%\npm;%PATH% && npm install && npm run dev"
    echo.
    echo ========================================================
    echo Front-end abrindo na porta 5173!
    echo Acesse pelo navegador: http://localhost:5173
    echo ========================================================
    timeout /t 3 >nul
    start http://localhost:5173
    pause
    exit /b
)

if "%MODO%"=="2" (
    echo.
    echo [1/2] Iniciando Back-end API (Node.js + Express na porta 3001)...
    start "OBPC - Backend API" cmd /k "set PATH=C:\Program Files\nodejs;%APPDATA%\npm;%PATH% && cd /d "%~dp0backend" && npm install && npm run dev"
    
    timeout /t 4 /nobreak >nul
    
    echo [2/2] Iniciando Front-end Web (React + Vite na porta 5173)...
    start "OBPC - Frontend Web" cmd /k "set PATH=C:\Program Files\nodejs;%APPDATA%\npm;%PATH% && cd /d "%~dp0frontend" && npm install && npm run dev"
    
    echo.
    echo ========================================================
    echo Servidores iniciados!
    echo Frontend: http://localhost:5173
    echo Backend:  http://localhost:3001/api/health
    echo ========================================================
    timeout /t 3 >nul
    start http://localhost:5173
    pause
    exit /b
)

@echo off
title Sistema OBPC - Versao de Testes
echo ========================================================
echo   ABRINDO A VERSAO DE TESTES - OBPC MINAS GERAIS
echo ========================================================
echo.
echo Abrindo o ambiente de testes e demonstracao no seu navegador...
start "" "%~dp0versao_testes.html"
echo.
echo Concluido! Pode realizar todos os testes diretamente no navegador.
timeout /t 3 >nul
exit

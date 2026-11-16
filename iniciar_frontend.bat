@echo off
title OBPC - Frontend Web
echo ========================================================
echo   INICIANDO O FRONTEND (REACT + VITE)
echo ========================================================
echo.
set "PATH=C:\Program Files\nodejs;%APPDATA%\npm;%PATH%"
cd /d "%~dp0frontend"
echo Instalando dependencias e iniciando o Vite...
call npm install
call npm run dev
pause

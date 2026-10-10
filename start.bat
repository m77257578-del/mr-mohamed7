@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Starting... open http://localhost:3000
node server.js
echo.
echo The server stopped. Read the message above.
pause

@echo off
:: Scribble Launcher for Windows

:: Change to the installation directory (which is one level up from /bin)
cd /d "%~dp0.."

:: Execute the main service, passing all arguments
scribble-core.exe %*
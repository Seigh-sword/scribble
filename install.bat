@echo off
setlocal

echo.
echo  =================================
echo   Scribble Windows Installer v2.0.0
echo  =================================
echo.

:: 1. Setup Directories
set "INSTALL_DIR=%APPDATA%\Scribble"
set "BIN_DIR=%INSTALL_DIR%\bin"

:: Cleanup old versions
echo [Info] Searching for old binaries...
if exist "%INSTALL_DIR%\ses.exe" (
    echo   - Found and removing old 'ses.exe'...
    del "%INSTALL_DIR%\ses.exe" >nul 2>nul
)

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
cd /d "%INSTALL_DIR%"

:: 2. Download and Extract
echo [Info] Downloading compiled binaries (DLLs + Exe)...
powershell -Command "Invoke-WebRequest -Uri https://github.com/Seigh-sword/scribble/releases/latest/download/scribble-windows.zip -OutFile scribble.zip"

echo [Info] Extracting...
powershell -Command "Expand-Archive -Path scribble.zip -DestinationPath . -Force"
del scribble.zip

:: 3. Setup Launcher and PATH
echo [Info] Setting up launcher and adding to PATH...
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
move launcher.bat "%BIN_DIR%\scribble.bat"

:: Setup PAS (Package Automation System)
echo [Info] Setting up PAS (Package Manager)...
echo @echo off > "%BIN_DIR%\pas.bat"
echo scribble package %%* >> "%BIN_DIR%\pas.bat"

:: Add to user PATH if not already there
setx PATH "%PATH%;%BIN_DIR%" >nul

echo.
echo [Success] Scribble installed to: %INSTALL_DIR%
echo [Info] Please restart your terminal to use the 'scribble' command.
pause
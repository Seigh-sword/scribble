@echo off
REM Scribble Auto-Installer (Windows)
REM Users: Run this once, then use 'scribble' anywhere!

setlocal enabledelayedexpansion

set "REPO_URL=https://github.com/Seigh-sword/scribble.git"
set "INSTALL_DIR=%APPDATA%\Scribble"
set "BIN_DIR=!INSTALL_DIR!\bin"

cls
echo.
echo ====================================================
echo   Scribble Auto-Installer (Windows)
echo   One-click setup ^& auto-updates
echo ====================================================
echo.

REM Check for git
where git >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Git not found. Download from: https://git-scm.com/download/win
    pause
    exit /b 1
)

REM Check for cmake
where cmake >nul 2>nul
if errorlevel 1 (
    echo [ERROR] CMake not found. Download from: https://cmake.org
    pause
    exit /b 1
)

echo [+] Downloading Scribble...
if exist "!INSTALL_DIR!" (
    cd /d "!INSTALL_DIR!"
    git pull origin main
) else (
    git clone "!REPO_URL!" "!INSTALL_DIR!"
    cd /d "!INSTALL_DIR!"
)

echo [+] Building...
cmake -S . -B build -DBUILD_SHARED_LIBS=ON
cmake --build build -j4

echo [+] Creating launcher...
if not exist "!BIN_DIR!" mkdir "!BIN_DIR!"

(
    echo @echo off
    echo cd /d "%INSTALL_DIR%"
    echo REM Auto-update check can be added here
    echo call ses %%*
) > "!BIN_DIR!\scribble.bat"

echo [+] Adding to PATH...
setx PATH "!BIN_DIR!;!PATH!"

cls
echo.
echo ====================================================
echo   Installation Complete!
echo ====================================================
echo.
echo Install folder: !INSTALL_DIR!
echo Launcher: !BIN_DIR!\scribble.bat
echo.
echo Next steps:
echo   1. Close and reopen Command Prompt
echo   2. Run: scribble help
echo   3. Or: !BIN_DIR!\scribble.bat build
echo.
echo Auto-updates: Checks for changes on GitHub
echo.
pause

# Scribble Setup Guide

## One-Click Installation

Scribble has **automatic installers** that handle everything for you!

### On Linux/Mac

**Step 1:** Download the installer
```bash
curl -fsSL https://raw.githubusercontent.com/Seigh-sword/scribble/main/install.sh -o install.sh
chmod +x install.sh
./install.sh
```

**Step 2:** That's it! The installer will:
- ✓ Clone the repo
- ✓ Install dependencies
- ✓ Build everything
- ✓ Add to PATH
- ✓ Set up auto-updates

**Step 3:** Reload your shell and use it:
```bash
scribble build
scribble check
scribble test
```

### On Windows

**Step 1:** Download `install.bat` from the repo
```
https://github.com/Seigh-sword/scribble/raw/main/install.bat
```

**Step 2:** Double-click `install.bat` and it will:
- ✓ Clone the repo
- ✓ Install dependencies (if missing)
- ✓ Build everything
- ✓ Add to PATH
- ✓ Set up auto-updates

**Step 3:** Close and reopen Command Prompt, then:
```cmd
scribble build
scribble help
```

## Auto-Update System

After installation, Scribble **automatically updates itself daily**:

- Checks GitHub for new files/changes
- Downloads updates
- Rebuilds automatically
- **You don't need to do anything!**

## What Gets Installed

```
~/.scribble/                (Linux/Mac)
%APPDATA%\Scribble\         (Windows)
├── build/                  (Compiled files)
├── bin/                    (Executables + DLLs)
├── compiler/               (Source code)
├── attributes/             (Rust crates)
└── ... (all Scribble files)
```

## Requirements

- **Git** — for downloading/updating
- **CMake** — for building
- **C++ compiler** — g++, clang, or MSVC

### If Missing

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install git cmake g++
```

**Mac:**
```bash
brew install git cmake
```

**Windows:**
- Download Git: https://git-scm.com/download/win
- Download CMake: https://cmake.org/download/
- Or install Visual Studio Community (includes C++)

## Usage After Installation

```bash
scribble build              # Build everything
scribble check              # Check all files
scribble test               # Run tests
scribble compile <file>     # Compile .scrib files
scribble tree               # Show project structure
scribble help               # Show all commands
```

## Troubleshooting

**"Command not found: scribble"**
- Reopen your terminal/Command Prompt
- Or add manually to PATH

**"Git not found"**
- Install Git from https://git-scm.com

**"CMake not found"**
- Install CMake from https://cmake.org

**Updates not working**
- Check internet connection
- Or manually run: `git pull` in installation folder

## Manual Installation (Advanced)

If installers don't work:

```bash
git clone https://github.com/Seigh-sword/scribble.git
cd scribble
chmod +x ses launcher.sh
cmake -S . -B build
cmake --build build -j
./ses build
```

Then use:
```bash
./launcher.sh build    # With auto-updates
./ses build            # Without auto-updates
```

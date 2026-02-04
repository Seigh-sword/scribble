# 🚀 Download Scribble v2.0.0

## For Users (Easiest Way!)

You only need **ONE file**. Choose your operating system:

### 📱 **Linux / Mac Users**
Download and run:
```bash
curl -fsSL https://raw.githubusercontent.com/Seigh-sword/scribble/main/install.sh -o install.sh
chmod +x install.sh
./install.sh
```

That's it! ✓ Auto-downloaded ✓ Auto-built ✓ Auto-updates daily

### 🪟 **Windows Users**
1. Download: [install.bat](https://github.com/Seigh-sword/scribble/raw/main/install.bat)
2. Double-click it
3. Done! ✓ Auto-downloaded ✓ Auto-built ✓ Auto-updates daily

## What Happens

The installer will:
1. **Download** Scribble from GitHub
2. **Build** the compiler
3. **Install** globally (so you can use `scribble` anywhere)
4. **Auto-update** daily if there are changes

## Requirements

You need:
- **Git** (download from git-scm.com)
- **CMake** (download from cmake.org)
- **C++ compiler** (comes with most systems)

## First Use

After installation, open a terminal and run:
```bash
scribble help           # Show all commands
scribble build          # Build
scribble execute check  # Check files
scribble execute test   # Run tests
```

## Auto-Updates

Every 24 hours, when you run `scribble`:
- ✓ Checks GitHub for changes
- ✓ Downloads updates automatically
- ✓ Rebuilds silently
- **You don't need to do anything!**

## For Developers

Want to contribute? Clone the full repo:
```bash
git clone https://github.com/Seigh-sword/scribble.git
cd scribble
./launcher.sh build    # With auto-updates
```

See [SETUP.md](SETUP.md) for more details.

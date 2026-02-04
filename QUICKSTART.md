# 🎯 Scribble Quick Start

## TL;DR (Super Quick)

```bash
# Linux/Mac: Copy & paste ONE line
curl -fsSL https://raw.githubusercontent.com/Seigh-sword/scribble/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh

# Windows: Download and double-click
# https://github.com/Seigh-sword/scribble/raw/main/install.bat
```

**That's literally it!** 🎉

---

## What You're Getting

```
Scribble = Your Own Programming Language
├── 🟦 Compiler (scribblec)
│   └── Turns .scrib files into C++, C, or Assembly
├── ⚡ 6 Superpowers
│   ├── time (dates, clocks)
│   ├── system (files, folders, OS)
│   ├── canvas (drawing, graphics)
│   ├── math (calculations)
│   ├── string (text)
│   └── file (read/write)
├── 🦀 Built-in Rust (FAST!)
├── 📦 Pre-compiled Binaries (No building!)
└── 💻 Works everywhere (Windows, Mac, Linux)
```

---

## Your First Scribble Program

Create `hello.scrib`:
```scrib
output["Hello, Scribble!"]
```

Compile it:
```bash
scribble compile hello.scrib --lang cpp
```

That's your program! It can be compiled to:
- **C++** (slow but simple)
- **C** (faster)
- **Assembly** (super fast, for speed demons)

---

## After Installation

All these commands work:

```bash
scribble build              # Build compiler
scribble check              # Check everything
scribble test               # Run tests  
scribble compile <file>     # Compile .scrib files
scribble tree               # See project structure
scribble lint               # Check for errors
scribble clean              # Remove build files
scribble help               # Show all commands
scribble version            # Show version
```

---

## How Auto-Updates Work

```
Every time you run scribble:
1. It checks GitHub silently
2. If there's something new, it downloads
3. It rebuilds automatically
4. You use the newest version

📚 You don't press any buttons!
```

---

## System Requirements

✓ Internet connection (for first download + auto-updates)
✓ Git (comes with most systems)
✓ CMake (easy to install)
✓ C++ compiler (probably already installed)

Missing something? The installer will tell you!

---

## File Structure After Install

```
~/.scribble/              (Mac/Linux)
 or
%APPDATA%\Scribble\       (Windows)
│
├── bin/
│   ├── scribble          ← Use this!
│   └── scribblec         ← The compiler
├── build/                ← Compiled files
├── compiler/             ← Source code
├── attributes/           ← Rust fast parts
├── headers/              ← API descriptions
└── ... (all Scribble files)
```

---

## Next Steps

1. ✓ Run installer (takes 2 mins)
2. ✓ Try: `scribble help`
3. ✓ Build something cool
4. ✓ Share it with friends!

---

## Questions?

- **How do I install?** → See [DOWNLOAD.md](DOWNLOAD.md)
- **How do I use it?** → See [COMMANDS.md](COMMANDS.md)
- **Need help?** → See [SETUP.md](SETUP.md)
- **Want to code?** → See [README.md](README.md)

---

**Enjoy your programming language!** 🚀

# Changelog

All notable changes to this project will be documented in this file.

## [v2.0.0]

###  Major Changes
- **Binary Distribution**: Scribble now ships as pre-compiled binaries. Users no longer need `git`, `cmake`, or a C++ compiler to run Scribble.
- **New License**: Introduced **Scribble License v2.0**.
  - Remains free for all human users.
  - Explicitly permits AI/LLMs to use and generate Scribble code in paid services.
- **Cross-Platform Installers**:
  - `install.sh`: One-line installer for Linux and macOS.
  - `install.bat`: Double-click installer for Windows.

###  New Features
- **Unified CLI**: The `scribble` command is now the standard entry point, wrapping the internal `scribble-core` tool.
- **Rust Attributes**: Core libraries (`time`, `file`, `system`) are now fully integrated as compiled shared libraries for maximum performance.
- **Auto-Update Infrastructure**: Launchers are equipped to check for and download updates automatically.

###  Documentation
- **Revamped Guides**: Complete rewrite of `README.md`, `QUICKSTART.md`, and `SETUP.md` to reflect the binary-first approach.
- **New Commands Guide**: Added `COMMANDS.md` detailing all available CLI operations.

###  Improvements
- Removed complex build requirements for end-users.
- Improved Windows support with native `.bat` launchers and DLL handling.
- Fixed path resolution for global installation.
- **Internal Rename**: Replaced `ses` with `scribble-core`.
# Contributing to Scribble

First off, thank you for considering contributing to Scribble! It's people like you that make open source great.

## How Can I Contribute?

- **Reporting Bugs:** If you find a bug, please open an issue and describe it in detail.
- **Suggesting Enhancements:** Have an idea for a new feature? Open an issue to discuss it.
- **Writing Code:** If you want to fix a bug or implement a feature, this guide is for you!

## Development Setup

Unlike end-users, developers need the build toolchain to compile Scribble from the source code.

### Prerequisites

You will need the following tools installed on your system:
- **Git:** For version control.
- **CMake (v3.13+):** For building the C++ core.
- **A C++ Compiler:**
  - **Linux:** `g++`
  - **macOS:** `clang` (via Xcode Command Line Tools)
  - **Windows:** `MSVC` (via Visual Studio Community)
- **Rust:** For building the performance-critical attributes. Install it via rustup.

### Recommended Environment

For a quick and consistent setup, we highly recommend using **GitHub Codespaces**. It provides a pre-configured cloud environment with all the necessary tools installed.

If you prefer to work on your local machine, please ensure all the prerequisites listed above are installed correctly.

### Build Steps

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Seigh-sword/scribble.git
    cd scribble
    ```

2.  **Configure the build with CMake:**
    This creates a `build` directory with all the necessary build files.
    ```bash
    cmake -S . -B build
    ```

3.  **Compile everything:**
    This builds the C++ core and all the Rust attributes (`.so`, `.dylib`, `.dll`).
    ```bash
    cmake --build build
    ```

    The main executable will be located at `build/compiler/ses` (or `build/compiler/Release/ses.exe` on Windows). This is the internal binary that gets packaged as `scribble-core` in official releases.

### Contribution Workflow

1.  **Fork** the repository on GitHub.
2.  Create a new **branch** for your changes.
3.  Make your changes. Please run the checks before committing!
    ```bash
    # Check for code style issues and other problems
    ./launcher.sh execute check

    # Run all tests
    ./launcher.sh execute test
    ```
4.  **Commit** your changes with a clear message.
5.  **Push** your branch to your fork.
6.  Open a **Pull Request** from your fork to the main Scribble repository.
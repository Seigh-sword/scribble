# Scribble v2.0.0

![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)
![License](https://img.shields.io/badge/license-Scribble_Free-green.svg)

Scribble is an experimental polyglot language/runtime for beginners and hobbyists that mixes Python-like syntax with C, C++, assembly, and Rust "attributes" for performance-critical parts.

File extension: `.scrib`

## Quick Start

```bash
scribble build    # Build compiler
scribble execute check    # Check all files
scribble execute test     # Run tests
scribble compile examples/hello.scrib --lang cpp
```

See `COMMANDS.md` for full documentation.

## Language Features

Printing example:

```scrib
output["hello, world!"]
```

Comments:

```
>> This is a comment <<
```

Loops (conceptual):

```
<loop>
[code]
<loop>
repeat = 5
```

## Architecture

Headers & Attributes
- `headers/` holds Scribble header files (metadata and API descriptions).
- `attributes/` holds Rust crates that implement fast primitives referenced by headers.

Example layout:

- `headers/canvas.header` — describes the `canvas` API
- `attributes/canvas/` — Rust crate implementing the canvas attribute

Compiler Structure
- `compiler/include/` — C++ headers (lexer, parser, codegen)
- `compiler/src/` — C++ implementation
- Runtime example in `src/` (mixed C/C++/assembly)

## Build System

- **CMakeLists.txt** — Main build configuration
- **compiler/CMakeLists.txt** — Compiler-specific config
- **attributes/*/Cargo.toml** — Rust crate configs

## Commands

```bash
scribble build              # Build compiler and runtime
scribble execute check      # Comprehensive code checker
scribble execute test       # Run test suite
scribble execute lint       # Check code style
scribble compile            # Compile .scrib files
scribble execute tree       # Show project structure
scribble execute clean      # Remove build artifacts
scribble package-lib        # Package a library for distribution
pas install <lib>           # Install a library (Packaged And Scribble)
scribble help               # Show help
scribble version            # Show version
```

## Next Steps

- Add GitHub Actions CI for automated builds/tests
- Expand `.scrib` language features and examples
- Integrate graphics/canvas rendering
- Create language documentation and tutorials

## License

**Scribble is free for everyone.**

- You can use it in your apps and websites for free. without any dev permissions
- You should **not** charge people to use the compiler. **WE RECOMMEND IT BEING FREE**
- AI tools (AI LLMs) are allowed to use/write Scribble even if they are paid services.

See **[LICENSE](https://github.com/Seigh-sword/scribble?tab=License-1-ov-file)** for details.

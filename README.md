# Scribble

Scribble is an experimental polyglot language/runtime for beginners and hobbyists that mixes Python-like syntax with C, C++, assembly, and Rust "attributes" for performance-critical parts.

File extension: `.scrib`

## Quick Start

```bash
./scs build    # Build compiler
./scs check    # Check all files
./scs test     # Run tests
./scs compile examples/hello.scrib --lang cpp
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

## Commands (via scs - Scribble Code Service)

```bash
./scs build      # Build compiler and runtime
./scs check      # Comprehensive code checker
./scs test       # Run test suite
./scs lint       # Check code style
./scs compile    # Compile .scrib files
./scs tree       # Show project structure
./scs clean      # Remove build artifacts
./scs help       # Show help
./scs version    # Show version
```

## Next Steps

- Add GitHub Actions CI for automated builds/tests
- Expand `.scrib` language features and examples
- Integrate graphics/canvas rendering
- Create language documentation and tutorials

# V vs Zig vs C3

Comprehensive comparison of three modern systems programming languages that evolve the C programming model: V (Vlang), Zig, and C3. This repository collects compiler-validated examples, a benchmark harness for example-driven performance comparison, and practical notes on trade-offs.

Quick links
- Examples: ./examples/ (12 topics, each with V, Zig, C3 variants)
- Benchmarks: ./results/bench_results.md
- Harness: ./scripts/bench_examples.sh

## Get Started
1. **Install Compilers**: Ensure `v`, `zig`, and `c3c` are in your PATH.
2. **Verify Setup**: Run `./test_all.sh` to make sure all examples compile and run.
3. **Run Benchmarks**: Execute `./scripts/bench_examples.sh` and check `results/bench_results.md`.

Table of contents
- [Overview & philosophy](#overview)
- [Feature comparison](#feature-comparison)
- [Build & run instructions](#build--run-short)
- [Context performance](#how-the-benchmark-works)
- [Contributing & adding examples](#adding-a-new-example)
- [References](#references)

Goals
- Provide side-by-side examples across V, Zig, and C3 to compare language ergonomics and semantics.
- Produce reproducible, example-driven context performance measurements.
- Offer practical migration notes for C developers considering each language.

Requirements
- POSIX-like environment (Linux/macOS). Tested on Linux.
- Optional compilers on PATH to build language variants:
  - v (V) — https://vlang.io
  - zig (Zig) — https://ziglang.org
  - c3c (C3) — https://c3-lang.org
- /usr/bin/time is preferred for accurate timing; otherwise the script uses a coarse fallback.

Examples layout
- examples/<NN_topic>/ contains files named <topic>.v, <topic>.zig, <topic>.c3 and sometimes prebuilt executables.
- Each directory targets the same small program or behavior (hello world, arrays, enums, etc.) so outputs and semantics are comparable.

### Project Structure
```
.
├── examples/            # Side-by-side code examples (V, Zig, C3)
│   └── NN_topic/        # e.g., 01_hello_world, 06_generic_stack
├── results/             # Benchmark results and analysis
│   └── bench_results.md
├── scripts/             # Automation tools
│   └── bench_examples.sh # Performance harness
└── test_all.sh          # Validation script to run all examples
```

Build & run (short)
To run a specific example manually, create a `bin` directory first: `mkdir -p bin`.
- **V**: `v -o bin/myprog examples/01_hello_world/hello.v && ./bin/myprog`
- **Zig**: `zig build-exe -O ReleaseFast -femit-bin=bin/myprog examples/01_hello_world/hello.zig && ./bin/myprog`
- **C3**: `c3c -o bin/myprog examples/01_hello_world/hello.c3 && ./bin/myprog`

Notes
- Some examples rely on small inputs (examples/04_file_io/input.txt). Benchmarks discard program output when timing.
- Binaries are written to .build/<lang>/ by the harness. Build flags aim for release-like timings; adjust in the script if needed.

How the benchmark works
- scripts/bench_examples.sh scans each topic folder, compiles available sources (v/zig/c3) when compiler is available, runs each executable N times (default 5), averages wall-clock times, and writes results/bench_results.md.
- The harness captures failures (missing compiler, build failure) and lists prebuilt executables found in example folders.
- Caveats: wall-clock includes process startup and I/O; for microbenchmarks prefer in-language benchmarking harnesses. System noise, CPU frequency scaling, and background load affect results.

Reproducing a focused benchmark
1. Install compilers and ensure they are on PATH.
2. Make script executable: chmod +x ./scripts/bench_examples.sh
3. Run with desired runs: ./scripts/bench_examples.sh 10
4. Inspect results/bench_results.md

Adding a new example
1. Create a new directory examples/NN_description/.
2. Add files: description.v, description.zig, description.c3 implementing equivalent behavior.
3. Optionally include small input files under that directory.
4. Run the harness to include the topic in results.

Validation & tests
- **Automated Validation**: Run `./test_all.sh` to compile and run every example in the repository to ensure they still work.
- **Note**: The harness and test script only build and time programs; they do not perform semantic equivalence checks between languages. For CI, consider adding language-specific test runners.

Contribution guidelines
- Prefer small, focused examples that demonstrate one concept per topic.
- Follow existing naming: two-digit prefix for ordering (01_hello_world) and matching basenames across languages.
- When adding new examples, include minimal README notes inside the example folder if special build steps or inputs are required.

License
- Most content in this repo follows MIT. Check individual language implementations for their own licenses.

Contact / Maintainers
- Repository: naranyala/between-v-zig-c3
- Open issues or PRs for improvements, corrected examples, or performance runs.

Reference comparisons (feature tables retained below)

## Overview

| | **V (Vlang)** | **Zig** | **C3** |
|---|---|---|---|
| **Website** | [vlang.io](https://vlang.io) | [ziglang.org](https://ziglang.org) | [c3-lang.org](https://c3-lang.org) |
| **GitHub** | [vlang/v](https://github.com/vlang/v) | [Codeberg](https://codeberg.org/ziglang/zig) | [c3lang/c3c](https://github.com/c3lang/c3c) |
| **Stars** | 37.7k | 43.2k | 5.6k |
| **Version** | 0.5.1 | 0.16.0 | 0.8.1 |
| **License** | MIT | MIT | MIT / LGPL-3.0 |
| **Creator** | Alexander Medvednikov | Andrew Kelley | Christoffer Lernö |
| **Written In** | V (self-hosting) | Zig (self-hosting) | C (compiler) |
| **Tagline** | Simple, fast, safe, compiled | Robust, optimal, reusable | The ergonomic, safe, familiar evolution of C |

## Feature Comparison

### Memory Management

| Feature | V | Zig | C3 |
|---|---|---|---|
| Default GC | Yes (tracing) | No | No |
| Manual memory | `-gc none` | Default | Default |
| Autofree | Experimental | N/A | N/A |
| Arena allocation | `-prealloc` | Allocator pattern | N/A |
| Defer | No | `defer`/`errdefer` | `defer` |

### Error Handling

| Feature | V | Zig | C3 |
|---|---|---|---|
| Model | Option/Result | Error unions | Optionals + faults |
| Null safety | No null by default | Optional types | `?` type |
| Panic-free | Partial | Yes | Yes (safe mode) |
| Stack traces | No | No (default) | Yes (debug) |

### Metaprogramming

| Feature | V | Zig | C3 |
|---|---|---|---|
| Generics | Yes | Via `comptime` | Generic modules |
| Compile-time exec | Limited | `comptime` | Yes |
| Reflection | Limited | `@typeInfo` | Compile + runtime |
| Macros | No | No (comptime) | Semantic macros |
| Operator overloading | Yes | Yes | Yes |

### Type System

| Feature | V | Zig | C3 |
|---|---|---|---|
| Sum types | Yes | No | Yes (faults) |
| Tagged unions | Yes | Yes | No |
| Type inference | `:=` | `var`/`const` | Limited |
| Immutability default | Yes | `const` | No |
| Distinct types | No | No | `typedef` |
| Slices | Yes | Yes | Yes |
| SIMD vectors | No | Yes | Yes |

## FFI & C Interoperability

| Aspect | V | Zig | C3 |
|---|---|---|---|
| C ABI compatible | Yes | Yes | Yes (full) |
| C header import | Manual | Auto (`@cImport`) | Module system |
| C code compilation | No | Yes (`zig cc`) | No |
| C → Target translation | Yes (c2v) | No | No (planned) |
| C++ support | Limited | Yes | No |
| Memory model compat | Partial (GC) | Full (manual) | Full (manual) |

**Key insight:** Zig has the most mature C interop — it can compile C code directly. C3 has the purest ABI compatibility — mix C and C3 in one project with zero wrappers. V can translate entire C codebases via c2v.

## C Ecosystem Integration

| Tool | C | V | Zig | C3 |
|---|---|---|---|---|
| Valgrind | Native | Via C backend | Native | Native |
| AddressSanitizer | Native | Via C compiler | Native | Via LLVM |
| GDB/LLDB | Native | Via C output | Native | Native |
| perf | Native | Works | Works | Works |
| pkg-config | Native | Limited | Via build.zig | Via CMake |

## "Better C" Scorecard

| C Pain Point | V | Zig | C3 |
|---|---|---|---|
| Header hell | Solved (modules) | Solved (imports) | Solved (modules) |
| Preprocessor | Eliminated | Eliminated (comptime) | Replaced (semantic) |
| Null bugs | Eliminated (optionals) | Mitigated | Mitigated (`?`) |
| Buffer overflows | Solved (bounds check) | Solved (bounds check) | Solved (safe mode) |
| Manual memory | Partial (GC default) | Explicit (allocator) | Explicit (manual) |
| Undefined behavior | Mostly eliminated | Mostly eliminated | Partially (safe mode) |
| No build system | Solved (built-in) | Solved (`zig build`) | No (CMake) |
| No package manager | Solved (vpm) | Partial | No |
| Verbose error handling | Solved | Solved (comptime) | Solved (optionals/faults) |
| No generics | Solved | Solved (comptime) | Solved (generic modules) |
| No cross-compilation | Solved (easy) | Solved (excellent) | Basic |
| No testing | Solved (built-in) | Solved (built-in) | Solved (built-in) |
| No defer | No | Yes | Yes |
| No contracts | No | No | Yes |
| No reflection | Limited | Yes (comptime) | Yes (compile+runtime) |

## Design Principles

### V
1. **Simplicity** — Learnable in a weekend, only one way to do things
2. **No undefined behavior** — Bounds checking, no null, no variable shadowing
3. **Immutability default** — Variables/structs immutable unless marked `mut`
4. **Fast compilation** — Self-compiles in <1 second
5. **C as backbone** — Compiles to human-readable C
6. **Minimal dependencies** — Single binary, no build environments
7. **Flexible memory** — GC, autofree, manual, or arena

### Zig

1. **No hidden control flow** — No exceptions, hidden allocations, implicit casts
2. **No hidden memory** — Every allocation explicit via allocator parameter
3. **No preprocessor/macros** — `comptime` replaces both
4. **Robustness over performance** — Debug checks everything; release optimizes
5. **Incremental improvement** — Add Zig to C/C++ projects one file at a time
6. **Cross-compilation first** — Targets every platform from any platform
7. **Reader-oriented** — Code optimized for reading, not writing

### C3
1. **Evolution, not revolution** — Stay close to C, change only what's necessary
2. **C ABI compatibility** — Mix C and C3 with zero friction
3. **Procedural mindset** — "Get things done" language, not academic
4. **Familiarity** — Minimal learning curve for C programmers
5. **Data is inert** — Avoid "big ideas" and "more is better" fallacy
6. **Safety where it matters** — Runtime checks in debug, contracts for pre/post
7. **No header files** — Module system replaces `#include`

## Pros and Cons

### V

| Pros | Cons |
|---|---|
| Simplest syntax (learnable weekend) | Pre-1.0, APIs may change |
| Fastest compilation (~400k loc/s) | Autofree experimental |
| Built-in web/GUI/ORM/JSON | GC overhead (must opt-out) |
| C translation (c2v) | Limited metaprogramming |
| Hot code reloading | Smaller ecosystem than C |
| REPL for scripting | Less low-level control |
| Cross-compilation via flags | C backend dependency |

### Zig

| Pros | Cons |
|---|---|
| Comptime power | Steep learning curve |
| Best cross-compilation | Verbose syntax |
| Drop-in C/C++ compiler | No package manager (centralized) |
| Explicit allocators | No built-in web/GUI |
| Robust error handling | Slower compilation |
| Production adoption (Bun, TigerBeetle) | No GC option |
| ZSF non-profit governance | Unstable API |

### C3

| Pros | Cons |
|---|---|
| Full C ABI compatibility | Smallest community |
| Familiar C syntax | Not self-hosted |
| No header files (modules) | No package manager |
| Semantic macros | Limited ecosystem |
| Generic modules | No built-in web/GUI |
| Contracts (pre/post conditions) | CMake build system |
| Detailed stack traces (debug) | No cross-compilation from non-native |

## Performance vs C

| Scenario | C | V | Zig | C3 |
|---|---|---|---|---|
| CPU-bound | 100% | ~95-100% | ~100% | ~100% |
| Memory-heavy | 100% | ~80-90% (GC) | ~100% | ~100% |
| I/O bound | 100% | ~95% | ~100% | ~100% |
| Compilation speed | Baseline | Much faster | Slower (comptime) | Moderate |

**When C still wins:** Startup time, minimal binary size, embedded systems, legacy hardware, extreme optimization.

**When V/Zig/C3 match C:** With `-O3`, manual memory (V: `-gc none`, Zig/C3: default), proper compiler flags.

## Real-World Adoption

| Language | Notable Projects | Domain |
|---|---|---|
| **V** | Volt (Slack client), Ved (editor), Vinix (OS) | Desktop, editor, OS |
| **Zig** | Bun (JS runtime), TigerBeetle (DB), Mach Engine | Runtime, database, game engine |
| **C3** | vkQuake (partial port) | Game engine |

## Migration from C

| Aspect | C → V | C → Zig | C → C3 |
|---|---|---|---|
| Syntax changes | High (Go-like) | High (unique) | Low (C-like) |
| Memory model | High (GC) | Medium (allocators) | Low (same) |
| Error handling | High (option/result) | High (error unions) | Medium (optionals) |
| Build system | High (new) | High (new) | Low (CMake) |
| Library reuse | Medium (c2v) | High (@cImport) | High (extern) |
| Time to productivity | Days | Weeks | Hours |

## Decision Matrix

| Use Case | Recommended | Why |
|---|---|---|
| New project, no C legacy | V or Zig | V for simplicity, Zig for power |
| Existing C codebase | C3 or Zig | C3 for minimal changes, Zig for tooling |
| Web application | V | Built-in web framework |
| Game engine | Zig or C3 | Zig for tooling, C3 for C compat |
| Operating system | Zig | Best cross-compilation, explicit memory |
| Library for C consumers | C3 | Purest C ABI compatibility |
| Prototyping | V | Fastest compilation, simplest syntax |
| Production system | Zig or C | Zig for modern features, C for maturity |

## Summary

| | V | Zig | C3 |
|---|---|---|---|
| **Learning Curve** | Easy | Moderate | Easy (for C devs) |
| **Syntax Style** | Go-like | Unique | C-like |
| **Best For** | General purpose, web, prototyping | Systems, OS, cross-compilation | C replacement, incremental migration |
| **Key Strength** | Simplicity + speed | Comptime + tooling | C compatibility + familiarity |
| **Biggest Weakness** | Pre-1.0, less low-level | Steep learning curve | Small community |
| **FFI Quality** | Good | Excellent | Excellent (purest C compat) |
| **Memory Safety** | GC + optional manual | Manual only | Manual only |
| **Production Ready** | Emerging | Emerging | Emerging |

---

## Context performance (real examples)

This repository includes a small benchmark harness that builds (when compilers are available) and runs the examples in ./examples to compare runtime (wall-clock) between V, Zig, and C3. Results are written to results/bench_results.md.

To run the benchmark:

1. Ensure compilers/tools are installed and on PATH: `v` (V), `zig` (Zig), `c3c` (C3). If a compiler is missing, the script will skip that language and will attempt to run any prebuilt binaries found in each example directory.

2. Run:

    ./scripts/bench_examples.sh [runs]

   where `[runs]` (optional) is the number of runs to average (default: 5). Example:

    ./scripts/bench_examples.sh 5

3. View results:

    results/bench_results.md

Sample output is written to `results/bench_results.md` when available. The script is safe to run repeatedly; build artifacts are written to `.build/`.

---

## References

- [Comparison of programming languages](https://en.wikipedia.org/wiki/Comparison_of_programming_languages)
- [Systems programming language](https://en.wikipedia.org/wiki/Systems_programming_language)
- [Memory management](https://en.wikipedia.org/wiki/Memory_management)
- [Garbage collection (computer science)](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science))
- [Manual memory management](https://en.wikipedia.org/wiki/Manual_memory_management)
- [Undefined behavior](https://en.wikipedia.org/wiki/Undefined_behavior)
- [Error handling](https://en.wikipedia.org/wiki/Error_handling)
- [Option type (nullable/optional)](https://en.wikipedia.org/wiki/Nullable_type)
- [Algebraic data type](https://en.wikipedia.org/wiki/Algebraic_data_type)
- [Discriminated union](https://en.wikipedia.org/wiki/Discriminated_union)
- [Generics (generic programming)](https://en.wikipedia.org/wiki/Generic_programming)
- [Type inference](https://en.wikipedia.org/wiki/Type_inference)
- [Reflection (computer science)](https://en.wikipedia.org/wiki/Reflection_(computer_science))
- [Metaprogramming](https://en.wikipedia.org/wiki/Metaprogramming)
- [Design by contract](https://en.wikipedia.org/wiki/Design_by_contract)
- [Concurrency (computer science)](https://en.wikipedia.org/wiki/Concurrency_(computer_science))
- [Null safety](https://en.wikipedia.org/wiki/Null_safety)
- [Foreign function interface](https://en.wikipedia.org/wiki/Foreign_function_interface)
- [Application binary interface](https://en.wikipedia.org/wiki/Application_binary_interface)
- [Cross-compilation](https://en.wikipedia.org/wiki/Cross-compilation)
- [Package manager (software)](https://en.wikipedia.org/wiki/Package_manager)
- [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop)
- [Hot swapping (hot code reloading)](https://en.wikipedia.org/wiki/Hot_swapping)
- [Stack trace](https://en.wikipedia.org/wiki/Stack_trace)
- [SIMD](https://en.wikipedia.org/wiki/SIMD)
- [C (programming language)](https://en.wikipedia.org/wiki/C_(programming_language))
- [Zig (programming language)](https://en.wikipedia.org/wiki/Zig_(programming_language))
- [V (programming language)](https://en.wikipedia.org/wiki/V_(programming_language))

---

*Last updated: July 2026*

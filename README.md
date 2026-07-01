# V vs Zig vs C3

A comparison of three modern systems programming languages that aim to improve upon C with better safety, performance, and developer experience.

> **Code examples:** See [`examples/`](./examples/) — 12 compiler-validated examples (36 source files) across V, Zig, and C3.

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

## Philosophy

| Language | Core Idea | Approach |
|---|---|---|
| **V** | Simplicity above all | Learnable in a weekend, one way to do things, GC by default |
| **Zig** | No hidden anything | No hidden control flow, allocations, or preprocessor |
| **C3** | Evolution of C | Stay close to C, only change what's necessary |

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

### Compilation & Build

| Feature | V | Zig | C3 |
|---|---|---|---|
| Speed | ~400k loc/s | Moderate | Moderate |
| Cross-compilation | Easy | Excellent | Basic |
| Output targets | C, JS, WASM | Native, C, LLVM IR | Native (LLVM) |
| Self-hosting | Yes | Yes | No (C compiler) |
| Build system | Built-in (`v .`) | Built-in (`zig build`) | CMake |
| Package manager | vpm | build.zig.zon | None |

### Standard Library

| Feature | V | Zig | C3 |
|---|---|---|---|
| Scope | Large (web, GUI, ORM) | Minimal, complete | Moderate |
| Web framework | Built-in (Veb) | No | No |
| GUI library | V UI | No | No |
| Testing | Built-in | Built-in | Built-in |

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
| Verbose error handling | Solved (option/result) | Solved (error unions) | Solved (optionals/faults) |
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

*Last updated: July 2026*

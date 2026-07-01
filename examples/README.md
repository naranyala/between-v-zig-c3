# V vs Zig vs C3 — Tested Examples

Real, compiler-validated code examples comparing V, Zig, and C3 side by side.

## Prerequisites

Install all three compilers:

| Compiler | Install |
|---|---|
| **V** | `git clone --depth=1 https://github.com/vlang/v && cd v && make` |
| **Zig** | https://ziglang.org/download/ |
| **C3** | https://github.com/c3lang/c3c/releases |

## Examples

### 01 — Hello World
Simplest program in each language.

```bash
v run hello.v
zig run hello.zig
c3c compile hello.c3 && ./hello
```

### 02 — Struct with Methods
Define a struct and attach methods to it.

```bash
v run user.v
zig run user.zig
c3c compile user.c3 && ./user
```

### 03 — Error Handling
Optionals, error unions, and faults for division-by-zero.

```bash
v run error.v
zig run error.zig
c3c compile error.c3 && ./error
```

### 04 — File I/O
Read a file and print its contents.

```bash
v run file_io.v
zig run file_io.zig
c3c compile file_io.c3 && ./file_io
```

### 05 — JSON Parsing
Decode a JSON string into a struct.

```bash
v run json.v
zig run json.zig
c3c compile json.c3 && ./json
```

### 06 — Generic Stack
Implement a generic stack data structure.

```bash
v run stack.v
zig run stack.zig
c3c compile stack.c3 && ./stack
```

### 07 — C Interop (qsort)
Use C standard library `qsort` from each language.

```bash
v run qsort.v
zig run qsort.zig
c3c compile qsort.c3 && ./qsort
```

### 08 — FFI (malloc/free)
Call C standard library functions directly.

```bash
v run malloc.v
zig run malloc.zig
c3c compile malloc.c3 && ./malloc
```

### 09 — Arrays
Array declaration, iteration, slicing, and sorting.

```bash
v run arrays.v
zig run arrays.zig
c3c compile arrays.c3 && ./arrays
```

### 10 — Concurrency (Threads)
Multi-threaded execution with worker functions.

```bash
v run threads.v
zig run threads.zig
c3c compile threads.c3 && ./threads
```

### 11 — Enums
Enum declaration, switching, and values.

```bash
v run enums.v
zig run enums.zig
c3c compile enums.c3 && ./enums
```

### 12 — Maps
Map/dictionary creation, access, and modification.

```bash
v run maps.v
zig run maps.zig
c3c compile maps.c3 && ./maps
```

## Expected Output

| Example | Expected Output |
|---|---|
| hello | `Hello, World!` |
| user | `Hello, my name is Alice` |
| error | `Result: 5` |
| file_io | `Hello from file!` |
| json | `name: Alice, age: 30` |
| stack | `popped: 30` / `popped: 20` / `popped: 10` |
| qsort | `1 2 5 8 9` |
| malloc | `allocated 100 bytes at ...` / `freed memory` |
| arrays | Array operations with sorting and contains |
| threads | Worker threads executing iterations |
| enums | Enum values and switch statements |
| maps | Map operations (V/Zig: full maps, C3: simulated) |

## Directory Structure

```
examples/
├── README.md
├── input.txt                  # Shared input for file I/O
├── 01_hello_world/
│   ├── hello.v
│   ├── hello.zig
│   └── hello.c3
├── 02_struct_methods/
│   ├── user.v
│   ├── user.zig
│   └── user.c3
├── 03_error_handling/
│   ├── error.v
│   ├── error.zig
│   └── error.c3
├── 04_file_io/
│   ├── file_io.v
│   ├── file_io.zig
│   └── file_io.c3
├── 05_json/
│   ├── json.v
│   ├── json.zig
│   └── json.c3
├── 06_generic_stack/
│   ├── stack.v
│   ├── stack.zig
│   └── stack.c3
├── 07_c_interop/
│   ├── qsort.v
│   ├── qsort.zig
│   └── qsort.c3
├── 08_ffi_malloc/
│   ├── malloc.v
│   ├── malloc.zig
│   └── malloc.c3
├── 09_arrays/
│   ├── arrays.v
│   ├── arrays.zig
│   └── arrays.c3
├── 10_concurrency/
│   ├── threads.v
│   ├── threads.zig
│   └── threads.c3
├── 11_enums/
│   ├── enums.v
│   ├── enums.zig
│   └── enums.c3
└── 12_maps/
    ├── maps.v
    ├── maps.zig
    └── maps.c3
```

## Notes

- All examples tested with V 0.5.x, Zig 0.16.0, C3 0.8.1
- C3 uses `c3c compile` (not `c3c run`) for most examples
- Each example is self-contained with minimal external dependencies
- C3 maps example uses simulated maps (no built-in HashMap in stdlib)

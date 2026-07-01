#!/usr/bin/env bash
set -euo pipefail

FAILED=0
PASSED=0

SUBDIRS=(
    01_hello_world
    02_struct_methods
    03_error_handling
    04_file_io
    05_json
    06_generic_stack
    07_c_interop
    08_ffi_malloc
    09_arrays
    10_concurrency
    11_enums
    12_maps
)

cd "$(dirname "$0")/examples"

echo "Testing all examples..."
echo "======================="

for dir in "${SUBDIRS[@]}"; do
    echo "--- $dir ---"
    if [[ "$dir" == "04_file_io" && ! -f "$dir/input.txt" ]]; then
        echo "Hello from file!" > "$dir/input.txt"
    fi

    pushd "$dir" > /dev/null || exit

    # V
    for f in *.v; do
        [[ -f "$f" ]] || continue
        if output=$(v run "$f" 2>&1); then
            if [[ -n "$output" ]]; then
                PASSED=$((PASSED + 1))
            else
                FAILED=$((FAILED + 1))
                echo "  V $dir/$f: FAIL (empty output)"
            fi
        else
            FAILED=$((FAILED + 1))
            echo "  V $dir/$f: FAIL"
            echo "    $output" | head -3
        fi
    done

    # Zig
    for f in *.zig; do
        [[ -f "$f" ]] || continue
        if output=$(zig run "$f" 2>&1); then
            if [[ -n "$output" ]]; then
                PASSED=$((PASSED + 1))
            else
                FAILED=$((FAILED + 1))
                echo "  Zig $dir/$f: FAIL (empty output)"
            fi
        else
            FAILED=$((FAILED + 1))
            echo "  Zig $dir/$f: FAIL"
            echo "    $output" | head -3
        fi
    done

    # C3
    for f in *.c3; do
        [[ -f "$f" ]] || continue
        name="$(basename "$f" .c3)"
        if output=$(c3c compile-run "$f" 2>&1); then
            output=$(echo "$output" | grep -v 'Program linked\|Program completed\|Launching\|\./')
            if [[ -n "$output" ]]; then
                PASSED=$((PASSED + 1))
            else
                FAILED=$((FAILED + 1))
                echo "  C3 $dir/$f: FAIL (empty output)"
            fi
        else
            FAILED=$((FAILED + 1))
            echo "  C3 $dir/$f: FAIL (compilation error)"
            echo "    $output" | head -3
        fi
    done

    popd > /dev/null || exit
done

echo "======================="
echo "Results: $PASSED passed, $FAILED failed"

if [[ $FAILED -gt 0 ]]; then
    exit 1
fi

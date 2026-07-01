#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EXAMPLES_DIR="$ROOT/examples"
BUILD_DIR="$ROOT/.build"
RESULTS_DIR="$ROOT/results"
mkdir -p "$BUILD_DIR/v" "$BUILD_DIR/zig" "$BUILD_DIR/c3" "$RESULTS_DIR"

RUNS=${1:-5}
TMP_OUT="/tmp/bench_times.$$"
RESULT_MD="$RESULTS_DIR/bench_results.md"

echo "# Examples benchmark (avg over $RUNS runs)" > "$RESULT_MD"
echo "" >> "$RESULT_MD"

# Helper: time a command $RUNS times, append times to tmp file
time_run() {
  local exe="$1"
  local tmp="$2"
  rm -f "$tmp"
  touch "$tmp"
  for i in $(seq 1 $RUNS); do
    if command -v /usr/bin/time >/dev/null 2>&1; then
      /usr/bin/time -f "%e" -o "$tmp" --append "$exe" >/dev/null 2>&1 || true
    else
      # fallback: use date for coarse timing
      start=$(date +%s%N)
      "$exe" >/dev/null 2>&1 || true
      end=$(date +%s%N)
      # convert nanoseconds to seconds
      ns=$((end - start))
      printf "%0.6f\n" "$(awk "BEGIN {print $ns/1000000000}")" >> "$tmp"
    fi
  done
}

# Average times in tmp file
avg_times() {
  awk '{sum+= $1; n++} END {if(n>0) printf "%0.6f", sum/n; else print "-"}' "$1"
}

# Find example directories (one level deep)
for d in "$EXAMPLES_DIR"/*; do
  [ -d "$d" ] || continue
  dirname=$(basename "$d")
  echo "## $dirname" >> "$RESULT_MD"
  echo "| Language | Status | Avg time (s) |" >> "$RESULT_MD"
  echo "|---|---:|---:|" >> "$RESULT_MD"

  # For each language, find a source file if present (pick first match)
  for lang in v zig c3; do
    ext="$lang"
    src_file="$(ls "$d"/*."$ext" 2>/dev/null | head -n1 || true)"
    status="missing"
    avg="-"

    if [ -n "$src_file" ]; then
      base="$(basename "${src_file%.*}")"
      bin_build="$BUILD_DIR/$lang/$base"
      case "$lang" in
        v)
          if command -v v >/dev/null 2>&1; then
            echo "Compiling $src_file (v) -> $bin_build"
            v -o "$bin_build" "$src_file" >/dev/null 2>&1 || true
            if [ -x "$bin_build" ]; then
              time_run "$bin_build" "$TMP_OUT"
              avg=$(avg_times "$TMP_OUT")
              status="ok"
            else
              status="build-failed"
            fi
          else
            status="v-missing"
          fi
          ;;
        zig)
          if command -v zig >/dev/null 2>&1; then
            echo "Compiling $src_file (zig) -> $bin_build"
            zig build-exe -O ReleaseFast -femit-bin="$bin_build" "$src_file" >/dev/null 2>&1 || true
            if [ -x "$bin_build" ]; then
              time_run "$bin_build" "$TMP_OUT"
              avg=$(avg_times "$TMP_OUT")
              status="ok"
            else
              status="build-failed"
            fi
          else
            status="zig-missing"
          fi
          ;;
        c3)
          if command -v c3c >/dev/null 2>&1; then
            echo "Compiling $src_file (c3) -> $bin_build"
            c3c -o "$bin_build" "$src_file" >/dev/null 2>&1 || true
            if [ -x "$bin_build" ]; then
              time_run "$bin_build" "$TMP_OUT"
              avg=$(avg_times "$TMP_OUT")
              status="ok"
            else
              status="build-failed"
            fi
          else
            status="c3-missing"
          fi
          ;;
      esac
    fi

    echo "| ${lang^} | $status | $avg |" >> "$RESULT_MD"
  done

  # Also detect any prebuilt executables in the folder (run them and report)
  mapfile -t exes < <(find "$d" -maxdepth 1 -type f -executable -print 2>/dev/null || true)
  if [ ${#exes[@]} -gt 0 ]; then
    for exe in "${exes[@]}"; do
      # skip source files
      case "$exe" in
        *.v|*.zig|*.c3) continue ;;
      esac
      tmpexe="/tmp/bench_prebuilt.$$"
      time_run "$exe" "$tmpexe"
      avg=$(avg_times "$tmpexe")
      echo "| Prebuilt | $(basename "$exe") | $avg |" >> "$RESULT_MD"
      rm -f "$tmpexe"
    done
  fi

  echo "" >> "$RESULT_MD"
done

rm -f "$TMP_OUT"

echo "Benchmarks written to $RESULT_MD"
exit 0

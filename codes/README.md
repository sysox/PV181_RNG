# Reference Code Guide

Reference implementations for PV181 RNG tasks. Each file demonstrates different PRNG and entropy approaches.

## Files by Task

### Task 2: rand() Function

- **rand_file.c** — Simple `rand()` usage, write output to file, measure performance
- **rand.c** — Basic `rand()` example

### Task 3: Entropy Sources (I/O Methods)

- **devrand_fopen.c** — Read `/dev/urandom` using `fopen/fread`
- **devrand_open.c** — Read `/dev/urandom` using `open/read` syscalls
- **getrandom.c** — Modern `getrandom()` syscall (kernel 3.17+)
- **get_random_bytes.c** — Wrapper for entropy access

### Task 4: Entropy Pool & Blocking

- **devrand_fopen.c**, **devrand_open.c** — Check blocking behavior with `/dev/random` vs `/dev/urandom`

### Task 5: Predict glibc Output

- **selinger_gnu_random.c** ⭐ **KEY FILE** — Glibc implementation using additive feedback: `r[i] = r[i-31] + r[i-3] (mod 2^31)`. Shows state initialization and output generation. Use this to verify predictions.
- **gnu_random.c**, **gnu_random.h** — Full glibc `random()` structure and state initialization

### General Tools

- **LCG.py** — CLI tool for LCG testing: `python3 LCG.py -m 2**31 -a 1103515245 -c 12345 -s <seed> -n <count>`

## Quick Compile & Run

```bash
gcc -o test rand_file.c && ./test
gcc -o entropy devrand_fopen.c && ./entropy
gcc -o glibc selinger_gnu_random.c && ./glibc
python3 LCG.py -m 2**31 -a 1103515245 -c 12345 -s 42 -n 10
```

## Key Insights

| File | Lesson |
|------|--------|
| **LCG.py** | LCG parameters completely determine output |
| **rand_file.c** | `rand()` is fast but predictable |
| **devrand_fopen.c vs devrand_open.c** | Different I/O methods have different performance |
| **getrandom.c** | Modern secure approach for entropy |
| **selinger_gnu_random.c** | glibc is NOT simple LCG — uses additive feedback; still predictable |
| **gnu_random.c** | Proper 31-value state initialization matters |

---

**See also:** [../README.md](../README.md) for main seminar overview

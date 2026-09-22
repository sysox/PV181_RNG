# Reference Code: Random Number Generators in C

This folder contains reference implementations for the **PV181 RNG (C)** notebook tasks. Each file demonstrates different approaches to random number generation and entropy collection on Linux systems.

## File Reference

### **LCG.py** — Linear Congruential Generator Tool
**Purpose:** Command-line tool for testing LCG parameters and understanding LCG behavior.

**Use cases:**
- Experiment with different LCG parameters (modulus `m`, multiplier `a`, increment `c`)
- Generate random sequences and save to file
- Extract specific bit ranges from LCG output
- Test reversibility and predictability of LCG

**Example:**
```bash
python3 LCG.py -m 2**31 -a 1103515245 -c 12345 -s 42 -n 100
```

**When to use:** For understanding ANSI C PRNG behavior (Task 2 in the notebook).

---

### System Entropy Access Files

#### **devrand_fopen.c** & **devrand_open.c**
**Purpose:** Read random bytes from `/dev/random` using different I/O methods.

**Difference:**
- `devrand_fopen.c` — Uses standard C file I/O (`fopen`, `fread`)
- `devrand_open.c` — Uses low-level system calls (`open`, `read`)

**Key property:** `/dev/random` blocks when entropy pool is exhausted and may return fewer bytes than requested.

**When to use:** Task 3 & 4 (comparing entropy sources and understanding blocking behavior).

---

#### **devrand_urandom.c** variant
**Purpose:** Read from `/dev/urandom` (non-blocking entropy source).

**Key property:** Never blocks, reuses entropy pool internally, suitable for high-speed random data generation.

**When to use:** Comparing performance and availability vs `/dev/random` (Task 1 & 3).

---

### **getrandom.c** & **get_random_bytes.c**
**Purpose:** Modern Linux syscall approach for secure random bytes.

**Key differences:**
- `getrandom()` — Direct syscall (kernel 3.17+), can block or non-block
- File-based approach — Compatible with older systems

**When to use:** Understanding modern best practices for entropy collection (Task 1).

---

### **gnu_random.c** & **gnu_random.h**
**Purpose:** Glibc's `random()` function reimplementation.

**Key details:**
- Implements the full glibc random state structure
- Proper initialization with 31-value LCG warmup
- Additive feedback generator (more complex than simple LCG)

**When to use:** Understanding glibc's sophisticated PRNG mechanism (Task 2 & 5).

---

### **selinger_gnu_random.c** ⭐ Important
**Purpose:** Simplified implementation of glibc `rand()` based on Peter Selinger's analysis.

**Key formula:**
```c
r[i] = r[i-31] + r[i-3]  // mod 2^31
```

**Structure:**
1. Initialize first 31 values using LCG: `r[i] = 16807 * r[i-1] % 2147483647`
2. Fill r[31-33] with r[0-2] (feedback initialization)
3. Generate output using additive feedback: `r[i] = r[i-31] + r[i-3]`

**Why it matters:** Demonstrates that glibc's `rand()` is NOT a simple LCG. It uses additive feedback, making it more complex but still predictable.

**When to use:** Task 5 — predict next values from known state using the recurrence relation.

---

### **rand.c** & **rand_file.c**
**Purpose:** Simple `rand()` usage examples for generating random data.

**Features:**
- Seed with `srand()` (time-based or fixed seed)
- Generate values and output to file or console
- Measure generation performance

**When to use:** Task 2 (testing `rand()` function and comparing performance).

---

### **hello-1.c**
**Purpose:** Template/example C program structure.

**When to use:** As a starting point for writing your own C programs.

---

### **ioctl.c**
**Purpose:** Alternative random access using `ioctl()` on `/dev/random` or `/dev/urandom`.

**When to use:** Advanced exploration (not required for basic tasks).

---

## Quick Start Guide

### For Task 2 (rand() function):
```bash
gcc -o test_rand rand_file.c
./test_rand > output.txt
time ./test_rand > /dev/null  # Measure performance
```

### For Task 3 (Compare /dev/urandom vs /dev/random):
```bash
gcc -o urandom devrand_fopen.c
./urandom > file1.bin
# Compare time and file size
```

### For Task 4 (Entropy and blocking):
```bash
gcc -o random devrand_open.c
# Monitor /proc/sys/kernel/random/entropy_avail before/after
cat /proc/sys/kernel/random/entropy_avail
./random  # This will block if entropy is low
```

### For Task 5 (Predict glibc output):
```bash
gcc -o glibc_test selinger_gnu_random.c
./glibc_test
# Verify: can you predict r[i] from r[i-31] and r[i-3]?
```

---

## Summary: What You Can Find in These Code Files

After completing Tasks 0-5, you'll have explored:

| Code File | What It Shows | Key Insight |
|-----------|---------------|-------------|
| **LCG.py** | How LCG parameters affect output | Parameters completely determine the sequence |
| **devrand_fopen.c** & **devrand_open.c** | Two ways to read entropy | Different I/O methods have different performance/latency |
| **getrandom.c** | Modern syscall approach | Kernel provides direct entropy access (3.17+) |
| **gnu_random.c** | glibc's full implementation | Real PRNG is complex, not just simple math |
| **selinger_gnu_random.c** ⭐ | Additive feedback formula | glibc uses `r[i] = r[i-31] + r[i-3]` — **predictable** |
| **rand_file.c** | Simple PRNG usage | `rand()` is fast but **not cryptographic** |

**Core takeaway:** You now understand why:
- ✓ `/dev/urandom` is fast and suitable for non-crypto use
- ✗ `rand()` is predictable from known state
- ✓ Cryptographic PRNGs (OpenSSL, getrandom) use different algorithms
- ✗ System entropy sources can't distinguish PRNGs by output alone

---

## Learning Objectives

By studying these files, you'll understand:

1. **Different entropy sources** — `/dev/urandom`, `/dev/random`, `getrandom()`
2. **I/O performance** — `fopen/fread` vs `open/read` syscalls
3. **PRNG complexity** — Simple LCG vs additive feedback generators
4. **Predictability** — How to reverse-engineer and predict generator output
5. **Cryptographic vs non-cryptographic** — Why glibc's `rand()` is unsuitable for security

---

## Important Notes

- All C files can be compiled with `gcc -o output_name source.c`
- Some programs may require elevated permissions (check `/dev/random` access)
- Times may vary on different systems (VM vs bare metal)
- These are reference implementations; production code requires error checking

---

**See also:** [PV181_RNG_C.ipynb](../PV181_RNG_C.ipynb) for detailed task descriptions.

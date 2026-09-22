# PV181: Random Number Generators

A comprehensive seminar on cryptographic and pseudo-random number generators, covering theory, implementation, attacks, and practical applications.

## 📁 Repository Structure

```
PV181_RNG/
├── PV181_RNG_python.ipynb              Main Python seminar notebook (20 tasks)
├── PV181_RNG_python_solution.ipynb      Solution notebook with implementations
├── PV181_RNG_C.ipynb                    Practical C-based tasks (5 tasks)
│
├── codes/                               Reference implementations
│   ├── README.md                        ⭐ Detailed reference guide
│   ├── LCG.py                           Linear Congruential Generator tool
│   ├── *.c                              C source files for entropy/PRNG
│   └── ...
│
├── install_linux.sh                     Setup script for Linux
├── install_windows.ps1                  Setup script for Windows
├── requirements.txt                     Python dependencies
└── README.md                            This file
```

## 🚀 Quick Start

### 1. Setup Environment (No Admin Needed)

**Linux/macOS:**
```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

**Windows:**
```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

*(Optional: Run `install_linux.sh` or `install_windows.ps1` first if you need to install gcc/openssl for C tasks)*

### 2. Run Notebooks

```bash
jupyter notebook
```

Then open:
- **PV181_RNG_python.ipynb** — Main seminar (theory + tasks 1-20)
- **PV181_RNG_C.ipynb** — System-level PRNG tasks (C implementation)

## 📚 Content Overview

### Python Notebook (PV181_RNG_python.ipynb)

**20 tasks covering:**

| Topics | Tasks |
|--------|-------|
| **Basics** | 1-3: PRNG determinism, seeding, state |
| **LCG** | 4-8: Implementation, reversibility, attacks |
| **Cryptographic** | 9-12: Hash-based RNG, SHA-1, cryptographic properties |
| **glibc** | 13-15: Standard library PRNG, predictability |
| **Statistics** | 16-17: Bit patterns, correlation, bias |
| **Attacks** | 18-20: Time-based, state recovery, brute force |

**Key concepts:**
- Pseudo-random vs true random
- LCG parameters and properties
- Mersenne Twister (625 32-bit state)
- Cryptographic hash functions
- Time-based seed attacks
- State recovery and prediction

### C Notebook (PV181_RNG_C.ipynb)

**5 practical tasks:**

| Task | Focus |
|------|-------|
| 0 | Setup: Connect to server, compile basic C |
| 1 | `openssl` and `dd` for file generation |
| 2 | `rand()` function performance testing |
| 3 | `/dev/urandom` vs `/dev/random` I/O methods |
| 4 | Entropy pool and blocking behavior |
| 5 | glibc implementation analysis |

### Reference Code (codes/ folder)

See **[codes/README.md](codes/README.md)** for detailed reference guide.

**Key files:**
- **LCG.py** — CLI tool for LCG experimentation
- **selinger_gnu_random.c** ⭐ — Glibc implementation with additive feedback formula
- **devrand_*.c** — Entropy source access (fopen, open, syscall)
- **gnu_random.c** — Full glibc PRNG structure

## 📖 Learning Path

### For Students

1. **Read** the notebook section descriptions
2. **Understand** the task requirements
3. **Implement** solutions in the code cells
4. **Verify** with reference code in `codes/` folder
5. **Test** your understanding against the solution notebook

### For Instructors

- **Solution notebook** contains complete implementations with pedagogical comments
- **Reference code** helps students understand practical aspects
- **Installation scripts** ensure consistent environment setup

## 🔧 Installation & Troubleshooting

### Minimal Setup (No Admin Rights)

Requires only Python 3.8+ already installed:
```bash
python3 -m venv venv
source venv/bin/activate        # Linux/macOS
# or on Windows:
# .\venv\Scripts\Activate.ps1

pip install -r requirements.txt
```

This is enough to run the Python notebook tasks.

### Optional: C Tasks & System Tools

For Tasks in PV181_RNG_C.ipynb, you may need:
- **gcc/MinGW** — C compiler (for compiling example programs)
- **OpenSSL** — For cryptographic operations (Task 1)
- **hexdump, dd** — Linux utilities (pre-installed on most Linux systems)

Run the setup scripts (require admin/sudo) to install these:

**Linux (with sudo/admin):**
```bash
bash install_linux.sh
```

**Windows (PowerShell as Administrator):**
```powershell
.\install_windows.ps1
```

These scripts detect your package manager and install optional dependencies.

### Troubleshooting

**Python not found?**
- Install Python 3.8+: https://www.python.org/downloads/

**C compiler not found? (for RNG_C tasks only)**
- Linux: `sudo apt-get install build-essential` (or equivalent for your distro)
- Windows: Install MinGW https://www.mingw-w64.org/

**OpenSSL not found? (optional, for Task 1 only)**
- Linux: `sudo apt-get install openssl`
- Windows: https://www.openssl.org/community/binaries.html

**Jupyter not starting?**
- Ensure venv is activated: `source venv/bin/activate` or `.\venv\Scripts\Activate.ps1`
- Reinstall: `pip install --upgrade notebook ipykernel`

## 📝 Files Explained

| File | Purpose |
|------|---------|
| `PV181_RNG_python.ipynb` | Main teaching material (20 tasks) |
| `PV181_RNG_python_solution.ipynb` | Instructor solutions |
| `PV181_RNG_C.ipynb` | System-level C tasks |
| `codes/` | Reference implementations for all tasks |
| `codes/README.md` | Detailed guide to each reference file |
| `install_linux.sh` | Automated Linux setup |
| `install_windows.ps1` | Automated Windows setup |
| `requirements.txt` | Python package dependencies |

## 🔍 Deep Dive: codes/ Folder

For detailed information about reference code files and when to use them, see **[codes/README.md](codes/README.md)**

This includes:
- Purpose of each C file
- Quick start guide for Tasks 2-5
- Summary table of learning objectives
- Compilation examples

## 💡 Key Insights

After completing this seminar, students understand:

✓ **PRNG is predictable** — Given state, next values are deterministic  
✓ **LCG is simple but weak** — Mathematical structure makes it reversible  
✓ **Entropy sources vary** — `/dev/urandom` ≠ `/dev/random` ≠ OpenSSL  
✓ **Hash-based RNG is stronger** — Cryptographic properties resist prediction  
✓ **Time-based seeds are attackable** — Brute force over reasonable time windows  
✓ **glibc `rand()` is not cryptographic** — Uses additive feedback, predictable from 31 outputs  

## 📞 Support

- **Python notebook issues?** Check the solution notebook for reference implementations
- **C compilation issues?** Ensure gcc is installed (use install scripts)
- **OpenSSL not found?** Task 1 optional; see installation guide
- **Virtual environment?** Run `source venv/bin/activate` on Linux or `.\venv\Scripts\Activate.ps1` on Windows

---

**Version:** Fall 2024  
**Author:** PV181 Seminar  
**Institution:** Masaryk University, Faculty of Informatics

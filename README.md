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

### Windows

One command starts everything:
```powershell
.\StartNotebook_Windows.ps1
```

This creates venv, installs packages, and launches Jupyter.

### Linux/macOS

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
jupyter notebook
```

Or use the setup script:
```bash
bash install_linux.sh
```

### Open Notebooks

Then in Jupyter, open:
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

### Requirements

- **Python 3.8+** (only requirement)
- No admin rights needed for Python notebook tasks

### Optional: C Tasks & Tools

For PV181_RNG_C.ipynb (optional advanced tasks), install:
- **gcc/MinGW** — C compiler
- **OpenSSL** — Cryptographic tools (Task 1)
- **hexdump, dd** — Linux utilities (pre-installed on most Linux)

**Linux:** Run `bash install_linux.sh` (requires sudo)  
**Windows:** Install manually from https://www.mingw-w64.org/ and https://www.openssl.org/

### Troubleshooting

**Python not found?**
- Install from: https://www.python.org/downloads/

**Script won't run (Windows)?**
- Open PowerShell as Administrator
- Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Then: `.\StartNotebook_Windows.ps1`

**Jupyter won't start?**
- Ensure venv is activated
- Try: `pip install --upgrade notebook ipykernel`

**Missing gcc/OpenSSL? (C tasks only)**
- Not needed for Python notebook
- Linux: `sudo apt-get install build-essential openssl`
- Windows: See Optional C Tasks section above

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

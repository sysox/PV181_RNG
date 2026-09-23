# PV181: Random Number Generators

Seminar on cryptographic and pseudo-random number generators. Theory, implementation, attacks, practical applications.

## Quick Start

### Local (Recommended)

**Windows:**
```powershell
.\install_windows.ps1
```

**Linux/macOS:**
```bash
bash install_linux.sh
# or manually:
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
```

The installation script starts Jupyter and opens `PV181_RNG_python.ipynb` in your browser automatically after setup.

### Cloud (No Installation)

Can't install locally? Run in browser via Binder:  
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/sysox/PV181_RNG/HEAD)

Then open `PV181_RNG_python.ipynb` in Jupyter.

## What's Inside

| File | What |
|------|------|
| `PV181_RNG_python.ipynb` | 20 Python tasks (main seminar) |
| `PV181_RNG_python_solution.ipynb` | Solutions |
| `PV181_RNG_C.ipynb` | 5 C tasks (system-level PRNG) |
| `codes/` | Reference implementations |
| `codes/README.md` | Guide to all reference files |

## Content

**Python tasks (1-20):** PRNG basics → LCG → cryptographic RNG → glibc → attacks

**C tasks (1-5):** openssl, rand(), /dev/urandom, entropy, glibc implementation

## Setup Requirements

- **Python 3.8+** (only requirement)
- Optional: gcc, OpenSSL for C tasks (install scripts can help)

## Help

- **Reference code:** See [codes/README.md](codes/README.md)
- **Python issues?** Check solution notebook
- **Script won't run (Windows)?** Open PowerShell as Admin, then:
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  .\install_windows.ps1
  ```

---
Masaryk University, Faculty of Informatics

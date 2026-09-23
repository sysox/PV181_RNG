#!/bin/bash
# PV181 RNG Setup Script for Linux
# Installs required dependencies for Python notebook and C tasks

set -e

# Always work from the directory containing this script, even when launched
# using an absolute or relative path from another directory.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== PV181 RNG Environment Setup (Linux) ==="
echo

# Detect package manager
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt"
    INSTALL_CMD="apt-get install -y"
    UPDATE_CMD="apt-get update"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    INSTALL_CMD="yum install -y"
    UPDATE_CMD="yum check-update"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="pacman -S --noconfirm"
    UPDATE_CMD="pacman -Sy"
else
    echo "❌ Unsupported package manager. Please install dependencies manually:"
    echo "   - gcc (build-essential or gcc package)"
    echo "   - python3 and python3-pip"
    echo "   - openssl"
    echo "   - binutils (for hexdump, dd)"
    exit 1
fi

echo "📦 Detected package manager: $PKG_MANAGER"
echo

# Check if sudo is needed
if [ "$EUID" -ne 0 ]; then
    INSTALL_CMD="sudo $INSTALL_CMD"
    UPDATE_CMD="sudo $UPDATE_CMD"
fi

# Function to check if command exists
check_cmd() {
    if command -v "$1" &> /dev/null; then
        echo "[OK] $1 found"
        return 0
    else
        echo "✗ $1 not found - installing..."
        return 1
    fi
}

echo "Checking dependencies..."
echo

# Check and install gcc
if ! check_cmd gcc; then
    echo "Installing gcc..."
    $INSTALL_CMD build-essential || $INSTALL_CMD gcc
fi

# Check and install python3
if ! check_cmd python3; then
    echo "Installing python3..."
    $INSTALL_CMD python3 python3-pip
fi

# The notebook code and dependencies support Python 3.8 and newer.
if ! python3 -c 'import sys; raise SystemExit(0 if sys.version_info >= (3, 8) else 1)' &> /dev/null; then
    echo "❌ Python 3.8 or newer is required. Found: $(python3 --version)"
    exit 1
fi

# Check python3-venv (needed for virtual environments)
if ! python3 -m venv --help &> /dev/null; then
    echo "Installing python3-venv..."
    $INSTALL_CMD python3-venv
fi

# Check and install openssl
if ! check_cmd openssl; then
    echo "Installing openssl..."
    $INSTALL_CMD openssl
fi

# Check for hexdump (part of util-linux)
if ! check_cmd hexdump; then
    echo "Installing hexdump (util-linux)..."
    $INSTALL_CMD util-linux
fi

# Check for dd (part of coreutils, usually pre-installed)
if ! check_cmd dd; then
    echo "Installing coreutils..."
    $INSTALL_CMD coreutils
fi

echo
echo "[OK] All system dependencies installed"
echo

# Setup Python virtual environment
if [ ! -d "venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv venv
    "$SCRIPT_DIR/venv/bin/pip" install --upgrade pip
    echo "[OK] Virtual environment created"
else
    echo "[OK] Virtual environment already exists"
fi

echo

# Install Python packages from requirements.txt
if [ -f "requirements.txt" ]; then
    echo "Installing Python packages from requirements.txt..."
    "$SCRIPT_DIR/venv/bin/pip" install -r requirements.txt
    echo "[OK] Python packages installed"
else
    echo "⚠ requirements.txt not found"
fi

echo
echo "=== Setup Complete ==="
echo
echo "To activate the environment in future sessions, run:"
echo "    source $SCRIPT_DIR/venv/bin/activate"
echo
echo "Ready to run PV181_RNG notebooks!"

echo
echo "Starting the main notebook..."
"$SCRIPT_DIR/venv/bin/jupyter" notebook "$SCRIPT_DIR/PV181_RNG_python.ipynb" --NotebookApp.token='' --NotebookApp.password=''

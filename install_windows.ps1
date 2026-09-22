# PV181 RNG Setup Script for Windows
# Installs required dependencies for Python notebook and C tasks
# Run as Administrator

Write-Host "=== PV181 RNG Environment Setup (Windows) ===" -ForegroundColor Cyan
Write-Host

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "❌ This script requires Administrator privileges" -ForegroundColor Red
    Write-Host "Please run PowerShell as Administrator and try again" -ForegroundColor Yellow
    exit 1
}

# Function to check if command exists
function Check-Command {
    param([string]$Command)

    $exists = $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
    if ($exists) {
        Write-Host "✓ $Command found" -ForegroundColor Green
        return $true
    } else {
        Write-Host "✗ $Command not found" -ForegroundColor Red
        return $false
    }
}

# Function to check if app is installed
function Check-App {
    param([string]$AppName)

    $installed = $null -ne (Get-Command $AppName -ErrorAction SilentlyContinue)
    return $installed
}

# Check Chocolatey or winget for package management
Write-Host "Checking package managers..." -ForegroundColor Cyan
$hasChoco = Check-App "choco"
$hasWinget = Check-App "winget"

if (-not $hasChoco -and -not $hasWinget) {
    Write-Host "⚠ Neither Chocolatey nor winget found" -ForegroundColor Yellow
    Write-Host "Install manually or use Chocolatey: https://chocolatey.org/install" -ForegroundColor Yellow
    Write-Host
}

Write-Host "Checking dependencies..." -ForegroundColor Cyan
Write-Host

# Check Python
if (Check-Command "python") {
    $pythonVersion = python --version
    Write-Host "  $pythonVersion" -ForegroundColor Green
} else {
    Write-Host "Installing Python3..." -ForegroundColor Yellow
    if ($hasWinget) {
        winget install Python.Python.3.11
    } elseif ($hasChoco) {
        choco install python -y
    } else {
        Write-Host "❌ Cannot install Python automatically" -ForegroundColor Red
        Write-Host "Please download from: https://www.python.org/downloads/" -ForegroundColor Yellow
        exit 1
    }
}

# Check pip
if (Check-Command "pip") {
    Write-Host "  pip found" -ForegroundColor Green
} else {
    Write-Host "❌ pip not found. Please ensure Python is properly installed." -ForegroundColor Red
    exit 1
}

Write-Host

# Check gcc (for C tasks)
if (Check-Command "gcc") {
    $gccVersion = gcc --version | Select-Object -First 1
    Write-Host "  $gccVersion" -ForegroundColor Green
} else {
    Write-Host "⚠ gcc not found (needed for C tasks in RNG_C notebook)" -ForegroundColor Yellow
    Write-Host "Install via:" -ForegroundColor Yellow
    Write-Host "  - MinGW: https://www.mingw-w64.org/" -ForegroundColor White
    Write-Host "  - Visual Studio Build Tools: https://visualstudio.microsoft.com/downloads/" -ForegroundColor White
    Write-Host "  - Or via package manager:" -ForegroundColor White
    if ($hasWinget) {
        Write-Host "    winget install MinGW.MinGW" -ForegroundColor White
    } elseif ($hasChoco) {
        Write-Host "    choco install mingw -y" -ForegroundColor White
    }
    Write-Host
}

# Check OpenSSL
if (Check-Command "openssl") {
    $opensslVersion = openssl version | Select-Object -First 1
    Write-Host "  $opensslVersion" -ForegroundColor Green
} else {
    Write-Host "⚠ OpenSSL not found (needed for Task 1)" -ForegroundColor Yellow
    Write-Host "Install via:" -ForegroundColor Yellow
    if ($hasWinget) {
        Write-Host "  winget install OpenSSL.OpenSSL" -ForegroundColor White
    } elseif ($hasChoco) {
        Write-Host "  choco install openssl -y" -ForegroundColor White
    } else {
        Write-Host "  Download from: https://www.openssl.org/community/binaries.html" -ForegroundColor White
    }
    Write-Host
}

Write-Host

# Setup Python virtual environment
Write-Host "Setting up Python environment..." -ForegroundColor Cyan

if (-not (Test-Path "venv")) {
    Write-Host "Creating Python virtual environment..."
    python -m venv venv
    Write-Host "✓ Virtual environment created" -ForegroundColor Green
} else {
    Write-Host "✓ Virtual environment already exists" -ForegroundColor Green
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Cyan
& ".\venv\Scripts\Activate.ps1"

Write-Host

# Upgrade pip
Write-Host "Upgrading pip..."
python -m pip install --upgrade pip

Write-Host

# Install Python packages from requirements.txt
if (Test-Path "requirements.txt") {
    Write-Host "Installing Python packages from requirements.txt..." -ForegroundColor Cyan
    pip install -r requirements.txt
    Write-Host "✓ Python packages installed" -ForegroundColor Green
} else {
    Write-Host "⚠ requirements.txt not found" -ForegroundColor Yellow
}

Write-Host
Write-Host "=== Setup Complete ===" -ForegroundColor Green
Write-Host
Write-Host "To activate the environment in future sessions, run:" -ForegroundColor Cyan
Write-Host "    .\venv\Scripts\Activate.ps1" -ForegroundColor White
Write-Host
Write-Host "Ready to run PV181_RNG notebooks!" -ForegroundColor Green

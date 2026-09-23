# PV181 RNG: Setup and Start Jupyter Notebook (Windows)
# One-click setup and launch for students

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location -LiteralPath $ScriptDir

function ActivateVirtual() {
	$venvPath = Join-Path $ScriptDir "venv"
	if (-not (Test-Path $venvPath)) {
		Write-Host "Creating Python virtual environment..." -ForegroundColor Cyan
		python -m venv $venvPath
	}
	Write-Host "Activating virtual environment..." -ForegroundColor Cyan
	& (Join-Path $venvPath "Scripts\Activate.ps1")
}

function InstallRequirements() {
	Write-Host "Installing Python packages..." -ForegroundColor Cyan
	pip install --upgrade pip --quiet
	pip install -r (Join-Path $ScriptDir "requirements.txt")
	Write-Host "✓ Packages installed" -ForegroundColor Green
}

function StartNotebook() {
	Write-Host "Starting Jupyter notebook..." -ForegroundColor Green
	jupyter notebook (Join-Path $ScriptDir "PV181_RNG_python.ipynb")
}

function Main() {
	Write-Host "=== PV181 RNG: Jupyter Setup & Start ===" -ForegroundColor Cyan
	Write-Host

	ActivateVirtual
	Write-Host
	InstallRequirements
	Write-Host
	StartNotebook
}

Main

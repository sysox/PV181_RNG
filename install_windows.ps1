# PV181 RNG: Setup and Start Jupyter Notebook (Windows)
# One-click setup and launch for students

function ActivateVirtual() {
	if (-not (Test-Path "venv")) {
		Write-Host "Creating Python virtual environment..." -ForegroundColor Cyan
		python -m venv venv
	}
	Write-Host "Activating virtual environment..." -ForegroundColor Cyan
	& ".\venv\Scripts\Activate.ps1"
}

function InstallRequirements() {
	Write-Host "Installing Python packages..." -ForegroundColor Cyan
	pip install --upgrade pip --quiet
	pip install -r requirements.txt
	Write-Host "✓ Packages installed" -ForegroundColor Green
}

function StartNotebook() {
	Write-Host "Starting Jupyter notebook..." -ForegroundColor Green
	jupyter notebook
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

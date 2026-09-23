# PV181 RNG: Setup and Start Jupyter Notebook (Windows)
# One-click setup and launch for students

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location -LiteralPath $ScriptDir

$pythonVersion = & python -c "import sys; print(f'{sys.version_info[0]}.{sys.version_info[1]}')"
if ($LASTEXITCODE -ne 0 -or [version]$pythonVersion -lt [version]'3.8') {
	throw "Python 3.8 or newer is required. Found: $pythonVersion"
}

function GetVenvPaths {
	$venvPath = Join-Path $ScriptDir "venv"
	$pipPath = Join-Path $venvPath "Scripts\pip.exe"
	$jupyterPath = Join-Path $venvPath "Scripts\jupyter.exe"
	return @{
		venvPath = $venvPath
		pipPath = $pipPath
		jupyterPath = $jupyterPath
	}
}

function ActivateVirtual {
	$paths = GetVenvPaths
	if (-not (Test-Path $paths.venvPath)) {
		Write-Host "Creating Python virtual environment..." -ForegroundColor Cyan
		python -m venv $paths.venvPath
	} else {
		Write-Host "✓ Virtual environment already exists" -ForegroundColor Green
	}
}

function InstallRequirements {
	$paths = GetVenvPaths
	Write-Host "Installing Python packages..." -ForegroundColor Cyan
	& $paths.pipPath install --upgrade pip --quiet
	& $paths.pipPath install -r (Join-Path $ScriptDir "requirements.txt")
	Write-Host "✓ Packages installed" -ForegroundColor Green
}

function StartNotebook {
	$paths = GetVenvPaths
	Write-Host "Starting Jupyter notebook..." -ForegroundColor Green
	& $paths.jupyterPath notebook (Join-Path $ScriptDir "PV181_RNG_python.ipynb")
}

function Main {
	Write-Host "=== PV181 RNG: Jupyter Setup & Start ===" -ForegroundColor Cyan
	Write-Host

	ActivateVirtual
	Write-Host
	InstallRequirements
	Write-Host
	StartNotebook
}

Main

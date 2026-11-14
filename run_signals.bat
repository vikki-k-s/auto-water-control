@echo off
setlocal enabledelayedexpansion

echo ===================================================================
echo   SMART REAL-TIME SIGNAL MONITORING AND ANALYSIS SYSTEM
echo   Course: UE25EC2304 | Signals and Systems with Simulation
echo   GM UNIVERSITY, Davanagere - Department of ECE
echo ===================================================================
echo.

:: 1. Check for native Windows Python
where python.exe >nul 2>&1
if %ERRORLEVEL% equ 0 (
    python -c "import numpy, scipy, matplotlib" >nul 2>&1
    if !ERRORLEVEL! equ 0 (
        echo [OK] Native Windows Python with scientific libraries detected.
        echo Launching Python Signals & Systems Runner...
        echo.
        python "%~dp0src\interactive_signal_runner.py"
        goto :END
    )
)

:: 2. Check for WSL (Windows Subsystem for Linux) Python
where wsl.exe >nul 2>&1
if %ERRORLEVEL% equ 0 (
    wsl python3 -c "import numpy, scipy, matplotlib" >nul 2>&1
    if !ERRORLEVEL! equ 0 (
        echo [OK] WSL Linux Python 3 with scientific libraries detected.
        echo Launching Signals & Systems Runner in WSL environment...
        echo.
        wsl python3 "/mnt/d/Projects/PBL Project/src/interactive_signal_runner.py"
        goto :END
    )
)

:: 3. Fallback: Launch the Browser-Native Interactive Cockpit
echo [NOTE] Python environment not detected in PATH.
echo Launching standalone zero-dependency Browser SCADA Cockpit...
start "" "%~dp0gui\index.html"
echo.
echo Browser Cockpit opened in your default browser!
echo To run native Python terminal scripts, run 'install_requirements.bat'.
echo.

:END
pause

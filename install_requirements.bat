@echo off
echo ===================================================================
echo   AUTOMATIC SOFTWARE & ENVIRONMENT INSTALLER (UE25EC2304)
echo   GM University | Department of Electronics & Communication Engg.
echo ===================================================================
echo.
echo Installing Python 3.12 and required scientific packages:
echo  - numpy (Numerical arrays & discrete convolutions)
echo  - scipy (Digital IIR/FIR filter design & Simpson integration)
echo  - matplotlib (High-resolution waveform and spectrum plots)
echo  - pyserial (Hardware UART telemetry communication)
echo.

where python.exe >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python not found on Windows PATH. Attempting automated winget installation...
    winget install Python.Python.3.12 --silent --accept-package-agreements --accept-source-agreements
    echo.
    echo Please restart your command prompt or terminal after installation finishes.
)

echo.
echo Installing Python dependencies via pip...
python -m pip install --upgrade pip
python -m pip install numpy scipy matplotlib pyserial

echo.
echo Verifying installation...
python -c "import numpy, scipy, matplotlib, serial; print('ALL LIBRARIES SUCCESSFULLY INSTALLED AND VERIFIED!')"
echo.
pause

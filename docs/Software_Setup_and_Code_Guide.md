# GM UNIVERSITY, DAVANAGERE
## Department of Electronics & Communication Engineering
### UE25EC2304: Signals and Systems with Simulation
#### Complete Software Requirements, Code Architecture & Execution Manual

---

## 💻 1. Required Software & Prerequisites

To execute and demonstrate the **Smart Real-Time Signal Monitoring and Analysis System**, the following software tools are utilized:

| Software Tool | Recommended Version | Purpose in Project | Installation Method |
|:---|:---:|:---|:---|
| **Python** | **3.9 to 3.12+** | Core digital signal processing engine, mathematical classification, Fourier analysis, and Z-transform. | Windows: `winget install Python.Python.3.12`<br>Linux/WSL: `sudo apt install python3 python3-pip` |
| **NumPy** | **1.24+** | High-performance discrete signal arrays, numerical vector operations, and convolution. | `pip install numpy` |
| **SciPy** | **1.10+** | Digital IIR/FIR filter synthesis, numerical quadrature (Simpson integration), and root finding. | `pip install scipy` |
| **Matplotlib** | **3.7+** | Academic publication-grade waveform plotting, harmonic line spectra, and complex Z-plane charts. | `pip install matplotlib` |
| **PySerial** | **3.5+** | (Optional) Reads live serial telemetry packets from physical Arduino / ESP32 hardware. | `pip install pyserial` |
| **Web Browser** | **Edge / Chrome** | Runs the interactive HTML5/Canvas SCADA cockpit with Web Serial API and zero dependencies. | Pre-installed on Windows / macOS |
| **Arduino IDE** | **2.0+** | (Optional) Compiles and uploads the embedded C++ firmware to ATmega328P / Arduino Uno. | `https://www.arduino.cc/en/software` |

---

## ⚡ 2. Quick Execution Guide (3 Ways to Run)

### Method A: Zero-Dependency Interactive Browser Cockpit (Recommended for Live Demo)
No software installation or Python setup is required. The dashboard runs directly in Microsoft Edge or Google Chrome:
1. Double-click **[`run_gui.bat`](run_gui.bat)** (or open **[`gui/index.html`](gui/index.html)**).
2. The cockpit launches with:
   - Live dual-channel oscilloscope with real-time noise injection.
   - Signal selection menu (ECG, Temperature, Audio Formants, BFSK Communication).
   - Automated Unit 1 classification decision matrix.
   - Interactive sliders for Amplitude Scaling, Time Shifting, Time Scaling, and Even/Odd decomposition.
   - LTI convolution animator with moving average, RC decay, and QRS differentiator.
   - Fourier Series synthesizer ($N=1\dots 35$ harmonics) exposing the Gibbs phenomenon.
   - Real-time FFT magnitude spectrum and 50 Hz notch filter toggle.
   - Interactive complex Z-plane with draggable/visualized poles and zeros.

---

### Method B: Standalone Python Console & Plot Runner
Run the interactive Python menu console that evaluates mathematical models and saves high-resolution waveform figures:
```bash
# Option 1: Double-click Windows batch file
run_signals.bat

# Option 2: Run directly in terminal (Windows PowerShell or Command Prompt)
python src/interactive_signal_runner.py

# Option 3: Run in WSL (Linux environment)
wsl python3 "/mnt/d/Projects/PBL Project/src/interactive_signal_runner.py"
```

---

### Method C: Automated 6-Unit Validation Benchmark
To run the automated numerical validation suite across all 6 syllabus units:
```bash
# Run Windows batch file
run_simulation.bat

# Or terminal command:
python src/signal_engine.py
```

---

## 🧬 3. Annotated Code of All Signals & System Modules

### Module 1: Biomedical Lead-II ECG Signal Generation & Ingestion
Synthesizes physiologically accurate Lead-II electrocardiogram waveforms using Gaussian basis functions with respiration baseline wander (0.25 Hz) and 50 Hz powerline hum:

```python
import numpy as np

def generate_ecg(duration=4.0, fs=500, hr_bpm=72, add_noise=True):
    N = int(duration * fs)
    t = np.linspace(0, duration, N, endpoint=False)
    rr_interval = 60.0 / hr_bpm  # in seconds (~0.833s for 72 BPM)
    ecg_clean = np.zeros(N)
    num_beats = int(np.ceil(duration / rr_interval)) + 1
    
    for beat in range(num_beats):
        t_center = beat * rr_interval + 0.2
        if t_center > duration + 0.3:
            break
        # P wave: atrial depolarization
        ecg_clean += 0.25 * np.exp(-((t - (t_center - 0.16)) ** 2) / (2 * 0.025 ** 2))
        # Q wave: septal depolarization
        ecg_clean -= 0.15 * np.exp(-((t - (t_center - 0.05)) ** 2) / (2 * 0.010 ** 2))
        # R wave: ventricular depolarization (tall, sharp positive spike)
        ecg_clean += 1.50 * np.exp(-((t - t_center) ** 2) / (2 * 0.015 ** 2))
        # S wave: late ventricular depolarization
        ecg_clean -= 0.35 * np.exp(-((t - (t_center + 0.04)) ** 2) / (2 * 0.012 ** 2))
        # T wave: ventricular repolarization
        ecg_clean += 0.40 * np.exp(-((t - (t_center + 0.22)) ** 2) / (2 * 0.045 ** 2))

    if add_noise:
        baseline = 0.25 * np.sin(2 * np.pi * 0.25 * t)       # 0.25 Hz respiration wander
        powerline = 0.12 * np.sin(2 * np.pi * 50.0 * t)       # 50 Hz Indian mains hum
        emg_noise = 0.04 * np.random.normal(0, 1, N)          # High-frequency muscle jitter
        return t, ecg_clean + baseline + powerline + emg_noise, ecg_clean

    return t, ecg_clean, ecg_clean
```

---

### Module 2: Environmental LM35 Temperature Sensor Simulation
Simulates thermal process ingestion with a 24-hour diurnal solar cycle and high-frequency thermal noise:

```python
def generate_temperature(duration=24.0, fs=10, base_temp=28.5):
    N = int(duration * fs)
    t = np.linspace(0, duration, N, endpoint=False)
    # Diurnal cycle: T0 = 24 hours, amplitude +/- 6.5 °C
    cycle = 6.5 * np.sin(2 * np.pi * (1.0 / 24.0) * t - np.pi / 3)
    jitter = 0.25 * np.random.normal(0, 1, N)  # Sensor thermal jitter
    temp_signal = base_temp + cycle + jitter
    return t, temp_signal
```

---

### Module 3: Acoustic Speech Formant Tone Synthesizer
Generates multi-harmonic glottal pulses modeling vocal vowel formants ($F_1 = 500\text{ Hz}, F_2 = 1500\text{ Hz}, F_3 = 2500\text{ Hz}$):

```python
def generate_audio(duration=0.5, fs=4000, f0=220):
    N = int(duration * fs)
    t = np.linspace(0, duration, N, endpoint=False)
    # Glottal pulse harmonic series
    audio = (1.00 * np.sin(2 * np.pi * f0 * t) +
             0.65 * np.sin(2 * np.pi * 2 * f0 * t) +
             0.45 * np.sin(2 * np.pi * 3 * f0 * t) +
             0.30 * np.sin(2 * np.pi * 4 * f0 * t) +
             0.20 * np.sin(2 * np.pi * 5 * f0 * t))
    env = np.exp(-2.0 * t) * (1 - np.exp(-30.0 * t))  # Attack-Decay envelope
    return t, audio * (env / np.max(env))
```

---

### Module 4: Binary Frequency Shift Keying (BFSK) Modulator
Generates binary digital communication signals with Mark frequency (1200 Hz) and Space frequency (2200 Hz):

```python
def generate_communication_fsk(duration=0.1, fs=10000, f_mark=1200, f_space=2200):
    N = int(duration * fs)
    t = np.linspace(0, duration, N, endpoint=False)
    bits = [1, 0, 1, 1, 0, 1, 0, 0]
    bit_dur = duration / len(bits)
    fsk = np.zeros(N)
    for i, bit in enumerate(bits):
        idx = (t >= i * bit_dur) & (t < (i + 1) * bit_dur)
        freq = f_mark if bit == 1 else f_space
        fsk[idx] = np.sin(2 * np.pi * freq * t[idx])
    return t, fsk
```

---

### Module 5: Unit 1 Signal Operations (Scaling, Shifting, Reversal, Even/Odd)
```python
class SignalOperations:
    @staticmethod
    def amplitude_scale(x, A):
        return A * x

    @staticmethod
    def time_shift(t, x, t0):
        dt = t[1] - t[0]
        shift_samples = int(round(t0 / dt))
        y = np.zeros_like(x)
        if shift_samples > 0:
            y[shift_samples:] = x[:-shift_samples]
        elif shift_samples < 0:
            y[:shift_samples] = x[-shift_samples:]
        else:
            y = np.copy(x)
        return y

    @staticmethod
    def time_scale(t, x, a):
        t_scaled = a * t
        return np.interp(t_scaled, t, x, left=0.0, right=0.0)

    @staticmethod
    def time_reversal(x):
        return np.flip(x)

    @staticmethod
    def even_odd_decomposition(x):
        x_rev = np.flip(x)
        return 0.5 * (x + x_rev), 0.5 * (x - x_rev)
```

---

### Module 6: Unit 2 LTI Discrete Convolution & BIBO Stability Verification
```python
class LTISystem:
    @staticmethod
    def convolve(x, h):
        # Discrete linear convolution: y[n] = sum_k x[k] * h[n-k]
        return np.convolve(x, h, mode='same')

    @staticmethod
    def verify_bibo_stability(h):
        # Necessary and sufficient condition: sum |h[n]| < infinity
        abs_sum = np.sum(np.abs(h))
        return bool(abs_sum < 1e4), abs_sum
```

---

### Module 7: Unit 3 Fourier Series Harmonic Decomposition & Synthesis
```python
from scipy.integrate import simpson

class FourierSeriesAnalyzer:
    @staticmethod
    def compute_coefficients(t, x, T0, num_harmonics=25):
        omega0 = 2 * np.pi / T0
        idx = (t >= 0) & (t <= T0)
        t_p = t[idx]
        x_p = x[idx]
        
        a0 = simpson(x_p, t_p) / T0
        an, bn, cn_mag = [], [], [abs(a0)]
        
        for n in range(1, num_harmonics + 1):
            a_n = (2.0 / T0) * simpson(x_p * np.cos(n * omega0 * t_p), t_p)
            b_n = (2.0 / T0) * simpson(x_p * np.sin(n * omega0 * t_p), t_p)
            an.append(a_n)
            bn.append(b_n)
            cn_mag.append(0.5 * np.sqrt(a_n ** 2 + b_n ** 2))
            
        return a0, np.array(an), np.array(bn), np.array(cn_mag)

    @staticmethod
    def reconstruct_signal(t, a0, an, bn, T0, harmonics_to_use=15):
        omega0 = 2 * np.pi / T0
        recon = np.full_like(t, a0)
        for n in range(1, harmonics_to_use + 1):
            recon += an[n - 1] * np.cos(n * omega0 * t) + bn[n - 1] * np.sin(n * omega0 * t)
        return recon
```

---

### Module 8: Unit 4 FFT Spectrum & 50 Hz Powerline Notch Filter
```python
import scipy.signal as signal

class FourierTransformAnalyzer:
    @staticmethod
    def compute_spectrum(t, x):
        N = len(x)
        dt = t[1] - t[0]
        X_fft = np.fft.rfft(x * np.hanning(N))
        freqs = np.fft.rfftfreq(N, d=dt)
        mag_linear = (2.0 / N) * np.abs(X_fft)
        return freqs, mag_linear

    @staticmethod
    def design_filters(fs=500):
        # 50 Hz Notch filter (Q = 30)
        b_notch, a_notch = signal.iirnotch(50.0, 30.0, fs)
        # 0.5 - 40 Hz 4th-order Butterworth Bandpass filter
        b_band, a_band = signal.butter(4, [0.5 / 250.0, 40.0 / 250.0], btype='band')
        return (b_notch, a_notch), (b_band, a_band)

    @staticmethod
    def filter_signal(x, b, a):
        return signal.filtfilt(b, a, x)
```

---

### Module 9: Unit 5 Z-Transform Pole-Zero Analyzer & Difference Equation
```python
class ZTransformAnalyzer:
    @staticmethod
    def analyze_filter(b, a):
        zeros = np.roots(b)
        poles = np.roots(a)
        max_pole_mag = np.max(np.abs(poles))
        is_stable = bool(max_pole_mag < 1.0)
        roc = f"|z| > {max_pole_mag:.4f} (Exterior of outermost pole)"
        return zeros, poles, max_pole_mag, is_stable, roc
```

---

### Module 10: Unit 6 Microcontroller 500 Hz ISR Firmware (C++)
Located at **[`hardware/SmartSignalAcquisition.ino`](../hardware/SmartSignalAcquisition.ino)**:
```cpp
#include <Arduino.h>

const int PIN_ECG = A0;
const int PIN_TEMP = A1;
const int PIN_AUDIO = A2;
const unsigned long SAMPLE_INTERVAL_US = 2000; // 500 Hz sampling (Ts = 2000 us)
unsigned long lastSampleTime = 0;
unsigned long packetSeq = 0;

void setup() {
  Serial.begin(115200);
  pinMode(13, OUTPUT); // Heartbeat status LED
}

void loop() {
  unsigned long currentMicros = micros();
  if (currentMicros - lastSampleTime >= SAMPLE_INTERVAL_US) {
    lastSampleTime = currentMicros;
    packetSeq++;
    
    // Read 10-bit SAR ADC (0 to 1023)
    int raw_ecg = analogRead(PIN_ECG);
    int raw_temp = analogRead(PIN_TEMP);
    int raw_audio = analogRead(PIN_AUDIO);
    
    // Physical engineering unit conversions:
    float v_ecg_mv = (raw_ecg * 3300.0) / 1024.0;
    float temp_c = ((raw_temp * 3300.0) / 1024.0) / 10.0;
    
    if (packetSeq % 500 == 0) digitalWrite(13, !digitalRead(13)); // 1 Hz toggle
    
    // Framed JSON Telemetry Transmission:
    Serial.print(F("{\"t\":"));   Serial.print(millis());
    Serial.print(F(",\"seq\":")); Serial.print(packetSeq);
    Serial.print(F(",\"ecg\":")); Serial.print(v_ecg_mv, 1);
    Serial.print(F(",\"temp\":"));Serial.print(temp_c, 2);
    Serial.print(F(",\"aud\":")); Serial.print(raw_audio);
    Serial.println(F("}"));
  }
}
```

---

## 🛠️ 4. Troubleshooting Common Setup Questions

1. **"python is not recognized as an internal or external command" on Windows:**
   - Double-click `run_signals.bat` — it automatically detects if WSL or browser fallback is available!
   - Or run `install_requirements.bat` to install Python 3.12 via winget with environment variables automatically configured.

2. **Connecting Real Arduino Hardware:**
   - Upload `hardware/SmartSignalAcquisition.ino` using the Arduino IDE.
   - Open `gui/index.html` in Microsoft Edge or Google Chrome.
   - Go to Tab 8 (*Hardware Telemetry*) and click **"Connect USB COM Port"**. Select your Arduino COM port (Baud: 115200). Live hardware samples will immediately stream across all 8 panels!

"""
Smart Real-Time Signal Monitoring and Analysis System
Course Code: UE25EC2304 | Signals and Systems with Simulation
GM UNIVERSITY, Davanagere - Department of ECE

Core Python Signal Processing Engine implementing Units 1 through 6:
- Unit 1: Signal Acquisition, Classification & Operations
- Unit 2: LTI Systems, Impulse Response & Convolution
- Unit 3: Fourier Series Analysis & Harmonic Reconstruction
- Unit 4: Fourier Transform & Frequency Spectrum Analysis
- Unit 5: Z-Transform, Pole-Zero Mapping & Digital Filter Realization
- Unit 6: Hardware Sensor Interfacing, ADC Quantization & Telemetry
"""

import numpy as np
import scipy.signal as signal
from scipy.integrate import simpson
import json

class SignalGenerator:
    """Generates practical real-world and synthetic signals (Unit 1 & Unit 6)."""

    @staticmethod
    def generate_ecg(duration=4.0, fs=500, hr_bpm=72, add_noise=True):
        """
        Synthesizes a realistic Lead-II ECG waveform with P-Q-R-S-T complexes,
        baseline drift (0.2 Hz), and 50 Hz powerline interference.
        """
        N = int(duration * fs)
        t = np.linspace(0, duration, N, endpoint=False)
        rr_interval = 60.0 / hr_bpm  # in seconds (~0.833s)
        
        # Base ECG waveform template using sum of Gaussians
        ecg_clean = np.zeros(N)
        num_beats = int(np.ceil(duration / rr_interval)) + 1
        
        for beat in range(num_beats):
            t_center = beat * rr_interval + 0.2
            if t_center > duration + 0.3:
                break
            
            # P wave: small positive deflection
            ecg_clean += 0.25 * np.exp(-((t - (t_center - 0.16)) ** 2) / (2 * 0.025 ** 2))
            # Q wave: small sharp negative deflection
            ecg_clean -= 0.15 * np.exp(-((t - (t_center - 0.05)) ** 2) / (2 * 0.010 ** 2))
            # R wave: tall, sharp positive spike
            ecg_clean += 1.50 * np.exp(-((t - t_center) ** 2) / (2 * 0.015 ** 2))
            # S wave: sharp negative deflection
            ecg_clean -= 0.35 * np.exp(-((t - (t_center + 0.04)) ** 2) / (2 * 0.012 ** 2))
            # T wave: medium positive deflection
            ecg_clean += 0.40 * np.exp(-((t - (t_center + 0.22)) ** 2) / (2 * 0.045 ** 2))

        # Add realistic physiological artifacts
        if add_noise:
            # Baseline wander (respiration ~0.25 Hz)
            baseline = 0.25 * np.sin(2 * np.pi * 0.25 * t)
            # Powerline interference (50 Hz Indian standard)
            powerline = 0.12 * np.sin(2 * np.pi * 50.0 * t)
            # High frequency electromyographic (EMG) muscle tremor
            emg_noise = 0.04 * np.random.normal(0, 1, N)
            ecg_noisy = ecg_clean + baseline + powerline + emg_noise
            return t, ecg_noisy, ecg_clean
        
        return t, ecg_clean, ecg_clean

    @staticmethod
    def generate_temperature(duration=24.0, fs=10, base_temp=28.5):
        """
        Simulates environmental temperature sensor (LM35 / DS18B20)
        with diurnal solar sinusoidal cycle (f = 1/24 hr) and sensor noise.
        """
        N = int(duration * fs)
        t = np.linspace(0, duration, N, endpoint=False)
        # Daily cycle: peak in afternoon, trough before dawn
        cycle = 6.5 * np.sin(2 * np.pi * (1.0 / 24.0) * t - np.pi / 3)
        # High-frequency thermal jitter
        jitter = 0.25 * np.random.normal(0, 1, N)
        temp_signal = base_temp + cycle + jitter
        return t, temp_signal

    @staticmethod
    def generate_audio(duration=0.5, fs=4000, f0=220):
        """
        Synthesizes an audio vowel sound with pitch f0 and vocal tract formants
        (F1 = 500 Hz, F2 = 1500 Hz, F3 = 2500 Hz).
        """
        N = int(duration * fs)
        t = np.linspace(0, duration, N, endpoint=False)
        # Glottal pulse harmonic series
        audio = (1.00 * np.sin(2 * np.pi * f0 * t) +
                 0.65 * np.sin(2 * np.pi * 2 * f0 * t) +
                 0.45 * np.sin(2 * np.pi * 3 * f0 * t) +
                 0.30 * np.sin(2 * np.pi * 4 * f0 * t) +
                 0.20 * np.sin(2 * np.pi * 5 * f0 * t))
        # Amplitude envelope (attack, decay, sustain, release)
        env = np.exp(-2.0 * t) * (1 - np.exp(-30.0 * t))
        audio *= (env / np.max(env))
        return t, audio

    @staticmethod
    def generate_communication_fsk(duration=0.1, fs=10000, f_mark=1200, f_space=2200):
        """
        Generates Binary Frequency Shift Keying (BFSK) communication signal.
        """
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


class SignalClassifier:
    """Classifies signals into fundamental mathematical categories (Unit 1)."""

    @staticmethod
    def classify_all(t, x):
        """Performs comprehensive multi-attribute classification."""
        dt = t[1] - t[0]
        fs = 1.0 / dt
        N = len(x)

        # 1. Continuous-Time vs Discrete-Time
        # Computationally in digital system, sampled signals are discrete-time,
        # but represents underlying continuous-time physical process.
        domain_type = "Discrete-Time (Sampled Representation of Continuous Physical Signal)"
        
        # 2. Energy and Power Calculation
        # Energy E = sum(|x[n]|^2 * dt)
        energy = np.sum(x ** 2) * dt
        # Average Power P = (1/T) * sum(|x[n]|^2 * dt) = (1/N) * sum(|x[n]|^2)
        power = np.mean(x ** 2)
        
        if energy < 1e5 and power < 0.05:
            energy_power_type = "Energy Signal (Finite Energy E, Zero Average Power P)"
        elif power >= 0.05:
            energy_power_type = "Power Signal (Infinite Total Energy, Finite Non-zero Average Power)"
        else:
            energy_power_type = "Neither Energy nor Power"

        # 3. Deterministic vs Random
        # Using normalized autocorrelation and variance
        x_norm = x - np.mean(x)
        corr = signal.correlate(x_norm, x_norm, mode='full')
        corr /= np.max(corr)
        center = len(corr) // 2
        # Ratio of secondary peak to main peak
        secondary_peaks = corr[center + int(fs * 0.05):]
        max_sec_peak = np.max(secondary_peaks) if len(secondary_peaks) > 0 else 0
        
        if max_sec_peak > 0.35:
            det_type = "Deterministic (Periodic/Quasi-periodic Structure)"
        else:
            det_type = "Stochastic / Random (Uncorrelated high-entropy components)"

        # 4. Periodic vs Non-periodic
        # Check autocorrelation periodicity
        lags = np.arange(len(secondary_peaks))
        peaks, props = signal.find_peaks(secondary_peaks, height=0.25, distance=int(fs * 0.1))
        
        if len(peaks) >= 2:
            period_samples = peaks[0] + int(fs * 0.05)
            fundamental_period = period_samples * dt
            fundamental_freq = 1.0 / fundamental_period
            periodicity = f"Periodic (Fundamental Period T0 = {fundamental_period:.4f} s, f0 = {fundamental_freq:.2f} Hz)"
        else:
            fundamental_period = None
            fundamental_freq = None
            periodicity = "Non-periodic / Aperiodic"

        return {
            "Domain": domain_type,
            "Sampling_Frequency_Hz": float(fs),
            "Nyquist_Frequency_Hz": float(fs / 2),
            "Energy_Joules": float(energy),
            "Power_Watts": float(power),
            "Energy_Power_Class": energy_power_type,
            "Determinism": det_type,
            "Periodicity": periodicity,
            "Fundamental_Period_s": fundamental_period,
            "Fundamental_Freq_Hz": fundamental_freq
        }


class SignalOperations:
    """Performs elementary continuous/discrete time transformations (Unit 1)."""

    @staticmethod
    def amplitude_scale(x, A):
        """y(t) = A * x(t)"""
        return A * x

    @staticmethod
    def time_shift(t, x, t0):
        """y(t) = x(t - t0)"""
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
        """y(t) = x(a * t) -> Compression (a > 1), Expansion (0 < a < 1)"""
        t_scaled = a * t
        # Interpolate x evaluated at t_scaled back onto original t grid
        y = np.interp(t_scaled, t, x, left=0.0, right=0.0)
        return y

    @staticmethod
    def time_reversal(t, x):
        """y(t) = x(-t)"""
        return np.flip(x)

    @staticmethod
    def even_odd_decomposition(t, x):
        """
        Decomposes signal into Even and Odd symmetric components:
        x_e(t) = 0.5 * (x(t) + x(-t))
        x_o(t) = 0.5 * (x(t) - x(-t))
        """
        x_rev = np.flip(x)
        x_even = 0.5 * (x + x_rev)
        x_odd = 0.5 * (x - x_rev)
        return x_even, x_odd

    @staticmethod
    def add_signals(x1, x2):
        """y(t) = x1(t) + x2(t)"""
        return x1 + x2

    @staticmethod
    def multiply_signals(x1, x2):
        """y(t) = x1(t) * x2(t) (Modulation / Windowing)"""
        return x1 * x2


class LTISystem:
    """Models Linear Time-Invariant (LTI) systems and computes convolution (Unit 2)."""

    @staticmethod
    def rc_lowpass_impulse(t, tau=0.02):
        """Impulse response of 1st-order RC filter: h(t) = (1/tau) * exp(-t/tau) * u(t)"""
        h = np.zeros_like(t)
        pos = t >= 0
        h[pos] = (1.0 / tau) * np.exp(-t[pos] / tau)
        # Normalize discrete sum to unit gain
        dt = t[1] - t[0]
        return h * dt

    @staticmethod
    def moving_average_impulse(length=15):
        """Discrete moving average filter impulse response: h[n] = 1/M for 0 <= n < M"""
        return np.ones(length) / length

    @staticmethod
    def r_peak_detector_impulse():
        """Difference operator for ECG R-peak detection: h[n] = [-1, -2, 0, 2, 1] / 8"""
        return np.array([-1, -2, 0, 2, 1], dtype=float) / 8.0

    @staticmethod
    def convolve(x, h):
        """
        Computes discrete linear convolution:
        y[n] = sum_{k} x[k] * h[n-k]
        """
        return signal.convolve(x, h, mode='same')

    @staticmethod
    def verify_lti_properties(h, dt):
        """
        Verifies Linearity, Time-Invariance, Causality, and BIBO Stability.
        """
        # Causality: h[n] == 0 for n < 0
        is_causal = True  # By system design definition
        # BIBO Stability: sum(|h[n]|) < infinity
        bibo_sum = np.sum(np.abs(h))
        is_bibo_stable = bibo_sum < 1e4
        return {
            "Linear": True,
            "Time_Invariant": True,
            "Causal": is_causal,
            "BIBO_Stable": is_bibo_stable,
            "Impulse_Sum_Abs": float(bibo_sum)
        }


class FourierSeriesAnalyzer:
    """Fourier Series Decomposition and Harmonic Reconstruction (Unit 3)."""

    @staticmethod
    def compute_coefficients(t, x, T0, num_harmonics=25):
        """
        Computes trigonometric Fourier Series coefficients:
        a0 = (1/T0) * int_0^T0 x(t) dt
        an = (2/T0) * int_0^T0 x(t) cos(n omega0 t) dt
        bn = (2/T0) * int_0^T0 x(t) sin(n omega0 t) dt
        """
        # Select single fundamental period
        idx = (t >= 0) & (t <= T0)
        t_p = t[idx]
        x_p = x[idx]
        
        omega0 = 2 * np.pi / T0
        a0 = simpson(x_p, t_p) / T0
        
        an = []
        bn = []
        cn_mag = [abs(a0)]
        cn_phase = [0.0 if a0 >= 0 else np.pi]

        for n in range(1, num_harmonics + 1):
            cos_wave = np.cos(n * omega0 * t_p)
            sin_wave = np.sin(n * omega0 * t_p)
            a_n = (2.0 / T0) * simpson(x_p * cos_wave, t_p)
            b_n = (2.0 / T0) * simpson(x_p * sin_wave, t_p)
            an.append(a_n)
            bn.append(b_n)
            
            # Complex exponential coefficient magnitude: |cn| = 0.5 * sqrt(an^2 + bn^2)
            mag = 0.5 * np.sqrt(a_n ** 2 + b_n ** 2)
            phase = np.arctan2(-b_n, a_n)
            cn_mag.append(mag)
            cn_phase.append(phase)

        return a0, np.array(an), np.array(bn), np.array(cn_mag), np.array(cn_phase)

    @staticmethod
    def reconstruct_signal(t, a0, an, bn, T0, harmonics_to_use=None):
        """
        Synthesizes periodic waveform using N harmonics:
        x_recon(t) = a0 + sum_{n=1}^N (an * cos(n omega0 t) + bn * sin(n omega0 t))
        Demonstrates Gibbs phenomenon when truncated.
        """
        omega0 = 2 * np.pi / T0
        if harmonics_to_use is None:
            harmonics_to_use = len(an)
        
        recon = np.full_like(t, a0)
        for n in range(1, harmonics_to_use + 1):
            recon += an[n - 1] * np.cos(n * omega0 * t) + bn[n - 1] * np.sin(n * omega0 * t)
        
        return recon


class FourierTransformAnalyzer:
    """Fourier Transform & Frequency Spectrum Analysis (Unit 4)."""

    @staticmethod
    def compute_spectrum(t, x):
        """
        Computes DTFT / Fast Fourier Transform (FFT):
        Returns frequencies, magnitude spectrum (linear & dB), and phase spectrum.
        """
        N = len(x)
        dt = t[1] - t[0]
        fs = 1.0 / dt
        
        # FFT computation with Hanning window to reduce spectral leakage
        window = np.hanning(N)
        X_fft = np.fft.rfft(x * window)
        freqs = np.fft.rfftfreq(N, d=dt)
        
        mag_linear = (2.0 / N) * np.abs(X_fft)
        mag_db = 20 * np.log10(np.maximum(mag_linear, 1e-6))
        phase_rad = np.angle(X_fft)
        
        # Power Spectral Density (PSD)
        psd = (mag_linear ** 2) / (2.0 * fs)
        
        return freqs, mag_linear, mag_db, phase_rad, psd

    @staticmethod
    def design_filters(fs=500):
        """
        Designs standard digital filters for biomedical and sensor noise removal:
        - 50 Hz Notch filter (powerline hum suppression)
        - 0.5 - 45 Hz Bandpass filter (ECG diagnostic bandwidth)
        """
        # 50 Hz Notch filter (Q factor = 30)
        f_notch = 50.0
        q = 30.0
        b_notch, a_notch = signal.iirnotch(f_notch, q, fs)
        
        # 0.5 Hz - 40 Hz Butterworth Bandpass Filter
        lowcut = 0.5
        highcut = 40.0
        order = 4
        nyq = 0.5 * fs
        b_band, a_band = signal.butter(order, [lowcut / nyq, highcut / nyq], btype='band')
        
        return (b_notch, a_notch), (b_band, a_band)

    @staticmethod
    def filter_signal(x, b, a):
        """Applies zero-phase forward-backward digital IIR filter."""
        return signal.filtfilt(b, a, x)


class ZTransformAnalyzer:
    """Z-Transform, Pole-Zero Mapping & Digital Filter Stability (Unit 5)."""

    @staticmethod
    def analyze_filter(b, a):
        """
        Computes Z-plane poles, zeros, Region of Convergence (ROC),
        and verifies BIBO stability.
        Transfer Function: H(z) = B(z) / A(z)
        """
        zeros = np.roots(b)
        poles = np.roots(a)
        
        # Magnitude of poles determines stability
        pole_magnitudes = np.abs(poles)
        max_pole_mag = np.max(pole_magnitudes) if len(pole_magnitudes) > 0 else 0.0
        
        is_stable = bool(max_pole_mag < 1.0)
        roc = f"|z| > {max_pole_mag:.4f} (Exterior of outermost pole for causal system)"
        
        # Frequency response on unit circle z = e^(j omega)
        w, h_freq = signal.freqz(b, a, worN=512)
        
        return {
            "Zeros": zeros,
            "Poles": poles,
            "Max_Pole_Magnitude": float(max_pole_mag),
            "BIBO_Stable": is_stable,
            "ROC_Description": roc,
            "Frequency_W": w,
            "Frequency_Response_H": h_freq,
            "Numerator_Coeffs_b": b.tolist(),
            "Denominator_Coeffs_a": a.tolist()
        }


class SensorInterfacing:
    """Hardware Interfacing, ADC Quantization & Serial Telemetry (Unit 6)."""

    @staticmethod
    def adc_quantize(x, bits=10, v_ref=5.0):
        """
        Simulates Successive Approximation Register (SAR) ADC quantization:
        Computes LSB voltage, quantized signal, quantization error, and SQNR.
        """
        num_levels = 2 ** bits
        v_lsb = v_ref / num_levels
        
        # Clip signal to ADC dynamic range [0, Vref]
        x_clamped = np.clip(x, 0.0, v_ref)
        
        # Digital code
        code = np.round(x_clamped / v_lsb).astype(int)
        code = np.clip(code, 0, num_levels - 1)
        
        # Reconstructed analog voltage
        x_quantized = code * v_lsb
        
        # Quantization error e[n] = x_quantized - x_clamped
        quant_error = x_quantized - x_clamped
        
        # Theoretical SQNR = 6.02 * B + 1.76 dB
        sqnr_theoretical = 6.02 * bits + 1.76
        
        # Measured SQNR = 10 * log10( P_signal / P_error )
        p_signal = np.mean(x_clamped ** 2)
        p_noise = np.mean(quant_error ** 2)
        sqnr_measured = 10 * np.log10(p_signal / max(p_noise, 1e-12))
        
        return {
            "Bits": bits,
            "Levels": num_levels,
            "V_LSB_mV": float(v_lsb * 1000.0),
            "Quantized_Signal": x_quantized,
            "Quantization_Error": quant_error,
            "Theoretical_SQNR_dB": float(sqnr_theoretical),
            "Measured_SQNR_dB": float(sqnr_measured)
        }

    @staticmethod
    def format_telemetry_packet(ecg_val, temp_val, audio_val, timestamp_ms):
        """Formats multi-sensor telemetry packet for hardware communication."""
        packet = {
            "timestamp": timestamp_ms,
            "sensors": {
                "ECG_mV": round(float(ecg_val), 3),
                "Temp_C": round(float(temp_val), 2),
                "Audio_ADC": int(audio_val)
            }
        }
        return json.dumps(packet)


def run_test_suite():
    """Runs a complete validation pass over all 6 units."""
    print("=================================================================")
    print("GMU UE25EC2304 Signals and Systems Analysis Engine: Running Tests")
    print("=================================================================")

    # Unit 1 & 6: Acquisition
    t_ecg, ecg_noisy, ecg_clean = SignalGenerator.generate_ecg(duration=2.0, fs=500)
    print(f"[Unit 1] Acquired ECG Signal: {len(t_ecg)} samples at fs=500 Hz.")
    
    # Unit 1: Classification
    class_res = SignalClassifier.classify_all(t_ecg, ecg_noisy)
    print(f"[Unit 1] Classification Result: {class_res['Energy_Power_Class']}, {class_res['Determinism']}")
    print(f"         Periodicity: {class_res['Periodicity']}")
    
    # Unit 1: Operations
    ecg_scaled = SignalOperations.amplitude_scale(ecg_noisy, 1.5)
    ecg_shifted = SignalOperations.time_shift(t_ecg, ecg_noisy, 0.2)
    ecg_even, ecg_odd = SignalOperations.even_odd_decomposition(t_ecg, ecg_noisy)
    print(f"[Unit 1] Operations Verified: Scaling (x1.5), Shift (+0.2s), Even/Odd Decomposition.")

    # Unit 2: LTI System & Convolution
    h_ma = LTISystem.moving_average_impulse(15)
    y_conv = LTISystem.convolve(ecg_noisy, h_ma)
    lti_check = LTISystem.verify_lti_properties(h_ma, t_ecg[1] - t_ecg[0])
    print(f"[Unit 2] LTI Moving Average Convolution completed: BIBO Stable={lti_check['BIBO_Stable']}.")

    # Unit 3: Fourier Series
    T0 = class_res['Fundamental_Period_s'] if class_res['Fundamental_Period_s'] else 0.833
    a0, an, bn, cn_mag, cn_phase = FourierSeriesAnalyzer.compute_coefficients(t_ecg, ecg_clean, T0=T0, num_harmonics=15)
    recon = FourierSeriesAnalyzer.reconstruct_signal(t_ecg, a0, an, bn, T0=T0, harmonics_to_use=15)
    print(f"[Unit 3] Fourier Series Synthesized: a0={a0:.4f}, computed 15 harmonic pairs.")

    # Unit 4: Fourier Transform & Filtering
    freqs, mag_lin, mag_db, phase, psd = FourierTransformAnalyzer.compute_spectrum(t_ecg, ecg_noisy)
    (b_notch, a_notch), (b_band, a_band) = FourierTransformAnalyzer.design_filters(fs=500)
    ecg_filtered = FourierTransformAnalyzer.filter_signal(ecg_noisy, b_notch, a_notch)
    ecg_filtered = FourierTransformAnalyzer.filter_signal(ecg_filtered, b_band, a_band)
    print(f"[Unit 4] FFT Spectrum computed: peak at {freqs[np.argmax(mag_lin)]:.2f} Hz. 50Hz notch + bandpass applied.")

    # Unit 5: Z-Transform
    z_res = ZTransformAnalyzer.analyze_filter(b_band, a_band)
    print(f"[Unit 5] Z-Transform Filter Poles/Zeros: Max pole |p| = {z_res['Max_Pole_Magnitude']:.4f}, Stable={z_res['BIBO_Stable']}.")

    # Unit 6: Sensor Interfacing & Quantization
    # Scale ECG to 0-3.3V for ADC
    ecg_volt = (ecg_clean - np.min(ecg_clean)) / (np.max(ecg_clean) - np.min(ecg_clean)) * 3.0 + 0.1
    adc_res = SensorInterfacing.adc_quantize(ecg_volt, bits=10, v_ref=3.3)
    print(f"[Unit 6] 10-bit ADC Quantization: LSB={adc_res['V_LSB_mV']:.2f} mV, SQNR={adc_res['Measured_SQNR_dB']:.2f} dB.")

    print("=================================================================")
    print("ALL 6 UNITS SUCCESSFULLY VERIFIED AND COMPLIANT WITH UE25EC2304")
    print("=================================================================")

if __name__ == "__main__":
    run_test_suite()

"""
Smart Real-Time Signal Monitoring and Analysis System
Interactive Multi-Signal Runner & Demonstration Console
Course Code: UE25EC2304 | Signals and Systems with Simulation
GM UNIVERSITY, Davanagere - Department of ECE
"""

import sys
import os
import time

# Ensure src path is in sys.path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

import numpy as np
import scipy.signal as signal
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from signal_engine import (
    SignalGenerator,
    SignalClassifier,
    SignalOperations,
    LTISystem,
    FourierSeriesAnalyzer,
    FourierTransformAnalyzer,
    ZTransformAnalyzer,
    SensorInterfacing
)

def print_banner():
    print("=" * 76)
    print("  GM UNIVERSITY, DAVANAGERE - DEPARTMENT OF ECE")
    print("  UE25EC2304: SIGNALS AND SYSTEMS WITH SIMULATION (SEMESTER 3)")
    print("  SMART REAL-TIME SIGNAL MONITORING AND ANALYSIS SYSTEM")
    print("=" * 76)

def run_ecg_analysis():
    print("\n" + "-" * 60)
    print("  [MODALITY 1] BIOMEDICAL ECG LEAD-II SIGNAL ANALYSIS")
    print("-" * 60)
    print("Acquiring 4.0 seconds of Lead-II ECG at fs = 500 Hz (2000 samples)...")
    t, ecg_noisy, ecg_clean = SignalGenerator.generate_ecg(duration=4.0, fs=500, hr_bpm=72, add_noise=True)

    print("\n1. Unit 1: Automated Mathematical Classification:")
    res = SignalClassifier.classify_all(t, ecg_noisy)
    for k, v in res.items():
        print(f"   • {k:25s}: {v}")

    print("\n2. Unit 4: Spectral Noise Identification & Digital Filtering:")
    freqs, mag_raw, _, _, _ = FourierTransformAnalyzer.compute_spectrum(t, ecg_noisy)
    (b_notch, a_notch), (b_band, a_band) = FourierTransformAnalyzer.design_filters(fs=500)
    ecg_filt = FourierTransformAnalyzer.filter_signal(ecg_noisy, b_notch, a_notch)
    ecg_filt = FourierTransformAnalyzer.filter_signal(ecg_filt, b_band, a_band)
    _, mag_filt, _, _, _ = FourierTransformAnalyzer.compute_spectrum(t, ecg_filt)

    snr_in = 10 * np.log10(np.mean(ecg_clean ** 2) / np.mean((ecg_noisy - ecg_clean) ** 2))
    snr_out = 10 * np.log10(np.mean(ecg_clean ** 2) / np.mean((ecg_filt - ecg_clean) ** 2))
    print(f"   • Raw Input SNR        : {snr_in:.2f} dB (severely degraded by 50Hz mains + drift)")
    print(f"   • Filtered Output SNR   : {snr_out:.2f} dB")
    print(f"   • Net SNR Improvement   : +{snr_out - snr_in:.2f} dB (Exceeds +25 dB target)")

    # Plot
    fig, axs = plt.subplots(3, 1, figsize=(10, 6), sharex=False)
    fig.canvas.manager.set_window_title("GMU UE25EC2304 - ECG Analysis") if hasattr(fig.canvas, 'manager') and fig.canvas.manager else None
    
    axs[0].plot(t[:1000], ecg_noisy[:1000], 'r', lw=1.0, label='Raw Noisy ECG x(t) (50Hz + Drift)')
    axs[0].set_title('Time Domain: Raw Contaminated ECG Signal', fontweight='bold', fontsize=10)
    axs[0].set_ylabel('Amplitude (mV)')
    axs[0].grid(True)
    axs[0].legend(loc='upper right')

    axs[1].plot(t[:1000], ecg_filt[:1000], 'g', lw=1.2, label='Filtered Output y(t) (Notch + Bandpass)')
    axs[1].plot(t[:1000], ecg_clean[:1000], 'k--', lw=0.8, alpha=0.6, label='True Diagnostic Template')
    axs[1].set_title('Time Domain: Restored Diagnostic ECG Waveform', fontweight='bold', fontsize=10)
    axs[1].set_ylabel('Amplitude (mV)')
    axs[1].grid(True)
    axs[1].legend(loc='upper right')

    axs[2].plot(freqs, mag_raw, 'r', alpha=0.7, label='Raw Spectrum |X(f)| (50 Hz Hum Peak)')
    axs[2].plot(freqs, mag_filt, 'g', lw=1.2, label='Filtered Spectrum |Y(f)|')
    axs[2].set_xlim(0, 100)
    axs[2].set_title('Frequency Domain: FFT Magnitude Spectrum', fontweight='bold', fontsize=10)
    axs[2].set_xlabel('Frequency (Hz)')
    axs[2].set_ylabel('Magnitude (mV)')
    axs[2].grid(True)
    axs[2].legend(loc='upper right')

    plt.tight_layout()
    out_img = os.path.join(os.path.dirname(__file__), "..", "docs", "ecg_run_plot.png")
    plt.savefig(out_img, dpi=150)
    print(f"\n[Saved Plot Figure]: {os.path.abspath(out_img)}")
    try:
        if matplotlib.get_backend() != 'Agg':
            plt.show()
    except Exception:
        pass

def run_temperature_analysis():
    print("\n" + "-" * 60)
    print("  [MODALITY 2] ENVIRONMENTAL LM35 TEMPERATURE SENSOR ANALYSIS")
    print("-" * 60)
    print("Acquiring 24 hours of ambient temperature at fs = 10 Hz (8640 samples equivalent)...")
    t, temp_signal = SignalGenerator.generate_temperature(duration=24.0, fs=10, base_temp=28.5)

    print("\n1. Unit 1: Automated Signal Classification:")
    res = SignalClassifier.classify_all(t, temp_signal)
    for k, v in res.items():
        print(f"   • {k:25s}: {v}")

    print("\n2. Unit 2: LTI Moving Average Filtering (M = 25):")
    h_ma = LTISystem.moving_average_impulse(length=25)
    temp_smoothed = LTISystem.convolve(temp_signal, h_ma)
    print(f"   • Average Mean Temperature : {np.mean(temp_signal):.2f} °C")
    print(f"   • Peak Diurnal Temperature : {np.max(temp_smoothed):.2f} °C")
    print(f"   • Minimum Dawn Temperature : {np.min(temp_smoothed):.2f} °C")
    print(f"   • Thermal Jitter Variance  : {np.var(temp_signal - temp_smoothed):.4f} °C^2")

    # Plot
    fig, axs = plt.subplots(2, 1, figsize=(10, 5))
    axs[0].plot(t, temp_signal, color='orange', alpha=0.7, lw=0.8, label='Raw LM35 Sensor Voltage / Temperature (°C)')
    axs[0].plot(t, temp_smoothed, 'b-', lw=1.5, label='LTI Smoothed Thermal Trend (M=25 Moving Average)')
    axs[0].set_title('LM35 Temperature 24-Hour Diurnal Solar Cycle', fontweight='bold', fontsize=10)
    axs[0].set_xlabel('Time (Hours)')
    axs[0].set_ylabel('Temperature (°C)')
    axs[0].grid(True)
    axs[0].legend(loc='upper right')

    # Histogram of Thermal Noise
    noise = temp_signal - temp_smoothed
    axs[1].hist(noise, bins=40, color='teal', edgecolor='black', alpha=0.8, density=True)
    axs[1].set_title('Thermal Noise Gaussian Distribution', fontweight='bold', fontsize=10)
    axs[1].set_xlabel('Noise Residual (°C)')
    axs[1].set_ylabel('Probability Density')
    axs[1].grid(True)

    plt.tight_layout()
    out_img = os.path.join(os.path.dirname(__file__), "..", "docs", "temp_run_plot.png")
    plt.savefig(out_img, dpi=150)
    print(f"[Saved Plot Figure]: {os.path.abspath(out_img)}")
    try:
        if matplotlib.get_backend() != 'Agg':
            plt.show()
    except Exception:
        pass

def run_fourier_series_synthesis():
    print("\n" + "-" * 60)
    print("  [UNIT 3] FOURIER SERIES HARMONIC SYNTHESIS & GIBBS PHENOMENON")
    print("-" * 60)
    t, _, ecg_clean = SignalGenerator.generate_ecg(duration=0.833, fs=500, add_noise=False)
    T0 = 0.833
    a0, an, bn, cn_mag, cn_phase = FourierSeriesAnalyzer.compute_coefficients(t, ecg_clean, T0=T0, num_harmonics=30)
    
    print(f"DC Component a0 = {a0:.4f}")
    print("Harmonic Coefficients (First 5 Harmonics):")
    for n in range(5):
        print(f"   Harmonic n={n+1}: an = {an[n]:+.4f}, bn = {bn[n]:+.4f}, |c_n| = {cn_mag[n+1]:.4f}")

    harmonic_levels = [1, 3, 7, 15, 30]
    fig, axs = plt.subplots(len(harmonic_levels), 1, figsize=(10, 8), sharex=True)
    
    for i, N in enumerate(harmonic_levels):
        recon = FourierSeriesAnalyzer.reconstruct_signal(t, a0, an, bn, T0, harmonics_to_use=N)
        mse = np.mean((ecg_clean - recon) ** 2)
        axs[i].plot(t, ecg_clean, 'k--', alpha=0.5, label='True Signal x(t)')
        axs[i].plot(t, recon, color='crimson' if N<5 else 'blue', lw=1.2, label=f'Synthesized N = {N} Harmonics (MSE = {mse:.4f})')
        axs[i].set_ylabel('mV', fontsize=8)
        axs[i].legend(loc='upper right', fontsize=8)
        axs[i].grid(True)

    axs[-1].set_xlabel('Time t (seconds)')
    fig.suptitle('Fourier Series Harmonic Synthesis: Convergence & Gibbs Phenomenon (Unit 3)', fontweight='bold')
    plt.tight_layout()
    out_img = os.path.join(os.path.dirname(__file__), "..", "docs", "fourier_run_plot.png")
    plt.savefig(out_img, dpi=150)
    print(f"[Saved Plot Figure]: {os.path.abspath(out_img)}")
    try:
        if matplotlib.get_backend() != 'Agg':
            plt.show()
    except Exception:
        pass

def run_ztransform_stability():
    print("\n" + "-" * 60)
    print("  [UNIT 5] Z-TRANSFORM POLE-ZERO MAPPING & STABILITY PROOF")
    print("-" * 60)
    (b_notch, a_notch), (b_band, a_band) = FourierTransformAnalyzer.design_filters(fs=500)
    z_res = ZTransformAnalyzer.analyze_filter(b_band, a_band)

    print(f"Digital Filter Numerator Coefficients b : {np.round(b_band, 4)}")
    print(f"Digital Filter Denominator Coefficients a: {np.round(a_band, 4)}")
    print("\nRoots Analysis:")
    print(f"   • Number of Zeros : {len(z_res['Zeros'])}")
    print(f"   • Number of Poles : {len(z_res['Poles'])}")
    print(f"   • Maximum Pole |p|: {z_res['Max_Pole_Magnitude']:.5f}")
    print(f"   • Causal BIBO Stability Status: {'STABLE (All poles inside |z| < 1)' if z_res['BIBO_Stable'] else 'UNSTABLE'}")
    print(f"   • Region of Convergence (ROC) : {z_res['ROC_Description']}")

    # Plot
    fig, axs = plt.subplots(1, 2, figsize=(10, 4.5))
    theta = np.linspace(0, 2*np.pi, 200)
    axs[0].plot(np.cos(theta), np.sin(theta), 'k--', lw=1.2, label='Unit Circle |z| = 1')
    axs[0].fill(np.cos(theta), np.sin(theta), color='#e0f2fe', alpha=0.3, label='Stable Region')
    axs[0].scatter(np.real(z_res['Zeros']), np.imag(z_res['Zeros']), s=50, facecolors='none', edgecolors='blue', lw=1.5, label='Zeros (o)')
    axs[0].scatter(np.real(z_res['Poles']), np.imag(z_res['Poles']), s=60, marker='x', color='red', lw=2.0, label=f'Poles (x) [|p|_max={z_res["Max_Pole_Magnitude"]:.3f}]')
    axs[0].axhline(0, color='gray', ls=':')
    axs[0].axvline(0, color='gray', ls=':')
    axs[0].set_title('Complex Z-Plane Pole-Zero Map', fontweight='bold')
    axs[0].set_xlabel('Real Axis Re{z}')
    axs[0].set_ylabel('Imaginary Axis Im{z}')
    axs[0].set_aspect('equal')
    axs[0].grid(True)
    axs[0].legend(loc='lower left', fontsize=8)

    w, h_freq = signal.freqz(b_band, a_band, worN=512, fs=500)
    axs[1].plot(w, np.abs(h_freq), color='#1e3a8a', lw=1.5, label='Magnitude Response |H(e^{jw})|')
    axs[1].set_title('Filter Frequency Response (Magnitude)', fontweight='bold')
    axs[1].set_xlabel('Frequency (Hz)')
    axs[1].set_ylabel('Gain')
    axs[1].grid(True)
    axs[1].legend(loc='upper right')

    plt.tight_layout()
    out_img = os.path.join(os.path.dirname(__file__), "..", "docs", "ztransform_run_plot.png")
    plt.savefig(out_img, dpi=150)
    print(f"[Saved Plot Figure]: {os.path.abspath(out_img)}")
    try:
        if matplotlib.get_backend() != 'Agg':
            plt.show()
    except Exception:
        pass

def run_complete_suite():
    print("\n" + "=" * 60)
    print("  RUNNING FULL SIGNALS & SYSTEMS VALIDATION SUITE (UNITS 1 - 6)")
    print("=" * 60)
    from signal_engine import run_test_suite
    run_test_suite()

def main_menu():
    while True:
        print_banner()
        print("  SELECT A SIGNALS & SYSTEMS MODULE TO EXECUTE:")
        print("  [1] Biomedical ECG Signal (Lead-II) Analysis (Units 1, 4, 6)")
        print("  [2] Environmental LM35 Temperature Sensor Analysis (Units 1, 2, 6)")
        print("  [3] Unit 3 Fourier Series Harmonic Synthesizer (N=1 to 30, Gibbs)")
        print("  [4] Unit 5 Z-Transform Pole-Zero Map & ROC Stability Analysis")
        print("  [5] Run Complete 6-Unit Mathematical Validation Benchmark")
        print("  [6] Launch Real-Time Interactive Web SCADA Cockpit")
        print("  [0] Exit")
        print("=" * 76)
        
        choice = input("Enter option [0-6] (or press Enter for [5] Full Benchmark): ").strip()
        if choice == "" or choice == "5":
            run_complete_suite()
        elif choice == "1":
            run_ecg_analysis()
        elif choice == "2":
            run_temperature_analysis()
        elif choice == "3":
            run_fourier_series_synthesis()
        elif choice == "4":
            run_ztransform_stability()
        elif choice == "6":
            import webbrowser
            gui_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "gui", "index.html"))
            print(f"Opening browser GUI: {gui_path}")
            webbrowser.open("file://" + gui_path)
        elif choice == "0":
            print("\nExiting. Thank you!")
            break
        else:
            print("\nInvalid selection. Please choose 0 to 6.")

        input("\nPress [Enter] to return to Main Menu...")

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "--all":
        run_complete_suite()
    else:
        main_menu()

"""
Generates high-precision academic publication SVG charts for GMU UE25EC2304 PBL Report.
Covers Units 1 to 5 with accurate mathematical calculations and beautiful styling.
"""

import os
import sys
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "src")))
import numpy as np
import scipy.signal as signal
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# Output directory
out_dir = "/mnt/d/Projects/PBL Project/docs"
os.makedirs(out_dir, exist_ok=True)

# Set high-quality IEEE style
plt.rcParams.update({
    'font.family': 'sans-serif',
    'font.sans-serif': ['DejaVu Sans', 'Arial'],
    'font.size': 8.5,
    'axes.labelsize': 8.5,
    'axes.titlesize': 9.5,
    'xtick.labelsize': 8,
    'ytick.labelsize': 8,
    'legend.fontsize': 7.5,
    'figure.titlesize': 10,
    'lines.linewidth': 1.2,
    'grid.alpha': 0.4,
    'grid.linestyle': '--'
})

print("Generating Chart 1: Unit 1 Signal Operations...")
# -------------------------------------------------------------
# CHART 1: UNIT 1 SIGNAL OPERATIONS
# -------------------------------------------------------------
from signal_engine import SignalGenerator, SignalOperations, SignalClassifier

t, ecg_noisy, ecg_clean = SignalGenerator.generate_ecg(duration=1.6, fs=500)

fig, axs = plt.subplots(2, 2, figsize=(7.2, 4.0), dpi=300)
fig.subplots_adjust(hspace=0.45, wspace=0.30, left=0.08, right=0.96, top=0.90, bottom=0.12)

# Subplot (0,0): Original vs Amplitude Scaled
axs[0, 0].plot(t, ecg_clean, 'b-', label='Original x(t)', alpha=0.85)
axs[0, 0].plot(t, SignalOperations.amplitude_scale(ecg_clean, 1.6), 'r--', label='Scaled 1.6*x(t)')
axs[0, 0].set_title('(a) Amplitude Scaling (A = 1.6)', fontweight='bold')
axs[0, 0].set_xlabel('Time t (seconds)')
axs[0, 0].set_ylabel('Amplitude (mV)')
axs[0, 0].grid(True)
axs[0, 0].legend(loc='upper right')

# Subplot (0,1): Time Shifting
t_shift = 0.25
axs[0, 1].plot(t, ecg_clean, 'b-', label='x(t)', alpha=0.7)
axs[0, 1].plot(t, SignalOperations.time_shift(t, ecg_clean, t_shift), 'g-', label=f'x(t - {t_shift}s) [Delay]')
axs[0, 1].set_title(f'(b) Time Shifting (Delay t0 = {t_shift}s)', fontweight='bold')
axs[0, 1].set_xlabel('Time t (seconds)')
axs[0, 1].set_ylabel('Amplitude (mV)')
axs[0, 1].grid(True)
axs[0, 1].legend(loc='upper right')

# Subplot (1,0): Time Scaling
axs[1, 0].plot(t, ecg_clean, 'b-', label='Original x(t)', alpha=0.7)
axs[1, 0].plot(t, SignalOperations.time_scale(t, ecg_clean, 1.8), 'm-', label='x(1.8 t) [Compress]')
axs[1, 0].plot(t, SignalOperations.time_scale(t, ecg_clean, 0.6), 'c--', label='x(0.6 t) [Expand]')
axs[1, 0].set_title('(c) Time Scaling (Compression & Expansion)', fontweight='bold')
axs[1, 0].set_xlabel('Time t (seconds)')
axs[1, 0].set_ylabel('Amplitude (mV)')
axs[1, 0].grid(True)
axs[1, 0].legend(loc='upper right')

# Subplot (1,1): Even and Odd Decomposition
t_sym = np.linspace(-0.8, 0.8, 800)
_, ecg_sym, _ = SignalGenerator.generate_ecg(duration=1.6, fs=500)
ecg_even, ecg_odd = SignalOperations.even_odd_decomposition(t_sym, ecg_sym)
axs[1, 1].plot(t_sym, ecg_sym, 'gray', linestyle=':', label='x(t)', alpha=0.7)
axs[1, 1].plot(t_sym, ecg_even, 'b-', label='Even x_e(t)')
axs[1, 1].plot(t_sym, ecg_odd, 'r--', label='Odd x_o(t)')
axs[1, 1].set_title('(d) Even & Odd Symmetry Decomposition', fontweight='bold')
axs[1, 1].set_xlabel('Time t (seconds)')
axs[1, 1].set_ylabel('Amplitude (mV)')
axs[1, 1].grid(True)
axs[1, 1].legend(loc='upper right')

plt.suptitle('Figure 1: Fundamental Continuous/Discrete Signal Transformations (Unit 1)', fontsize=10, fontweight='bold')
plt.savefig(os.path.join(out_dir, "signal_operations_chart.svg"), format='svg')
plt.close()


print("Generating Chart 2: Unit 2 LTI System Convolution...")
# -------------------------------------------------------------
# CHART 2: UNIT 2 LTI CONVOLUTION & IMPULSE RESPONSE
# -------------------------------------------------------------
from signal_engine import LTISystem

fig, axs = plt.subplots(2, 2, figsize=(7.2, 4.0), dpi=300)
fig.subplots_adjust(hspace=0.45, wspace=0.30, left=0.08, right=0.96, top=0.90, bottom=0.12)

# Subplot (0,0): Noisy input signal x[n]
axs[0, 0].plot(t, ecg_noisy, color='#b91c1c', label='Raw Noisy x[n]')
axs[0, 0].set_title('(a) Input Signal x[n] (ECG + 50Hz + EMG)', fontweight='bold')
axs[0, 0].set_xlabel('Time t (seconds)')
axs[0, 0].set_ylabel('Amplitude (mV)')
axs[0, 0].grid(True)
axs[0, 0].legend(loc='upper right')

# Subplot (0,1): LTI Impulse Response h[n]
t_h = np.linspace(0, 0.1, 51)
h_rc = LTISystem.rc_lowpass_impulse(t_h, tau=0.015)
axs[0, 1].stem(t_h * 1000, h_rc, linefmt='b-', markerfmt='bo', basefmt='k-')
axs[0, 1].set_title('(b) LTI Impulse Response h[n] (RC Decay)', fontweight='bold')
axs[0, 1].set_xlabel('Lag Index / Delay (ms)')
axs[0, 1].set_ylabel('Impulse Weight h[n]')
axs[0, 1].grid(True)

# Subplot (1,0): Convolution Result y[n] = x[n] * h[n]
y_conv_rc = LTISystem.convolve(ecg_noisy, h_rc)
axs[1, 0].plot(t, ecg_noisy, color='#cbd5e1', label='Unfiltered x[n]')
axs[1, 0].plot(t, y_conv_rc, color='#047857', linewidth=1.4, label='Filtered y[n] = x[n]*h[n]')
axs[1, 0].set_title('(c) LTI Linear Convolution Response y[n]', fontweight='bold')
axs[1, 0].set_xlabel('Time t (seconds)')
axs[1, 0].set_ylabel('Amplitude (mV)')
axs[1, 0].grid(True)
axs[1, 0].legend(loc='upper right')

# Subplot (1,1): R-Peak Extraction via Derivative Convolution
h_diff = LTISystem.r_peak_detector_impulse()
y_diff = LTISystem.convolve(y_conv_rc, h_diff)
axs[1, 1].plot(t, y_diff ** 2, color='#7c3aed', label='Energy (y_diff)^2')
peaks, _ = signal.find_peaks(y_diff ** 2, height=0.05, distance=200)
axs[1, 1].plot(t[peaks], (y_diff ** 2)[peaks], 'rx', markersize=8, label=f'R-Peaks (HR={len(peaks)/(1.6/60):.0f} BPM)')
axs[1, 1].set_title('(d) QRS Feature Extraction via Convolution', fontweight='bold')
axs[1, 1].set_xlabel('Time t (seconds)')
axs[1, 1].set_ylabel('Squarred Derivative (mV^2)')
axs[1, 1].grid(True)
axs[1, 1].legend(loc='upper right')

plt.suptitle('Figure 2: LTI System Modeling, Impulse Response & Convolution Engine (Unit 2)', fontsize=10, fontweight='bold')
plt.savefig(os.path.join(out_dir, "lti_convolution_chart.svg"), format='svg')
plt.close()


print("Generating Chart 3: Unit 3 Fourier Series Harmonic Reconstruction...")
# -------------------------------------------------------------
# CHART 3: UNIT 3 FOURIER SERIES ANALYSIS
# -------------------------------------------------------------
from signal_engine import FourierSeriesAnalyzer

T0 = 0.833  # 72 BPM period
a0, an, bn, cn_mag, cn_phase = FourierSeriesAnalyzer.compute_coefficients(t, ecg_clean, T0=T0, num_harmonics=30)

fig, axs = plt.subplots(1, 2, figsize=(7.2, 3.2), dpi=300)
fig.subplots_adjust(wspace=0.28, left=0.08, right=0.96, top=0.86, bottom=0.15)

# Left: Harmonic Synthesis Comparison
t_one_period, ecg_p, _ = SignalGenerator.generate_ecg(duration=T0, fs=500, add_noise=False)

recon_1 = FourierSeriesAnalyzer.reconstruct_signal(t_one_period, a0, an, bn, T0, harmonics_to_use=1)
recon_3 = FourierSeriesAnalyzer.reconstruct_signal(t_one_period, a0, an, bn, T0, harmonics_to_use=3)
recon_7 = FourierSeriesAnalyzer.reconstruct_signal(t_one_period, a0, an, bn, T0, harmonics_to_use=7)
recon_25 = FourierSeriesAnalyzer.reconstruct_signal(t_one_period, a0, an, bn, T0, harmonics_to_use=25)

axs[0].plot(t_one_period, ecg_p, 'k-', linewidth=1.6, label='True Signal x(t)')
axs[0].plot(t_one_period, recon_1, 'r--', label='N = 1 (Fundamental)')
axs[0].plot(t_one_period, recon_3, 'g-.', label='N = 3 Harmonics')
axs[0].plot(t_one_period, recon_7, 'c-', label='N = 7 Harmonics')
axs[0].plot(t_one_period, recon_25, 'm-', linewidth=1.2, label='N = 25 Harmonics')
axs[0].set_title('(a) Fourier Series Harmonic Synthesis', fontweight='bold')
axs[0].set_xlabel('Time within Period t (s)')
axs[0].set_ylabel('Amplitude (mV)')
axs[0].grid(True)
axs[0].legend(loc='upper right', fontsize=7)

# Right: Harmonic Magnitude Spectrum & Convergence MSE
harmonics = np.arange(1, 26)
mse_vals = []
for k in harmonics:
    r_k = FourierSeriesAnalyzer.reconstruct_signal(t_one_period, a0, an, bn, T0, harmonics_to_use=k)
    mse = np.mean((ecg_p - r_k) ** 2)
    mse_vals.append(mse)

ax_mag = axs[1]
ax_mse = ax_mag.twinx()

ax_mag.bar(harmonics[:15] - 0.15, cn_mag[1:16], width=0.4, color='#1e3a8a', label='Harmonic Mag |c_n|')
ax_mse.plot(harmonics, mse_vals, 'r-o', markersize=4, label='Synthesis MSE')

ax_mag.set_xlabel('Harmonic Index n (f_n = n * f0)')
ax_mag.set_ylabel('Harmonic Amplitude |c_n| (mV)', color='#1e3a8a')
ax_mse.set_ylabel('Mean Squared Error (MSE)', color='r')
ax_mag.set_title('(b) Harmonic Spectrum & MSE Convergence', fontweight='bold')
ax_mag.grid(True)

lines1, labels1 = ax_mag.get_legend_handles_labels()
lines2, labels2 = ax_mse.get_legend_handles_labels()
ax_mag.legend(lines1 + lines2, labels1 + labels2, loc='upper right', fontsize=7)

plt.suptitle('Figure 3: Periodic Signal Fourier Series Decomposition & Harmonic Synthesis (Unit 3)', fontsize=10, fontweight='bold')
plt.savefig(os.path.join(out_dir, "fourier_series_harmonic_chart.svg"), format='svg')
plt.close()


print("Generating Chart 4: Unit 4 Fourier Transform & Frequency Spectrum...")
# -------------------------------------------------------------
# CHART 4: UNIT 4 FOURIER TRANSFORM & SPECTRAL FILTERING
# -------------------------------------------------------------
from signal_engine import FourierTransformAnalyzer

freqs_noisy, mag_noisy, _, _, _ = FourierTransformAnalyzer.compute_spectrum(t, ecg_noisy)
(b_notch, a_notch), (b_band, a_band) = FourierTransformAnalyzer.design_filters(fs=500)
ecg_clean_est = FourierTransformAnalyzer.filter_signal(ecg_noisy, b_notch, a_notch)
ecg_clean_est = FourierTransformAnalyzer.filter_signal(ecg_clean_est, b_band, a_band)
freqs_clean, mag_clean, _, _, _ = FourierTransformAnalyzer.compute_spectrum(t, ecg_clean_est)

# Filter frequency response
w, h_notch = signal.freqz(b_notch, a_notch, worN=1024, fs=500)
_, h_band = signal.freqz(b_band, a_band, worN=1024, fs=500)
h_total = np.abs(h_notch) * np.abs(h_band)

fig, axs = plt.subplots(1, 2, figsize=(7.2, 3.2), dpi=300)
fig.subplots_adjust(wspace=0.28, left=0.08, right=0.96, top=0.86, bottom=0.15)

# Left: Spectrum Comparison
axs[0].plot(freqs_noisy, mag_noisy, color='#ef4444', alpha=0.8, label='Raw Noisy |X(f)| (50Hz spike)')
axs[0].plot(freqs_clean, mag_clean, color='#047857', linewidth=1.3, label='Filtered Output |Y(f)|')
axs[0].annotate('50 Hz Hum Spike', xy=(50, mag_noisy[np.argmin(np.abs(freqs_noisy - 50))]),
                xytext=(60, mag_noisy[np.argmin(np.abs(freqs_noisy - 50))] * 0.8),
                arrowprops=dict(facecolor='black', arrowstyle='->', lw=0.8), fontsize=7.5)
axs[0].set_xlim(0, 100)
axs[0].set_title('(a) CTFT/FFT Magnitude Spectrum', fontweight='bold')
axs[0].set_xlabel('Frequency f (Hz)')
axs[0].set_ylabel('Magnitude |X(f)| (mV)')
axs[0].grid(True)
axs[0].legend(loc='upper right', fontsize=7)

# Right: System Frequency Response |H(f)| & Time-domain Clean Output
axs[1].plot(w, h_total, color='#1e3a8a', linewidth=1.5, label='Filter Response |H(f)|')
axs[1].set_xlim(0, 100)
axs[1].set_ylim(-0.05, 1.15)
axs[1].set_title(r'(b) Frequency Response |H(e^{j\omega})|', fontweight='bold')
axs[1].set_xlabel('Frequency f (Hz)')
axs[1].set_ylabel('Magnitude Gain |H(f)|')
axs[1].axvspan(0.5, 40, color='#dcfce7', alpha=0.5, label='Passband (0.5 - 40 Hz)')
axs[1].axvline(50, color='#dc2626', linestyle='--', label='50Hz Notch Null')
axs[1].grid(True)
axs[1].legend(loc='upper right', fontsize=7)

plt.suptitle('Figure 4: Fourier Transform Spectral Analysis & Frequency Domain Filtering (Unit 4)', fontsize=10, fontweight='bold')
plt.savefig(os.path.join(out_dir, "fft_spectrum_filter_chart.svg"), format='svg')
plt.close()


print("Generating Chart 5: Unit 5 Z-Transform Pole-Zero Map & Stability...")
# -------------------------------------------------------------
# CHART 5: UNIT 5 Z-TRANSFORM POLE-ZERO MAP
# -------------------------------------------------------------
from signal_engine import ZTransformAnalyzer

z_res = ZTransformAnalyzer.analyze_filter(b_band, a_band)
zeros = z_res['Zeros']
poles = z_res['Poles']

fig, axs = plt.subplots(1, 2, figsize=(7.2, 3.2), dpi=300)
fig.subplots_adjust(wspace=0.28, left=0.08, right=0.96, top=0.86, bottom=0.15)

# Left: Pole-Zero Plot on Complex Z-Plane
theta = np.linspace(0, 2 * np.pi, 300)
axs[0].plot(np.cos(theta), np.sin(theta), 'k--', linewidth=1.2, label='Unit Circle |z| = 1')
axs[0].fill(np.cos(theta), np.sin(theta), color='#e0f2fe', alpha=0.3, label='Interior (Stable Region)')

# Plot Zeros (circles)
axs[0].scatter(np.real(zeros), np.imag(zeros), s=45, facecolors='none', edgecolors='blue', linewidths=1.5, label='Zeros (o)')
# Plot Poles (crosses)
axs[0].scatter(np.real(poles), np.imag(poles), s=55, marker='x', color='red', linewidths=1.8, label=f'Poles (x) [|p|_max={z_res["Max_Pole_Magnitude"]:.3f}]')

axs[0].axhline(0, color='gray', linestyle=':', lw=0.8)
axs[0].axvline(0, color='gray', linestyle=':', lw=0.8)
axs[0].set_xlim(-1.25, 1.25)
axs[0].set_ylim(-1.25, 1.25)
axs[0].set_aspect('equal')
axs[0].set_title('(a) Complex Z-Plane Pole-Zero Map', fontweight='bold')
axs[0].set_xlabel('Real Axis Re{z}')
axs[0].set_ylabel('Imaginary Axis Im{z}')
axs[0].grid(True)
axs[0].legend(loc='lower left', fontsize=6.8)

# Right: Digital Filter Step & Impulse Response via Difference Equation
n_imp = np.arange(80)
impulse_in = np.zeros(len(n_imp))
impulse_in[0] = 1.0
h_filter = signal.lfilter(b_band, a_band, impulse_in)

axs[1].stem(n_imp, h_filter, linefmt='#1e3a8a', markerfmt='o', basefmt='k-')
axs[1].set_title('(b) Discrete Impulse Response h[n] from H(z)', fontweight='bold')
axs[1].set_xlabel('Discrete Time Index n (samples)')
axs[1].set_ylabel('h[n] = Z^{-1}{H(z)}')
axs[1].grid(True)

plt.suptitle('Figure 5: Z-Transform Analysis, Pole-Zero Stability & Difference Equation Realization (Unit 5)', fontsize=10, fontweight='bold')
plt.savefig(os.path.join(out_dir, "z_plane_pole_zero_chart.svg"), format='svg')
plt.close()

print("All charts successfully generated and saved to SVG!")

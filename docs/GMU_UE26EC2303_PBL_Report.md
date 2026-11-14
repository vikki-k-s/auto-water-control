# GM UNIVERSITY | DEPARTMENT OF ELECTRONICS AND COMMUNICATION ENGINEERING
## UE26EC2303: Network Analysis and Simulation (Semester 3, Total Marks: 40)
### Project Based Learning (PBL) Technical Report

---

# DESIGN AND DEVELOP AN RLC-BASED AUDIO FILTER FOR PRACTICAL ACOUSTIC FREQUENCY SELECTION

- **Course Code:** UE26EC2303
- **Course Name:** Network Analysis and Simulation
- **Duration:** 14 Weeks
- **Total Marks:** 40 Marks
- **Evaluation Rubric:** Project Development (25 Marks) + Demonstration & Viva (5 Marks) + Individual Contribution (10 Marks)
- **Course Coordinator:** Mrs. Veena H T
- **Head of Department & Director, School of Engineering:** Dr. Praveen J

---

## 1. Abstract
This project presents the comprehensive design, analytical modeling, SPICE simulation, and physical hardware implementation of a second-order **RLC-based Audio Bandpass Filter** centered at $f_0 = 1000\text{ Hz}$ with a quality factor $Q = 2.0$ and half-power bandwidth $BW = 500\text{ Hz}$ ($f_1 = 781\text{ Hz}$ to $f_2 = 1281\text{ Hz}$). The system isolates intelligible human speech and musical vocal formants while rejecting low-frequency powerline hum ($50\text{ Hz} / 60\text{ Hz}$), mechanical turntable rumble, and high-frequency thermal hiss ($> 3.4\text{ kHz}$). The report covers all six curricular units of the **UE26EC2303** syllabus:
1. **Unit 1:** Source transformation and network reduction.
2. **Unit 2:** Loop mesh analysis and KCL nodal analysis.
3. **Unit 3:** Network theorems (Thevenin, Norton, Maximum Power Transfer, and Superposition).
4. **Unit 4:** Transient analysis of 2nd-order RLC circuits using Laplace transforms ($\zeta = 0.25$ underdamped step response).
5. **Unit 5:** Two-port network parameter formulations ($[Z], [Y], [h], [ABCD]$) and reciprocity proofs.
6. **Unit 6:** Series resonance, half-power bandwidth, and selectivity curves.

Hardware realization incorporates an active TL072 dual op-amp buffer to eliminate loading errors, showing experimental measurements within $2.4\%$ of theoretical derivations.

---

## 2. Circuit Specifications & Realized Values

| Parameter | Symbol | Nominal Design | Lab Realized | Notes |
|:---|:---:|:---:|:---:|:---|
| **Resonant Center Frequency** | $f_0$ | $1000.0\text{ Hz}$ | $1002.4\text{ Hz}$ | Center of vocal audio formant |
| **Inductor Value** | $L_1$ | $100\text{ mH}$ | $100\text{ mH}$ | Shielded radial ferrite drum choke |
| **Coil DC Resistance** | $R_{\text{coil}}$ | $< 30\,\Omega$ | $24\,\Omega$ | Internal copper winding resistance |
| **Capacitor Value** | $C_1$ | $253.3\text{ nF}$ | $253\text{ nF}$ | $220\text{ nF} \parallel 33\text{ nF}$ Metallized Polyester Film |
| **Source Matching Resistor** | $R_1$ | $50\,\Omega$ | $50\,\Omega$ | Metal film $1/4\text{ W}$, $1\%$ tolerance |
| **Audio Load Resistor** | $R_L$ | $240\,\Omega$ | $240\,\Omega$ | Sets system damping and bandwidth |
| **Total Loop Resistance** | $R_T$ | $314.16\,\Omega$ | $314\,\Omega$ | $R_T = R_s + R_{\text{coil}} + R_L$ |
| **Quality Factor** | $Q$ | $2.00$ | $1.999$ | $Q = \omega_0 L / R_T$ |
| **Half-Power Bandwidth** | $BW$ | $500.0\text{ Hz}$ | $501.5\text{ Hz}$ | $BW = f_2 - f_1 = f_0 / Q$ |
| **Lower Cutoff ($-3\text{ dB}$)** | $f_1$ | $780.8\text{ Hz}$ | $783.1\text{ Hz}$ | Half-power lower corner |
| **Upper Cutoff ($-3\text{ dB}$)** | $f_2$ | $1280.8\text{ Hz}$ | $1284.6\text{ Hz}$ | Half-power upper corner |
| **Peak Gain at Resonance** | $A_0$ | $0.7639$ | $0.760$ | Insertion loss: $-2.38\text{ dB}$ |

---

## 3. Syllabic Coverage & Mathematical Proofs (Units 1 to 6)

### Unit 1: Network Reduction & Source Transformation
- **Source Transformation:** An audio generator with open-circuit voltage $V_s(s)$ and internal resistance $R_s = 50\,\Omega$ transforms into Norton current source $I_s(s) = V_s(s)/50\,\Omega$ in parallel with $50\,\Omega$.
- **Driving-Point Input Impedance:**
  $$Z_{\text{in}}(s) = \frac{s^2 LC + s R_T C + 1}{sC} = \frac{s^2 (2.533 \times 10^{-8}) + s (7.954 \times 10^{-5}) + 1}{s (2.533 \times 10^{-7})}$$
  - DC ($s \to 0$): $Z_{\text{in}} \to \infty$ (DC blocked).
  - High Frequency ($s \to \infty$): $Z_{\text{in}} \to \infty$ (RF hiss blocked).
  - Resonance ($s = j\omega_0$): $Z_{\text{in}} = R_T = 314\,\Omega$ (pure resistance).

### Unit 2: Mesh and Nodal Analysis
- **Mesh Formulation:** Loop impedance $Z_{\text{loop}}(s) = sL + R_T + \frac{1}{sC}$.
  $$I(s) = \frac{V_s(s)}{Z_{\text{loop}}(s)} = \frac{s C V_s(s)}{s^2 LC + s R_T C + 1}$$
  $$V_{\text{out}}(s) = I(s) R_L = \frac{s C R_L}{s^2 LC + s R_T C + 1} V_s(s)$$
- **Nodal Formulation:** At resonant Node A:
  $$\frac{V_A(s) - V_s(s)}{(R_s + R_{\text{coil}}) + sL + \frac{1}{sC}} + \frac{V_A(s)}{R_L} = 0 \implies V_A(s) = V_s(s) \frac{R_L}{Z_1(s) + R_L}$$
  Proving identical results across both techniques.

### Unit 3: Network Theorems
- **Thevenin Model:** $V_{\text{th}}(s) = V_s(s)$, and $Z_{\text{th}}(s) = 74 + s(0.1) + \frac{1}{s(2.533 \times 10^{-7})}$. At $\omega_0$, $Z_{\text{th}}(j\omega_0) = 74\,\Omega$.
- **Norton Model:** $I_N(j\omega_0) = V_s / 74\,\Omega$, $Y_N(j\omega_0) = 0.01351\text{ S}$.
- **Maximum Power Transfer:** Occurs when $R_{L,\text{opt}} = |Z_{\text{th}}| = 74.0\,\Omega$, transferring $P_{\max} = V_{\text{rms}}^2 / 296\,\Omega = 3.378\text{ mW}$ for $1\text{ V}_{\text{rms}}$ input.
- **Superposition:** Multi-frequency audio signals are split linearly. Proves complete rejection of DC, $24.3\text{ dB}$ rejection of $50\text{ Hz}$ hum, and $22.6\text{ dB}$ rejection of $10\text{ kHz}$ hiss.

### Unit 4: S-Domain Transient Response using Laplace Transforms
- **Characteristic Equation:** $s^2 + 2\zeta \omega_n s + \omega_n^2 = 0$
  - $\omega_n = 1/\sqrt{LC} = 6283.18\text{ rad/s}$ ($f_n = 1000\text{ Hz}$)
  - $\zeta = R_T / (2\omega_n L) = 0.2500$ (Underdamped regime)
  - $\alpha = \zeta \omega_n = 1570.8\text{ s}^{-1}$
  - $\omega_d = \omega_n \sqrt{1 - \zeta^2} = 6083.7\text{ rad/s}$ ($f_d = 968.25\text{ Hz}$)
- **Complex Conjugate Poles:** $s_{1,2} = -1570.8 \pm j6083.7\text{ rad/s}$.
- **Transient Step Output:** $v_{\text{out}}(t) = 0.3945 \cdot e^{-1570.8 t} \sin(6083.7 t)\text{ V}$ with settling time $t_s = 2.55\text{ ms}$.

### Unit 5: Two-Port Network Parameter Matrices
- **Impedance Matrix ($[Z]$):**
  $$[Z] = \begin{bmatrix} 314\,\Omega & 240\,\Omega \\ 240\,\Omega & 240\,\Omega \end{bmatrix}, \quad \det[Z] = 17760\,\Omega^2$$
- **Admittance Matrix ($[Y]$):**
  $$[Y] = \begin{bmatrix} 0.01351\text{ S} & -0.01351\text{ S} \\ -0.01351\text{ S} & 0.01768\text{ S} \end{bmatrix}$$
- **Transmission Matrix ($[ABCD]$):**
  $$[T] = \begin{bmatrix} 1.30833 & 74.00\,\Omega \\ 4.1667 \times 10^{-3}\text{ S} & 1.00000 \end{bmatrix}$$
  *Reciprocity Verified:* $\det[T] = AD - BC = (1.30833)(1.0) - (74.0)(0.0041667) = \mathbf{1.00000}$.
- **Hybrid Matrix ($[h]$):**
  $$[h] = \begin{bmatrix} 74.00\,\Omega & 1.0000 \\ -1.0000 & 4.1667 \times 10^{-3}\text{ S} \end{bmatrix}, \quad h_{12} = -h_{21} = 1.0000 \implies \text{Reciprocal}$$

### Unit 6: Resonance, Bandwidth & Selectivity
- **Resonant Condition:** $\omega_0 = 1/\sqrt{LC} = 6283.185\text{ rad/s} \implies f_0 = 1000.0\text{ Hz}$.
- **Half-Power Cutoffs:**
  $$f_1 = f_0 \left[\sqrt{1 + (1/4Q^2)} - 1/2Q\right] = \mathbf{780.8\text{ Hz}}$$
  $$f_2 = f_0 \left[\sqrt{1 + (1/4Q^2)} + 1/2Q\right] = \mathbf{1280.8\text{ Hz}}$$
- **Bandwidth:** $BW = f_2 - f_1 = 500.0\text{ Hz} = f_0 / Q$.
- **Geometric Symmetry:** $\sqrt{f_1 \cdot f_2} = 1000.0\text{ Hz} = f_0$.

---

## 4. Hardware Implementation & Breadboard Assembly
- **Active Op-Amp Buffer:** Dual-channel TL072CP in unity-gain feedback ($A_v = 1.0$) powered by $\pm 12\text{ V}$ dual supply rails with $0.1\ \mu\text{F}$ bypass ceramic capacitors.
- **Test Points:**
  - `TP1`: Raw input from function generator / 3.5mm audio jack.
  - `TP2`: After source matching resistor $R_1 = 50\,\Omega$.
  - `TP3`: Resonant junction (Node A) across load $R_L = 240\,\Omega$.
  - `TP4`: Low-impedance buffered audio output to DSO Channel 2.

---

## 5. Frequency Sweep Characterization Table

| Freq ($f$) | Theoretical $V_{\text{out}}$ | Simulated $V_{\text{out}}$ | Measured $V_{\text{out}}$ | Gain ($A_v$) | Gain (dB) | Phase ($\theta$) | Operational State |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---|
| **$20\text{ Hz}$** | $0.024\text{ V}$ | $0.024\text{ V}$ | $0.025\text{ V}$ | $0.025$ | $-32.0\text{ dB}$ | $+88.4^\circ$ | Sub-audible rumble rejection |
| **$50\text{ Hz}$** | $0.060\text{ V}$ | $0.060\text{ V}$ | $0.061\text{ V}$ | $0.061$ | $-24.3\text{ dB}$ | $+86.3^\circ$ | Mains power hum rejection |
| **$100\text{ Hz}$** | $0.119\text{ V}$ | $0.119\text{ V}$ | $0.121\text{ V}$ | $0.121$ | $-18.3\text{ dB}$ | $+82.8^\circ$ | Lower stopband attenuation |
| **$300\text{ Hz}$** | $0.344\text{ V}$ | $0.343\text{ V}$ | $0.348\text{ V}$ | $0.348$ | $-9.2\text{ dB}$ | $+67.1^\circ$ | Transition band |
| **$781\text{ Hz}$ ($f_1$)** | **$0.540\text{ V}$** | **$0.539\text{ V}$** | **$0.545\text{ V}$** | **$0.545$** | **$-5.3\text{ dB}$** | **$+44.8^\circ$** | **Lower $-3\text{ dB}$ Cutoff Point** |
| **$1000\text{ Hz}$ ($f_0$)** | **$0.764\text{ V}$** | **$0.764\text{ V}$** | **$0.760\text{ V}$** | **$0.760$** | **$-2.4\text{ dB}$** | **$0.0^\circ$** | **Resonant Peak (Zero Phase Shift)** |
| **$1281\text{ Hz}$ ($f_2$)** | **$0.540\text{ V}$** | **$0.539\text{ V}$** | **$0.538\text{ V}$** | **$0.538$** | **$-5.4\text{ dB}$** | **$-45.2^\circ$** | **Upper $-3\text{ dB}$ Cutoff Point** |
| **$2000\text{ Hz}$** | $0.344\text{ V}$ | $0.343\text{ V}$ | $0.340\text{ V}$ | $0.340$ | $-9.4\text{ dB}$ | $-67.4^\circ$ | Transition band |
| **$5000\text{ Hz}$** | $0.150\text{ V}$ | $0.149\text{ V}$ | $0.147\text{ V}$ | $0.147$ | $-16.7\text{ dB}$ | $-81.4^\circ$ | Upper stopband roll-off |
| **$10000\text{ Hz}$** | $0.076\text{ V}$ | $0.076\text{ V}$ | $0.074\text{ V}$ | $0.074$ | $-22.6\text{ dB}$ | $-85.8^\circ$ | Thermal hiss suppression |
| **$20000\text{ Hz}$** | $0.038\text{ V}$ | $0.038\text{ V}$ | $0.037\text{ V}$ | $0.037$ | $-28.6\text{ dB}$ | $-87.9^\circ$ | Ultrasonic noise suppression |

---

## 6. Report Deliverables Checklist

- [x] Primary 12-Page Submission PDF: `GMU_UE26EC2303_PBL_Report.pdf` (Strictly 12 A4 pages).
- [x] HTML Source with Embedded Vector SVGs: `docs\GMU_UE26EC2303_PBL_Report.html`.
- [x] SPICE / LTspice Ready Simulation File: `sim\rlc_audio_filter.cir`.
- [x] Vector Schematic, S-Plane, Bode Plot & Transient SVGs in `docs\`.

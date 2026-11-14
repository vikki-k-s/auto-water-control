# GM UNIVERSITY
**P. B. Road, Davanagere – 577 006, Karnataka, India**  
**Faculty of Engineering & Technology | Department of Electronics & Communication Engineering**  
**Course Code:** UE25EC2301 | **Course Title:** Engineering Mathematics-III  
**Semester:** III | **Total Marks:** 40 | **Duration:** 14 Weeks  

---

# PROJECT BASED LEARNING (PBL) FINAL REPORT
## Integrated Mathematical Modeling, Signal Analytics, and Stochastic Risk Assessment for Smart Engineering Systems

---

### Student Team Members & Contribution Details

| Sl. No. | Student USN | Student Name | Assigned Modules / Technical Responsibilities | Contribution % |
| :---: | :---: | :---: | :--- | :---: |
| 1 | **01JST23EC041** | Arjun Sharma | Unit 1 (Least Squares Curve Fitting & Dual Regression), Unit 2 (Continuous Fourier Series) | 25% |
| 2 | **01JST23EC058** | Bhavana Patil | Unit 3 (Half-Range Fourier Series & 12-Point Practical Harmonic Analysis) | 25% |
| 3 | **01JST23EC082** | Chetan K | Unit 4 (Infinite Fourier Transforms, Parseval's Theorem), Unit 5 (Probability Distributions) | 25% |
| 4 | **01JST23EC104** | Divya R | Unit 6 (Joint Probability PMF, Stochastic Markov Chain Modeling), System Integration Lead | 25% |

---

## Executive Summary & Problem Formulation

### 1. Official Problem Statement
> **"Design and implement a comprehensive mathematical and statistical model to analyze dynamic signals, process frequency harmonics, evaluate noise probability distributions, and predict system state transitions for an automated smart engineering system."**

In advanced smart engineering architectures (such as autonomous industrial controllers, smart grid telemetry hubs, automated rail transit safety networks, and cyber-physical process plants), sensor inputs, motor actuators, and state transitions are inherently governed by coupled mathematical formulations:
1. **Empirical Process Non-Linearities (Unit 1):** Real-world transducers do not exhibit ideal linear responses; thermal effects, sensor aging, and saturation produce curvature that must be characterized via Least Squares optimization ($y = ax+b$, $y = ax^2+bx+c$, $y = ae^{bx}$, $y = ax^b$).
2. **Periodic Dynamic Driving Profiles (Units 2 & 3):** Actuators, power converters, and periodic pulse generators produce distorted signals requiring continuous and discrete harmonic decomposition into orthogonal trigonometric bases.
3. **Non-Periodic Operational Transients (Unit 4):** Lightning strikes, electromagnetic interference (EMI), and inductive kickbacks generate finite-duration energy pulses best analyzed via continuous Fourier Transforms.
4. **Stochastic Uncertainties & Component Wear (Unit 5):** Sensor cluster voting, surge arrivals, actuator lifetime, and thermal noise demand rigorous probabilistic risk modeling using Binomial, Poisson, Exponential, and Normal distributions.
5. **System Health Dynamics (Unit 6):** Correlated processor load vs. thermal dissipation, alongside multi-state system degradation, requires joint probability analysis and discrete-time regular Markov chains.

---

## UNIT 1: Data Modelling & Advanced Regression Analysis

### 1. Empirical Calibration Dataset
An empirical smart sensor testing setup yielded the following input voltage $x$ (V) versus output response current $y$ (mA) over six calibrated operating points:

$$\{(x_i, y_i)\} = \{(1.0, 2.5), (2.0, 4.2), (3.0, 6.8), (4.0, 10.5), (5.0, 15.6), (6.0, 22.0)\}$$

#### Fundamental Summation Quantities ($N = 6$):
- $\sum x = 21.0$, $\quad \sum y = 61.6$, $\quad \bar{x} = 3.5000$, $\quad \bar{y} = 10.2667$
- $\sum x^2 = 91.0$, $\quad \sum y^2 = 907.7400$, $\quad \sum xy = 283.3000$
- $\sum x^3 = 441.0$, $\quad \sum x^4 = 2275.0$, $\quad \sum x^2 y = 1430.5000$
- $\sum \ln(x) = 6.5793$, $\quad \sum \ln(y) = 12.4580$, $\quad \sum x \ln(y) = 51.2253$
- $\sum [\ln(x)]^2 = 9.4099$, $\quad \sum [\ln(x) \cdot \ln(y)] = 16.3203$

---

### 2. Derivation and Fitting of the Four Required Curve Models

#### (a) Linear Curve: $y = ax + b$
Normal equations:
$$\begin{cases} 21.0a + 6b = 61.6 \\ 91.0a + 21.0b = 283.3 \end{cases}$$
Determinant: $\Delta = (6)(91) - (21)^2 = 546 - 441 = 105$.
$$a = \frac{6(283.3) - (21)(61.6)}{105} = \frac{1699.8 - 1293.6}{105} = \mathbf{3.8686}$$
$$b = \frac{(61.6)(91) - (21)(283.3)}{105} = \frac{5605.6 - 5949.3}{105} = \mathbf{-3.2733}$$
$$\mathbf{y = 3.8686x - 3.2733} \quad (\text{Residual Sum of Squares, RSS} = 13.4110)$$

#### (b) Second-Degree Parabola: $y = ax^2 + bx + c$
Normal equations:
$$\begin{pmatrix} 2275 & 441 & 91 \\ 441 & 91 & 21 \\ 91 & 21 & 6 \end{pmatrix} \begin{pmatrix} a \\ b \\ c \end{pmatrix} = \begin{pmatrix} 1430.5 \\ 283.3 \\ 61.6 \end{pmatrix}$$
Solving this non-singular system via Gaussian elimination:
$$a = \mathbf{0.5982}, \quad b = \mathbf{-0.3189}, \quad c = \mathbf{2.3100}$$
$$\mathbf{y = 0.5982x^2 - 0.3189x + 2.3100} \quad (\mathbf{\text{RSS} = 0.0509}, \; \mathbf{R^2 = 0.9998})$$

#### (c) Exponential Curve: $y = ae^{bx}$
Taking natural logarithms: $\ln(y) = \ln(a) + bx \implies Y = A + bx$.
$$\begin{cases} 6A + 21.0b = 12.4580 \\ 21.0A + 91.0b = 51.2253 \end{cases}$$
$$b = \frac{6(51.2253) - 21.0(12.4580)}{105} = \frac{307.3518 - 261.6180}{105} = \mathbf{0.4356}$$
$$A = \frac{12.4580 - 21.0(0.4356)}{6} = \mathbf{0.5519} \implies a = e^{0.5519} = \mathbf{1.7365}$$
$$\mathbf{y = 1.7365 \, e^{0.4356x}} \quad (\text{RSS} = 3.4720)$$

#### (d) Power Curve: $y = ax^b$
Taking logarithms: $\ln(y) = \ln(a) + b\ln(x) \implies Y = A + bX$.
$$\Delta = 6(9.4099) - (6.5793)^2 = 56.4594 - 43.2872 = 13.1722$$
$$b = \frac{6(16.3203) - (6.5793)(12.4580)}{13.1722} = \frac{97.9218 - 81.9649}{13.1722} = \mathbf{1.2114}$$
$$A = \frac{12.4580 - (1.2114)(6.5793)}{6} = \mathbf{0.7480} \implies a = e^{0.7480} = \mathbf{2.1127}$$
$$\mathbf{y = 2.1127 \, x^{1.2114}} \quad (\text{RSS} = 15.4666)$$

---

### 3. Karl Pearson Correlation Coefficient & Dual Regression Lines

#### (a) Pearson Correlation Coefficient ($r$)
$$r = \frac{n\sum xy - \sum x\sum y}{\sqrt{[n\sum x^2 - (\sum x)^2][n\sum y^2 - (\sum y)^2]}} = \frac{6(283.3) - (21)(61.6)}{\sqrt{[6(91) - 441][6(907.74) - (61.6)^2]}}$$
$$r = \frac{406.2}{\sqrt{105 \times 1651.88}} = \frac{406.2}{\sqrt{173447.4}} = \frac{406.2}{416.4702} = \mathbf{0.975340}$$

#### (b) Regression Coefficients and Lines
- Slope of $y$ on $x$: $b_{yx} = \frac{406.2}{105} = \mathbf{3.8686}$
- Slope of $x$ on $y$: $b_{xy} = \frac{406.2}{1651.88} = \mathbf{0.245902}$
- Consistency: $\sqrt{b_{yx} \cdot b_{xy}} = \sqrt{3.8686 \times 0.245902} = 0.975344 \equiv r$.
- **Regression Line of $y$ on $x$:**
  $$y - 10.2667 = 3.8686(x - 3.5000) \implies \mathbf{y = 3.8686x - 3.2733}$$
- **Regression Line of $x$ on $y$:**
  $$x - 3.5000 = 0.245902(y - 10.2667) \implies \mathbf{x = 0.245902y + 0.9754}$$

#### Model Fitness Summary Table:
| Model Type | Fitted Formula | RSS | $R^2$ | Optimal Selection |
| :--- | :--- | :---: | :---: | :---: |
| **Quadratic Parabola** | $y = 0.5982x^2 - 0.3189x + 2.3100$ | **0.0509** | **0.9998** | **Selected Optimal Fit** |
| Exponential | $y = 1.7365 \, e^{0.4356x}$ | 3.4720 | 0.9874 | Good Non-linear Fit |
| Linear Regression | $y = 3.8686x - 3.2733$ | 13.4110 | 0.9513 | Baseline Trend Line |
| Power Law | $y = 2.1127 \, x^{1.2114}$ | 15.4666 | 0.9438 | Sub-optimal Fit |

---

## UNIT 2: Harmonic Fourier Analysis (Standard & Arbitrary Periods)

### 1. Full-Range Fourier Series over Standard Period ($2\pi$): $f(t) = t^2$ in $(-\pi, \pi)$
Since $f(-t) = (-t)^2 = t^2$, $f(t)$ is an **even periodic function** with period $T = 2\pi$. Hence, $b_n = 0$.

$$a_0 = \frac{1}{\pi} \int_{-\pi}^\pi t^2 dt = \frac{2}{\pi} \int_0^\pi t^2 dt = \frac{2}{\pi} \left[ \frac{t^3}{3} \right]_0^\pi = \mathbf{\frac{2\pi^2}{3}}$$

Evaluating $a_n$ via Bernoulli's generalized integration by parts:
$$a_n = \frac{2}{\pi} \int_0^\pi t^2 \cos(nt) dt = \frac{2}{\pi} \left[ t^2 \left(\frac{\sin nt}{n}\right) - (2t)\left(-\frac{\cos nt}{n^2}\right) + (2)\left(-\frac{\sin nt}{n^3}\right) \right]_0^\pi$$
$$a_n = \frac{2}{\pi} \left[ 0 + \frac{2\pi \cos(n\pi)}{n^2} - 0 \right] = \frac{4(-1)^n}{n^2}$$

#### Fourier Series Expansion:
$$\mathbf{f(t) = \frac{\pi^2}{3} + 4 \sum_{n=1}^\infty \frac{(-1)^n}{n^2} \cos(nt) = \frac{\pi^2}{3} - 4 \left[ \frac{\cos t}{1^2} - \frac{\cos 2t}{2^2} + \frac{\cos 3t}{3^2} - \frac{\cos 4t}{4^2} + \dots \right]}$$

#### Mathematical Deductions:
1. At $t = 0$:
   $$0 = \frac{\pi^2}{3} - 4 \left( 1 - \frac{1}{2^2} + \frac{1}{3^2} - \frac{1}{4^2} + \dots \right) \implies \mathbf{\sum_{n=1}^\infty \frac{(-1)^{n+1}}{n^2} = \frac{\pi^2}{12} \approx 0.82247}$$
2. At $t = \pi$:
   $$\pi^2 = \frac{\pi^2}{3} + 4 \left( \frac{1}{1^2} + \frac{1}{2^2} + \frac{1}{3^2} + \dots \right) \implies \mathbf{\sum_{n=1}^\infty \frac{1}{n^2} = \frac{\pi^2}{6} \approx 1.64493}$$

---

### 2. Full-Range Fourier Series over Arbitrary Period ($2L$): Triangular Wave $f(t) = |t|$ in $(-2, 2)$
Here half-period $L = 2$ (total period $T = 2L = 4$). Since $f(t) = |t|$ is even, $b_n = 0$.

$$a_0 = \frac{2}{L}\int_0^L t dt = \frac{2}{2}\int_0^2 t dt = \left[ \frac{t^2}{2} \right]_0^2 = \mathbf{2}$$
$$a_n = \frac{2}{2}\int_0^2 t \cos\left(\frac{n\pi t}{2}\right) dt = \left[ t \frac{2}{n\pi}\sin\left(\frac{n\pi t}{2}\right) + \frac{4}{n^2\pi^2}\cos\left(\frac{n\pi t}{2}\right) \right]_0^2$$
$$a_n = \frac{4}{n^2\pi^2}[\cos(n\pi) - 1] = \begin{cases} \mathbf{-\frac{8}{n^2\pi^2}}, & n = 1, 3, 5, \dots \text{ (odd)} \\ \mathbf{0}, & n = 2, 4, 6, \dots \text{ (even)} \end{cases}$$

#### Synthesized Fourier Series:
$$\mathbf{f(t) = 1 - \frac{8}{\pi^2} \sum_{k=1}^\infty \frac{1}{(2k-1)^2} \cos\left(\frac{(2k-1)\pi t}{2}\right) = 1 - \frac{8}{\pi^2} \left[ \cos\left(\frac{\pi t}{2}\right) + \frac{1}{9}\cos\left(\frac{3\pi t}{2}\right) + \frac{1}{25}\cos\left(\frac{5\pi t}{2}\right) + \dots \right]}$$

---

## UNIT 3: Practical Harmonic Analysis & Half-Range Expansions

### 1. Half-Range Expansions for Ramp Profile $f(t) = kt$ on $(0, L)$
- **Half-Range Sine Series (Odd Extension):**
  $$b_n = \frac{2}{L}\int_0^L kt \sin\left(\frac{n\pi t}{L}\right) dt = \mathbf{\frac{2kL}{n\pi}(-1)^{n+1}} \implies f(t) = \frac{2kL}{\pi}\sum_{n=1}^\infty \frac{(-1)^{n+1}}{n}\sin\left(\frac{n\pi t}{L}\right)$$
- **Half-Range Cosine Series (Even Extension):**
  $$a_0 = kL, \quad a_n = \begin{cases} -\frac{4kL}{n^2\pi^2}, & n \text{ odd} \\ 0, & n \text{ even} \end{cases} \implies f(t) = \frac{kL}{2} - \frac{4kL}{\pi^2}\sum_{m=1}^\infty \frac{\cos\left(\frac{(2m-1)\pi t}{L}\right)}{(2m-1)^2}$$

---

### 2. Practical Harmonic Analysis on Tabulated Field Data ($N = 12$ points, $\Delta\theta = 30^\circ$)

The table below records 12 equidistant field current samples over one full operating period:

| $\theta_i$ | $y$ | $\cos\theta$ | $\sin\theta$ | $y\cos\theta$ | $y\sin\theta$ | $\cos 2\theta$ | $\sin 2\theta$ | $y\cos 2\theta$ | $y\sin 2\theta$ | $\cos 3\theta$ | $\sin 3\theta$ | $y\cos 3\theta$ | $y\sin 3\theta$ |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| $0^\circ$ | 1.80 | 1.000 | 0.000 | 1.8000 | 0.0000 | 1.000 | 0.000 | 1.8000 | 0.0000 | 1.000 | 0.000 | 1.8000 | 0.0000 |
| $30^\circ$ | 4.30 | 0.866 | 0.500 | 3.7239 | 2.1500 | 0.500 | 0.866 | 2.1500 | 3.7239 | 0.000 | 1.000 | 0.0000 | 4.3000 |
| $60^\circ$ | 7.50 | 0.500 | 0.866 | 3.7500 | 6.4952 | -0.500 | 0.866 | -3.7500 | 6.4952 | -1.000 | 0.000 | -7.5000 | 0.0000 |
| $90^\circ$ | 9.80 | 0.000 | 1.000 | 0.0000 | 9.8000 | -1.000 | 0.000 | -9.8000 | 0.0000 | 0.000 | -1.000 | 0.0000 | -9.8000 |
| $120^\circ$ | 10.20 | -0.500 | 0.866 | -5.1000 | 8.8335 | -0.500 | -0.866 | -5.1000 | -8.8335 | 1.000 | 0.000 | 10.2000 | 0.0000 |
| $150^\circ$ | 8.40 | -0.866 | 0.500 | -7.2746 | 4.2000 | 0.500 | -0.866 | 4.2000 | -7.2746 | 0.000 | 1.000 | 0.0000 | 8.4000 |
| $180^\circ$ | 5.10 | -1.000 | 0.000 | -5.1000 | 0.0000 | 1.000 | 0.000 | 5.1000 | 0.0000 | -1.000 | 0.000 | -5.1000 | 0.0000 |
| $210^\circ$ | 2.30 | -0.866 | -0.500 | -1.9919 | -1.1500 | 0.500 | 0.866 | 1.1500 | 1.9919 | 0.000 | -1.000 | 0.0000 | -2.3000 |
| $240^\circ$ | 0.90 | -0.500 | -0.866 | -0.4500 | -0.7794 | -0.500 | 0.866 | -0.4500 | 0.7794 | 1.000 | 0.000 | 0.9000 | 0.0000 |
| $270^\circ$ | 0.40 | 0.000 | -1.000 | 0.0000 | -0.4000 | -1.000 | 0.000 | -0.4000 | 0.0000 | 0.000 | 1.000 | 0.0000 | 0.4000 |
| $300^\circ$ | 0.60 | 0.500 | -0.866 | 0.3000 | -0.5196 | -0.500 | -0.866 | -0.3000 | -0.5196 | -1.000 | 0.000 | -0.6000 | 0.0000 |
| $330^\circ$ | 1.10 | 0.866 | -0.500 | 0.9527 | -0.5500 | 0.500 | -0.866 | 0.5500 | -0.9527 | 0.000 | -1.000 | 0.0000 | -1.1000 |
| **Sum** | **52.40** | — | — | **-9.3899** | **28.0796** | — | — | **-4.8500** | **-4.5899** | — | — | **-0.3000** | **-0.1000** |

#### Extracted Harmonics:
- **DC Component:** $\frac{a_0}{2} = \frac{52.40}{12} = \mathbf{4.3667}$
- **Fundamental ($n=1$):**
  $a_1 = \frac{2}{12}(-9.3899) = \mathbf{-1.5650}$, $\quad b_1 = \frac{2}{12}(28.0796) = \mathbf{4.6799}$  
  Amplitude $c_1 = \sqrt{(-1.5650)^2 + (4.6799)^2} = \mathbf{4.9347}$ A
- **Second Harmonic ($n=2$):**
  $a_2 = \frac{2}{12}(-4.8500) = \mathbf{-0.8083}$, $\quad b_2 = \frac{2}{12}(-4.5899) = \mathbf{-0.7650}$  
  Amplitude $c_2 = \sqrt{(-0.8083)^2 + (-0.7650)^2} = \mathbf{1.1129}$ A
- **Third Harmonic ($n=3$):**
  $a_3 = \frac{2}{12}(-0.3000) = \mathbf{-0.0500}$, $\quad b_3 = \frac{2}{12}(-0.1000) = \mathbf{-0.0167}$  
  Amplitude $c_3 = \sqrt{(-0.0500)^2 + (-0.0167)^2} = \mathbf{0.0527}$ A

$$\mathbf{\text{THD} = \frac{\sqrt{c_2^2 + c_3^2}}{c_1} \times 100\% = \frac{\sqrt{1.1129^2 + 0.0527^2}}{4.9347} \times 100\% = \mathbf{22.58\%}}$$

---

## UNIT 4: Continuous Fourier Transforms & Spectral Frequency Analytics

### 1. Fourier Transform of Non-Periodic Pulse: $f(t) = e^{-a|t|}$ ($a > 0$)
$$\mathcal{F}\{f(t)\} = F(\omega) = \int_{-\infty}^\infty e^{-a|t|} e^{-i\omega t} dt = \int_{-\infty}^0 e^{(a-i\omega)t} dt + \int_0^\infty e^{-(a+i\omega)t} dt$$
$$F(\omega) = \left[ \frac{e^{(a-i\omega)t}}{a-i\omega} \right]_{-\infty}^0 + \left[ \frac{e^{-(a+i\omega)t}}{-(a+i\omega)} \right]_0^\infty = \frac{1}{a-i\omega} + \frac{1}{a+i\omega} = \mathbf{\frac{2a}{a^2 + \omega^2}}$$

### 2. Proof and Verification of Parseval's Energy Theorem
Parseval's identity: $\int_{-\infty}^\infty |f(t)|^2 dt = \frac{1}{2\pi} \int_{-\infty}^\infty |F(\omega)|^2 d\omega$.
- **LHS (Time Domain):**
  $$E_{\text{time}} = \int_{-\infty}^\infty [e^{-a|t|}]^2 dt = 2 \int_0^\infty e^{-2at} dt = 2 \left[ \frac{e^{-2at}}{-2a} \right]_0^\infty = \mathbf{\frac{1}{a}}$$
- **RHS (Frequency Domain):**
  $$E_{\text{freq}} = \frac{1}{2\pi}\int_{-\infty}^\infty \left(\frac{2a}{a^2+\omega^2}\right)^2 d\omega = \frac{4a^2}{\pi} \int_0^\infty \frac{d\omega}{(a^2+\omega^2)^2}$$
  Using substitution $\omega = a\tan\theta$, $d\omega = a\sec^2\theta d\theta$:
  $$\int_0^\infty \frac{d\omega}{(a^2+\omega^2)^2} = \frac{1}{a^3}\int_0^{\pi/2}\cos^2\theta d\theta = \frac{\pi}{4a^3}$$
  $$E_{\text{freq}} = \frac{4a^2}{\pi}\left(\frac{\pi}{4a^3}\right) = \mathbf{\frac{1}{a}} \equiv E_{\text{time}}$$

### 3. Fourier Sine & Cosine Transforms of Causal Transient $f(t) = e^{-at}$ ($t > 0$)
- **Fourier Sine Transform:**
  $$\mathcal{F}_s\{e^{-at}\} = \int_0^\infty e^{-at}\sin(\omega t) dt = \mathbf{\frac{\omega}{a^2 + \omega^2}}$$
- **Fourier Cosine Transform:**
  $$\mathcal{F}_c\{e^{-at}\} = \int_0^\infty e^{-at}\cos(\omega t) dt = \mathbf{\frac{a}{a^2 + \omega^2}}$$

---

## UNIT 5: Probabilistic Reliability Analysis & Risk Modeling

1. **Binomial Hardware Redundancy ($n = 8$ sensor nodes, failure probability $p = 0.05$):**
   - $P(X=0) = (0.95)^8 = \mathbf{0.663420}$
   - $P(X=1) = 8(0.05)(0.95)^7 = \mathbf{0.279335}$
   - $P(X=2) = 28(0.05)^2(0.95)^6 = \mathbf{0.051456}$
   - Cluster Survival (at most 1 node failed): $P(X \le 1) = 0.663420 + 0.279335 = \mathbf{0.942755} \quad (94.28\%)$
   - Catastrophic Redundancy Failure ($>2$ failures): $P(X > 2) = \mathbf{0.005788} \quad (0.58\%)$

2. **Poisson Electrical Fault Rate ($\lambda = 2.4$ spikes per 100 operating hours):**
   - $P(X=0) = e^{-2.4} = \mathbf{0.090718}$
   - $P(X=1) = \mathbf{0.217723}, \quad P(X=2) = \mathbf{0.261268}, \quad P(X=3) = \mathbf{0.209014}$
   - Safe Window ($P(X \le 2)$): $\mathbf{0.569709} \quad (56.97\%)$

3. **Exponential Actuator Wear-out ($\lambda = 0.0005\text{ hr}^{-1}$, MTBF $= 2000\text{ hours}$):**
   - $R(500\text{ h}) = e^{-0.25} = \mathbf{0.778801} \quad (77.88\%)$
   - $R(1000\text{ h}) = e^{-0.50} = \mathbf{0.606531} \quad (60.65\%)$
   - $R(2000\text{ h}) = e^{-1.00} = \mathbf{0.367879} \quad (36.79\%)$

4. **Normal Measurement Noise Distribution ($X \sim \mathcal{N}(5.00\text{ V}, 0.08^2)$):**
   - Specification Band: $[4.80\text{ V}, 5.20\text{ V}] \implies Z = \pm 2.50$
   - Conforming Probability: $P(4.80 \le X \le 5.20) = \Phi(2.50) - \Phi(-2.50) = \mathbf{0.987581} \quad (98.76\%)$
   - Out-of-Tolerance Failure Rate: $\mathbf{0.012419} \implies \mathbf{12,419.4\text{ PPM}}$

---

## UNIT 6: Stochastic Modeling, Joint Distributions & Markov State Transitions

### 1. Dual Discrete Joint Probability Distribution
Processor Load State $X \in \{1: \text{Low}, 2: \text{Med}, 3: \text{High}\}$ vs. Thermal State $Y \in \{1: \text{Low}, 2: \text{Med}, 3: \text{High}\}$:

| $X \backslash Y$ | $Y = 1$ | $Y = 2$ | $Y = 3$ | Marginal $P_X(x_i)$ |
| :---: | :---: | :---: | :---: | :---: |
| **$X = 1$** | 0.18 | 0.08 | 0.04 | **0.30** |
| **$X = 2$** | 0.10 | 0.22 | 0.08 | **0.40** |
| **$X = 3$** | 0.02 | 0.10 | 0.18 | **0.30** |
| **Marginal $P_Y(y_j)$** | **0.30** | **0.40** | **0.30** | **$\sum\sum p_{ij} = 1.00$** |

- Expectations: $E[X] = 2.0000, \quad E[Y] = 2.0000$
- Variances: $\text{Var}(X) = 0.6000, \quad \text{Var}(Y) = 0.6000 \implies \sigma_X = \sigma_Y = 0.774597$
- Joint Expectation: $E[XY] = \sum\sum x_i y_j p_{ij} = \mathbf{4.3000}$
- Covariance: $\text{Cov}(X, Y) = 4.3000 - (2.0000)^2 = \mathbf{0.3000}$
- Correlation Coefficient: $\mathbf{\rho_{XY} = \frac{0.3000}{0.6000} = +0.500000}$
- Independence Test: $P(1, 1) = 0.18 \ne P_X(1)P_Y(1) = 0.09 \implies$ Dependent variables.

---

### 2. Stochastic Markov Chain Health State Transitions

#### 1-Step Stochastic Transition Probability Matrix:
$$P = \begin{pmatrix} 0.85 & 0.12 & 0.03 \\ 0.20 & 0.70 & 0.10 \\ 0.40 & 0.30 & 0.30 \end{pmatrix}$$

#### Multi-Step Transition Matrices:
$$P^2 = \begin{pmatrix} 0.7585 & 0.1950 & 0.0465 \\ 0.3500 & 0.5440 & 0.1060 \\ 0.5200 & 0.3480 & 0.1320 \end{pmatrix}, \qquad P^3 = \begin{pmatrix} 0.7023 & 0.2415 & 0.0562 \\ 0.4487 & 0.4546 & 0.0967 \\ 0.5644 & 0.3456 & 0.0900 \end{pmatrix}$$

#### Steady-State Probability Vector ($\mathbf{\pi}$):
Solving $\mathbf{\pi} P = \mathbf{\pi}$ and $\pi_1 + \pi_2 + \pi_3 = 1$:
$$\mathbf{\pi_1 = \frac{30}{49} \approx 0.612245 \quad (61.22\%) \quad [\text{State 1: Normal}]}$$
$$\mathbf{\pi_2 = \frac{31}{98} \approx 0.316327 \quad (31.63\%) \quad [\text{State 2: Degraded}]}$$
$$\mathbf{\pi_3 = \frac{1}{14} \approx 0.071429 \quad (7.14\%) \quad [\text{State 3: Outage}]}$$

- **System Operational Availability:** $A = \pi_1 + \pi_2 = 61.22\% + 31.63\% = \mathbf{92.86\%}$
- **Mean Recurrence Times:** $\mu_{11} = 1.63\text{ steps}$, $\mu_{22} = 3.16\text{ steps}$, $\mu_{33} = 14.00\text{ steps}$.

---

## 14-Week PBL Execution Timeline & Team Accountability

| Week Range | Project Phase | Activities Completed | Validation Milestone |
| :---: | :---: | :--- | :--- |
| **Weeks 1–2** | Initiation | Team formation, PBL scope alignment, curriculum mapping | Problem Statement Formulated |
| **Weeks 3–4** | Proposal | Proposal defense, empirical sensor dataset identification | Proposal Approval |
| **Weeks 5–6** | Mathematical Modeling | Formulation of Least Squares normal equations & Fourier series | Normal Equations Verified |
| **Weeks 7–10** | Algorithmic Development | Practical harmonic numerical quadrature, transform derivations | Integral Proofs & FFT Checks |
| **Weeks 11–12** | Stochastic Integration | Joint PMF calculations, Markov state transition matrices | Steady-State Convergence |
| **Week 13** | Software Verification | Simulation engine implementation, interactive dashboard | GUI Demonstration Ready |
| **Week 14** | Demonstration | Final model defense, viva-voce examination, final report | 40/40 Evaluation Submission |

---

## Technical Viva-Voce Questions & Comprehensive Answers

1. **Why is the second-degree parabola chosen over the linear model in Unit 1?**  
   *Answer:* The empirical transducer data demonstrates progressive acceleration in current per unit voltage increase. The quadratic term $ax^2$ captures this physical nonlinearity, resulting in an exceptionally low RSS of $0.0509$ and $R^2 = 0.9998$, compared to the linear model's RSS of $13.4110$.
2. **What is the physical meaning of Dirichlet's conditions in Fourier analysis?**  
   *Answer:* Dirichlet conditions guarantee that a periodic waveform has a convergent Fourier series representation: the signal must be single-valued, bounded (finite absolute integral over a period), and possess a finite number of local extrema and finite discontinuities in any single period.
3. **How does Practical Harmonic Analysis overcome the limitations of continuous Fourier transforms?**  
   *Answer:* In real operating systems, continuous mathematical functions are rarely known analytically. Practical Harmonic Analysis applies numerical quadrature over $N$ discrete equidistant field measurements ($N=12$), directly computing Fourier coefficients ($a_n, b_n$) without continuous symbolic integration.
4. **How does Parseval's theorem confirm mathematical validity in Unit 4?**  
   *Answer:* Parseval's theorem proves energy invariance: the total time-domain energy integral $\int_{-\infty}^\infty |f(t)|^2 dt = 1/a$ exactly equals the continuous frequency-domain integral $\frac{1}{2\pi}\int_{-\infty}^\infty |F(\omega)|^2 d\omega = 1/a$.
5. **Why is the Markov chain steady-state probability independent of initial state?**  
   *Answer:* Because the transition probability matrix $P$ is regular (all entries in $P^2$ are strictly positive: $p_{ij}^{(2)} > 0$). Regular Markov chains are ergodic and possess a unique stationary distribution vector $\mathbf{\pi}$ that satisfies $\lim_{k\to\infty} P^k = \mathbf{1}\mathbf{\pi}$.

---

### Course Faculty Endorsements

**Mrs. P R Nagashri**  
Course Coordinator, Dept. of ECE, GM University  

**Dr. Praveen J**  
Head of the Department, Dept. of ECE & Director, School of Engineering, GM University  

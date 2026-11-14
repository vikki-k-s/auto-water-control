# 🌊 Automatic Water-Level Controller Using Op-Amp and 555 Timer
### Linear Integrated Circuits with Practice (Course Code: UE25EC3502)
**GM University | Faculty of Engineering & Technology | Department of Electronics & Communication Engineering**  
*Semester: 3rd | Total Marks: 40 | PBL Timeline: 14 Weeks | Academic Year: 2026–2027*

---

[![Linear Integrated Circuits](https://img.shields.io/badge/Course-UE25EC3502%20(LIC)-blue.svg)](#-syllabus-coverage-matrix-units-1-to-5)
[![Op-Amp LM358](https://img.shields.io/badge/Op--Amp-LM358%20Dual%20Comparator-indigo.svg)](#-detailed-schematic--circuit-operation)
[![NE555 Timer](https://img.shields.io/badge/Timer-NE555%20Monostable%20%26%20Latch-purple.svg)](#-detailed-schematic--circuit-operation)
[![Voltage Regulator](https://img.shields.io/badge/Regulator-LM7805%20%2B5V%20DC-emerald.svg)](#-detailed-schematic--circuit-operation)
[![Interactive SCADA](https://img.shields.io/badge/Web%20Simulator-Localhost%20%2F%20Direct%20Browser-cyan.svg)](#-interactive-web-scada-cockpit--live-simulation)
[![Report](https://img.shields.io/badge/PBL%20Report-12%20Pages%20Verified%20(Max)-rose.svg)](#-deliverables-checklist)

---

## 📖 Executive Summary

Water storage management in residential, commercial, and agricultural installations requires dependable autonomous pump regulation to prevent dry-running, overflow wastage of treated water, and premature mechanical wear from rapid relay cycling. 

This project delivers a complete, solid-state, hardware-implemented **Automatic Water-Level Controller** designed strictly using Linear Integrated Circuits (**LM358 Dual Op-Amp**, **NE555 Precision Timer**, and **LM7805 Voltage Regulator**) without relying on software-dependent microcontrollers.

### Key Operational Characteristics:
- **Autonomous Dual-Level Regulation:** Automatically energizes the 12V submersible water pump when the water level drops below the preset minimum level (20%), and terminates pumping when water reaches the preset maximum level (85%).
- **Schmitt Trigger Noise Hysteresis:** An LM358 inverting Schmitt trigger introduces a calculated hysteresis window of $\Delta V_H = 78.1\ \text{mV}$ ($V_{LTP} = 1.628\ \text{V}$, $V_{UTP} = 1.706\ \text{V}$) to eliminate relay contact chatter caused by water ripples.
- **NE555 Monostable Anti-Slosh Blanking:** Generates an active $5.17\text{-second}$ time delay ($T = 1.1 \cdot R_A \cdot C_1$) that masks turbulent wave splashing during pump starts.
- **NE555 Bistable RS Memory Latch:** Memorizes operating states between 20% and 85%, ensuring the pump fills the tank continuously and remains idle while draining.
- **Galvanic Electrolysis Mitigation:** Microampere current limiting ($I_P < 50\ \mu\text{A}$) through $100\ \text{k}\Omega$ pull-down resistors coupled with SS304 stainless-steel electrodes prevents electrochemical electrode corrosion.
- **Transistor Relay Driver & Flyback Clamp:** Saturated BC547 NPN driver ($I_B / I_{B(sat)} = 10.7\times$) with an antiparallel 1N4007 power diode safely shunting relay coil inductive collapse voltage spikes.

---

## 🕹️ Interactive Web SCADA Cockpit & Live Simulation

An interactive HTML5/Tailwind SCADA control cockpit with Web Audio synthesized pump humming, mechanical relay click sounds, dynamic water physics, and real-time physical water tank animation is included in [`gui/index.html`](gui/index.html).

### Quick Launch:
- **Option 1 (One-Click Windows Launcher):** Double-click [`run_gui.bat`](run_gui.bat).
- **Option 2 (Direct Browser):** Double-click or open [`gui/index.html`](gui/index.html) in Google Chrome, Microsoft Edge, or Firefox.
- **Option 3 (Localhost HTTP Server via WSL / Python):**
  ```bash
  wsl python3 -m http.server 3000 --directory "/mnt/d/Projects/PBL Project/gui"
  # Open in your browser: http://localhost:3000
  ```

### Cockpit Features:
1. **Dynamic Overhead & Sump Tanks:** Real-time water volume (liters and percentage) with animated sinusoidal surface waves.
2. **Conductive Sensor Probes:** Visual glow on Common (+5V), Low Probe (20%), and High Probe (85%) as water touches each tip.
3. **Dual LM358 Telemetry Meters:** Live digital voltmeters and Schmitt trigger hysteresis loop showing dynamic operating point movement between $V_{LTP}$ and $V_{UTP}$.
4. **NE555 Monostable Debounce Progress Bar:** Real-time countdown timer ($5.17\text{ s}$) demonstrating the wave-blanking interval.
5. **Driver & Relay Telemetry:** Displays BC547 base drive ($I_B = 2.90\text{ mA}$), collector current ($I_C = 30\text{ mA}$), and relay contact states.
6. **Web Audio Sound Effects:** Authentic submersible pump vibration hum, mechanical relay click-clack sounds, and audible high-water overflow buzzer beeps.
7. **Interactive Controls:** Consumer drain valve slider (0 to 8 L/s), Wave Slosh injection button, manual pump override switch, and live strip-chart oscilloscope!

---

## 🏛️ Syllabus Coverage Matrix (Units 1 to 5)

| Unit | Syllabus Module | Circuit Hardware Module | Mathematical & Engineering Highlights |
|:---:|:---|:---|:---|
| **Unit 1** | **Op-Amp Fundamentals & Sensor Interfacing** | SS304 Probes + [LM358](docs/water_level_circuit_diagram.svg) Ground-Sense Input | Utilizes LM358's high input impedance ($> 2\ \text{M}\Omega$) and PNP differential input stage to sense voltages down to 0.0V without loading error. |
| **Unit 2** | **Op-Amp Comparators** | Dual LM358 Inverting Detectors | Open-loop comparison against a 3-resistor precision potential divider ($V_{ref\_low} = 1.67\ \text{V}$, $V_{ref\_high} = 3.33\ \text{V}$). |
| **Unit 3** | **Schmitt Trigger & Hysteresis** | LM358 Positive Feedback Loop ($R_f = 470\ \text{k}\Omega$) | Positive feedback creating $V_{UTP} = 1.706\ \text{V}$ and $V_{LTP} = 1.628\ \text{V}$ ($\Delta V_H = 78.1\ \text{mV}$) to eliminate boundary chatter. |
| **Unit 5** | **555 Timer Monostable Operation** | NE555 Timing Network ($R_A = 100\ \text{k}\Omega$, $C_1 = 47\ \mu\text{F}$) | Monostable pulse duration $T = 1.1 \cdot R_A \cdot C_1 = 5.17\ \text{s}$ masking initial hydraulic turbulence upon pump activation. |
| **Unit 5** | **Voltage Regulation Techniques** | LM7805 Linear Regulator + Bypass Caps | Provides stable $+5.00\ \text{V} \pm 2\%$ rail; $0.33\ \mu\text{F}$ input and $0.1\ \mu\text{F}$ output caps provide $> 62\ \text{dB}$ ripple rejection. |
| **Output** | **Driver Stage & Inductive Snubber** | BC547B NPN Switch + 1N4007 Diode + 12V Relay | Deep saturation base drive ($I_B = 2.90\ \text{mA}$) and antiparallel diode clamping inductive kickback ($v = -L \frac{di}{dt}$) to $12.7\ \text{V}$. |

---

## 📐 Detailed Schematic & Circuit Architecture

```
                                  +12V UNREGULATED DC SUPPLY
                                              |
                     +------------------------+------------------------+
                     |                                                 |
            +--------v--------+                               +--------v--------+
            |  LM7805 (+5V)   |                               | 12V SPDT RELAY  |
            |  Cin = 0.33 uF  |                               | Coil = 400 Ohm  |
            |  Cout = 0.1 uF  |                               | 1N4007 Clamp    |
            +--------+--------+                               +--------^--------+
                     |                                                 |
         +-----------+-----------+                                     | (Collector)
         |                       |                            +--------+--------+
+--------v--------+     +--------v--------+                   | BC547 NPN DRIVE |
| WATER PROBES    |     | VOLTAGE DIVIDER |                   | Rb = 1 kOhm     |
| COM: +5V        |     | R1 = R2 = R3    |                   +--------^--------+
| LOW: 100k Pull  |     | V_ref_H = 3.33V |                            |
| HIGH: 100k Pull |     | V_ref_L = 1.67V |                            | (Pin 3 Out)
+--------+--------+     +--------+--------+                   +--------+--------+
         |                       |                            | IC NE555 TIMER  |
         +-----------+-----------+                            | Monostable &    |
                     |                                        | Bistable Latch  |
            +--------v--------+                               | T = 1.1 * Ra * C|
            | LM358 OP-AMP    |                               +--------^--------+
            | Dual Comparator |                                        |
            | Schmitt Trigger |----------------------------------------+
            | Delta_V = 78 mV | (Trig Pin 2 & Reset Pin 4)
            +-----------------+
```

---

## ⚡ Mathematical Formulations & Circuit Derivations

### 1. Schmitt Trigger Hysteresis ($V_{UTP}$ & $V_{LTP}$):
Applying nodal superposition at the non-inverting node $V^+$:
$$V^+ = V_{in} \cdot \left(\frac{R_f}{R_{in} + R_f}\right) + V_{out} \cdot \left(\frac{R_{in}}{R_{in} + R_f}\right)$$

Switching occurs when $V^+ = V_{ref\_low} = 1.667\ \text{V}$:
$$V_{UTP} = V_{ref\_low} \cdot \left(1 + \frac{R_{in}}{R_f}\right) - V_{OL} \cdot \left(\frac{R_{in}}{R_f}\right) \approx 1.667 \cdot \left(1 + \frac{10\text{k}}{470\text{k}}\right) = 1.706\ \text{V}$$
$$V_{LTP} = V_{ref\_low} \cdot \left(1 + \frac{R_{in}}{R_f}\right) - V_{OH} \cdot \left(\frac{R_{in}}{R_f}\right) \approx 1.706 - 3.80 \cdot \left(\frac{10\text{k}}{470\text{k}}\right) = 1.628\ \text{V}$$
$$\Delta V_H = V_{UTP} - V_{LTP} = \frac{R_{in}}{R_{in} + R_f} \cdot (V_{OH} - V_{OL}) = 78.1\ \text{mV}$$

### 2. NE555 Monostable Debounce Duration:
The instantaneous capacitor charging voltage is:
$$v_C(t) = V_{CC} \left(1 - e^{-t / (R_A C_1)}\right)$$
Equating to the internal threshold of $\frac{2}{3} V_{CC}$:
$$\frac{2}{3} V_{CC} = V_{CC} \left(1 - e^{-T / (R_A C_1)}\right) \implies e^{-T / (R_A C_1)} = \frac{1}{3}$$
$$T = \ln(3) \cdot R_A \cdot C_1 \approx 1.1 \cdot (100 \times 10^3\ \Omega) \cdot (47 \times 10^{-6}\ \text{F}) = 5.17\ \text{seconds}$$

### 3. Transistor Saturated Base Drive:
$$I_C = \frac{V_{CC} - V_{CE(sat)}}{R_{coil}} = \frac{12.0\text{ V} - 0.1\text{ V}}{400\ \Omega} = 29.75\ \text{mA}$$
$$I_B = \frac{V_{out(555)} - V_{BE(sat)}}{R_B} = \frac{3.60\text{ V} - 0.70\text{ V}}{1000\ \Omega} = 2.90\ \text{mA}$$
$$\text{Overdrive Ratio} = \frac{I_B}{I_C / h_{FE(min)}} = \frac{2.90\text{ mA}}{29.75\text{ mA} / 110} = 10.7\times \quad (\text{Deep Saturation Guaranteed})$$

---

## 🛠️ Complete Bill of Materials (BOM)

| Component Name | Part Number / Specs | Qty | Approx. Price (INR ₹) |
|:---|:---|:---:|:---:|
| **Dual Operational Amplifier** | LM358N (DIP-8) | 1 | ₹18 |
| **Precision Timer IC** | NE555P (DIP-8) | 1 | ₹15 |
| **Voltage Regulator IC** | LM7805 (+5V, 1A TO-220) | 1 | ₹15 |
| **Electromechanical Relay** | Songle SRD-12VDC-SL-C (10A SPDT) | 1 | ₹35 |
| **Driver Transistor** | BC547B NPN (TO-92) | 2 | ₹8 |
| **Flyback Diode** | 1N4007 (1000V, 1A DO-41) | 2 | ₹4 |
| **DC Submersible Pump** | 12V DC Mini (3W, 240 L/H) | 1 | ₹160 |
| **Sensing Electrodes** | SS304 Stainless Steel Screws | 3 | ₹15 |
| **Capacitors & Resistors** | 47µF, 10µF, 0.33µF, 0.1µF, 10k, 100k, 470k, 1k | 20 | ₹30 |
| **Status LEDs & Piezo Buzzer** | Red, Green, Blue, Amber + 5V Buzzer | 5 | ₹28 |
| **Prototyping Kit** | MB-102 Breadboard, Jumpers & 12V 1A Adapter | 1 Set | ₹440 |
| **TOTAL** | — | — | **~₹770 – ₹850** |

---

## 📁 Repository Directory Structure

```
.
├── docs/                                          # Project Documentation & Publication Files
│   ├── PBL_Project_Report.md                      # Complete 12-Page University PBL Report (Markdown)
│   ├── PBL_Report_Document.html                   # Print-Ready HTML Document (WeasyPrint Target)
│   ├── Wiring_Schematic_Guide.html                # Source HTML for 4-Page Hardware Wiring Guide
│   ├── Hardware_Implementation_Guide.md           # BOM, Sourcing Prices, Assembly & Testing Protocol
│   ├── Viva_Voce_QnA.md                           # 12 Deep Technical Viva Questions & Answers
│   ├── water_level_circuit_diagram.svg            # Master Detailed Hardware Schematic
│   ├── system_block_diagram.svg                   # Functional System Architecture Diagram
│   ├── schmitt_trigger_hysteresis.svg             # Schmitt Trigger Transfer Characteristic Curve
│   └── timing_slosh_waveform.svg                  # Monostable Anti-Slosh Waveform Analysis
│
├── sim/                                           # Analytical Circuit Simulation & Modeling
│   └── water_level_sim.py                         # SPICE-equivalent Python simulation script
│
├── gui/                                           # Interactive Web SCADA Dashboard
│   └── index.html                                 # Full Interactive HTML5/Audio Simulator
│
├── run_gui.bat                                    # 1-Click Windows Launcher for SCADA Simulator
├── run_simulation.bat                             # 1-Click Windows Launcher for Python Simulation
├── .gitignore                                     # Git Ignore Rules (Strictly blocks all *.pdf)
└── README.md                                      # Master Project Documentation
```

---

## 🚀 How to Run the Simulation & Compile Documentation

### 1. Run the Python Analytical Simulation:
```bash
# Windows 1-Click:
run_simulation.bat

# Or via WSL:
wsl python3 sim/water_level_sim.py
```

### 2. Launch the Interactive SCADA Cockpit:
```bash
# Windows 1-Click:
run_gui.bat

# Or directly in any browser:
# Open gui/index.html
```

### 3. Generate Submission PDFs Locally (Optional):
```bash
# Generate 12-Page Official PBL Report:
weasyprint docs/PBL_Report_Document.html docs/Water_Level_Controller_PBL_Report.pdf

# Generate 4-Page Lab Wiring Guide:
weasyprint docs/Wiring_Schematic_Guide.html docs/Water_Level_Controller_Wiring_Guide.pdf
```

---

## 👥 Student Team & Project Governance

| Student Name | USN | Project Role | Core Contribution Area | % Share |
|:---|:---:|:---|:---|:---:|
| **Vikas K S (Lead)** | `U26E02EC521` | Lead System Architect | Architecture, LM7805 Power Supply & Top Integration | 25% |
| **Nandan S L** | `U26E02EC518` | Analog Conditioning Lead | SS304 Sensors, LM358 Comparators & Schmitt Trigger | 25% |
| **Meghana P** | `U25E02EC070` | Timing & Control Lead | NE555 Monostable Anti-Slosh Delay, Latch & Indicators | 25% |
| **Keerthana R F** | `U25E02EC053` | Actuator & Verification Lead | BC547 Relay Driver, 1N4007 Snubber, Simulation & Report | 25% |

**Faculty Evaluators:**
- **Mr. Samapth Kumar B** — Course Coordinator, ECE Department
- **Dr. Praveen J** — Head of the Department, ECE
- **Dr. Praveen J** — Director, School of Engineering (SE), GM University

# 🖥️ NI Multisim Circuit Implementation & Complete Wiring Manual
### Automatic Water-Level Controller Using Op-Amp (LM358) and 555 Timer
**Course Code:** UE25EC3502 (Linear Integrated Circuits with Practice)  
**Institution:** GM University, Davanagere | **Department:** Electronics & Communication Engineering

---

## 1. 📐 Multisim Schematic Overview & Architecture

In **National Instruments Multisim** (versions 12.0, 13.0, 14.0, 14.1, 14.2, 14.3), this circuit is simulated interactively to model real-time hydraulic tank cycles. The schematic comprises six coordinated stages:

1. **Power Supply Stage:** +12V DC input (`V1`), regulated to **+5.00V DC** via **LM7805CT** (`U3`), decoupled by \(C_1\) (\(0.33\ \mu\text{F}\)) and \(C_2\) (\(0.1\ \mu\text{F}\)).
2. **Reference Voltage Divider:** Precision 3-resistor potential divider (\(R_1, R_2, R_3 = 10\ \text{k}\Omega\)) generating reference thresholds:
   - \(V_{ref2} = \frac{2}{3} V_{CC} = 3.33\ \text{V}\) (High level cutoff threshold)
   - \(V_{ref1} = \frac{1}{3} V_{CC} = 1.67\ \text{V}\) (Low level start threshold)
3. **Water Sensing Probe Modeling:** Two interactive switches (`S_LOW` [Key: `L`] and `S_HIGH` [Key: `H`]) in series with tap water conduction equivalent resistors (\(R_{w1} = R_{w2} = 2.5\ \text{k}\Omega\)) and pull-down resistors (\(R_{pd1} = R_{pd2} = 100\ \text{k}\Omega\)).
4. **Dual Op-Amp Comparators (LM358N):**
   - **`U1:A` (Low Level Schmitt Trigger):** Non-inverting input receives sensed voltage via \(R_{in} = 10\ \text{k}\Omega\); positive feedback resistor \(R_f = 470\ \text{k}\Omega\) provides \(\Delta V_H = 78.1\ \text{mV}\) hysteresis to prevent chatter.
   - **`U1:B` (High Level Comparator):** Compares high probe voltage directly against \(V_{ref2} = 3.33\ \text{V}\).
5. **NE555 Timer (Monostable Debounce & Bistable Memory Latch):**
   - Low trigger activates Pin 2 (`TRIG`).
   - High cut-off triggers Pin 4 (`RESET`) and Pin 6 (`THRES`).
   - Monostable timing network: \(R_A = 100\ \text{k}\Omega\), \(C_6 = 47\ \mu\text{F}\) provides \(T = 1.1 R_A C = 5.17\ \text{seconds}\) anti-slosh blanking delay.
6. **Actuator & Driver Stage:** Saturated **BC547B** NPN driver transistor (`Q1`), **1N4007** flyback snubber diode (`D1`), **12V SPDT Relay** (`K1`), and **12V DC Pump Motor** (`M1`).

---

## 2. 🗄️ Component Placement Guide (Multisim Master Database Paths)

To place components on the Multisim canvas, press `Ctrl + W` or click **Place > Component**:

| Designator | Component Name | Multisim Database Group | Family | Component Name / Model | Parameters / Values |
|:---:|:---|:---|:---|:---|:---|
| **V1** | DC Power Source | `Sources` | `POWER_SOURCES` | `DC_POWER` | Voltage = **12.0 V** |
| **GND** | Circuit Ground | `Sources` | `POWER_SOURCES` | `GROUND` | 0 V Reference (Mandatory) |
| **U3** | Voltage Regulator | `Power` | `VOLTAGE_REGULATOR` | `LM7805CT` (or `LM7805`) | Output: +5.0 V DC |
| **U1:A** | Op-Amp Section A | `Analog` | `OPAMP` | `LM358N` (Select Section A) | Dual Ground-Sensing Op-Amp |
| **U1:B** | Op-Amp Section B | `Analog` | `OPAMP` | `LM358N` (Select Section B) | Shared Power (Pins 8 & 4) |
| **U2** | Timer IC | `Mixed` (or `Analog`) | `TIMER` | `LM555CM` or `NE555` | 8-Pin Precision Timer |
| **Q1** | Driver Transistor | `Transistors` | `BJT_NPN` | `BC547B` (or `2N2222A`) | \(\beta \ge 200\), Saturated Switch |
| **D1** | Flyback Diode | `Diodes` | `DIODE` | `1N4007` (or `1N4004`) | \(V_{RRM} = 1000\text{V}, I_F = 1\text{A}\) |
| **K1** | SPDT Relay | `Basic` | `RELAY` | `RELAY_SPDT` | Coil: **12V**, Coil Res: **400 Ω** |
| **M1** | DC Pump Motor | `Electro-Mechanical` | `MOTORS` | `DC_MOTOR` (or `12V_10W` LAMP) | 12V DC, 3W Load |
| **S_LOW** | Low Probe Switch | `Basic` | `SWITCH` | `SPDT` (or `SPST`) | Key Shortcut = **[L]** |
| **S_HIGH**| High Probe Switch | `Basic` | `SWITCH` | `SPDT` (or `SPST`) | Key Shortcut = **[H]** |
| **R1, R2, R3**| Reference Divider | `Basic` | `RESISTOR` | `10k` | 10 kΩ, 1% Metal Film |
| **Rw1, Rw2**| Water Resistance | `Basic` | `RESISTOR` | `2.5k` | 2.5 kΩ (Tap water equivalent) |
| **Rpd1, Rpd2**| Pull-Down Resistors | `Basic` | `RESISTOR` | `100k` | 100 kΩ, 5% Carbon Film |
| **Rin** | Schmitt Input | `Basic` | `RESISTOR` | `10k` | 10 kΩ |
| **Rf** | Schmitt Feedback | `Basic` | `RESISTOR` | `470k` | 470 kΩ (Hysteresis = 78 mV) |
| **RA** | 555 Timing Resistor | `Basic` | `RESISTOR` | `100k` | 100 kΩ |
| **RB** | Transistor Base Drive| `Basic` | `RESISTOR` | `1k` | 1 kΩ (Forces \(I_B = 2.9\text{ mA}\)) |
| **R_LED** | Current Limiter | `Basic` | `RESISTOR` | `330` | 330 Ω Ballast Resistor |
| **C1** | 7805 Input Filter | `Basic` | `CAPACITOR` | `0.33uF` | 0.33 µF Ceramic Disc |
| **C2, C3, C4**| Bypass & Noise Filter| `Basic` | `CAPACITOR` | `0.1uF` | 0.1 µF Ceramic Disc |
| **C5** | 555 Control Bypass | `Basic` | `CAPACITOR` | `0.01uF` | 0.01 µF Ceramic Disc |
| **C_time** | Monostable Timing | `Basic` | `CAP_ELECTROLIT` | `47uF` | 47 µF / 25V Electrolytic |
| **D2, D3** | Status Indicators | `Indicators` | `LED` | `LED_BLUE` (Pump), `LED_GREEN` | 5mm Diffused LEDs |
| **BZ1** | Audible Alarm | `Indicators` | `BUZZER` | `BUZZER` | 5V Piezo Sounder |
| **XSC1** | Virtual Oscilloscope | *Right Toolbar* | `Instruments` | `4-Channel Oscilloscope` | Real-time waveform analyzer |
| **XMM1** | Virtual Multimeter | *Right Toolbar* | `Instruments` | `Multimeter` | DC Voltage & Current test |

---

## 3. 🔌 Complete Netlist & Wire-by-Wire Connection Table

Connect the components precisely as specified in the table below:

### A. Power Supply & Reference Divider Distribution:
1. Connect `V1 (+)` terminal to `+12V_BUS`.
2. Connect `V1 (-)` terminal to `GND (0V)`.
3. Connect `U3 (LM7805CT)` **Pin 1 (INPUT)** to `+12V_BUS`.
4. Connect `U3 (LM7805CT)` **Pin 2 (GND)** to `GND (0V)`.
5. Connect `U3 (LM7805CT)` **Pin 3 (OUTPUT)** to `+5V_VCC_BUS`.
6. Place `C1` (\(0.33\ \mu\text{F}\)) across `U3 Pin 1` and `GND`.
7. Place `C2` (\(0.1\ \mu\text{F}\)) across `U3 Pin 3` and `GND`.
8. Connect `R1` (10 kΩ) between `+5V_VCC_BUS` and **Node A** (\(V_{ref2}\)).
9. Connect `R2` (10 kΩ) between **Node A** (\(V_{ref2}\)) and **Node B** (\(V_{ref1}\)).
10. Connect `R3` (10 kΩ) between **Node B** (\(V_{ref1}\)) and `GND`.
    - *Multimeter Verification:* Voltage at Node A = **3.33 V**; Voltage at Node B = **1.67 V**.

### B. Water Sensing Probe Simulator Stage:
1. Connect one contact of switch `S_LOW` to `+5V_VCC_BUS`.
2. Connect the other contact of `S_LOW` to resistor `Rw1` (2.5 kΩ).
3. Connect the other side of `Rw1` to **Node C** (Low Probe Input).
4. Connect `Rpd1` (100 kΩ) between **Node C** and `GND`.
5. Connect `C3` (0.1 µF) between **Node C** and `GND`.
6. Connect one contact of switch `S_HIGH` to `+5V_VCC_BUS`.
7. Connect the other contact of `S_HIGH` to resistor `Rw2` (2.5 kΩ).
8. Connect the other side of `Rw2` to **Node D** (High Probe Input).
9. Connect `Rpd2` (100 kΩ) between **Node D** and `GND`.
10. Connect `C4` (0.1 µF) between **Node D** and `GND`.

### C. LM358 Dual Op-Amp Comparators Stage:
1. Connect `LM358` **Pin 8 (\(V_{CC}\))** to `+5V_VCC_BUS` and **Pin 4 (GND)** to `GND`. *(Note: In some Multisim models, power pins are hidden; verify they link to VCC and GND)*.
2. **U1:A (Low Level Schmitt Trigger Comparator):**
   - Connect **Pin 2 (Inverting Input 1IN-)** to **Node B** (\(V_{ref1} = 1.67\ \text{V}\)).
   - Connect **Node C** through resistor `Rin` (10 kΩ) to **Pin 3 (Non-Inverting Input 1IN+)**.
   - Connect feedback resistor `Rf` (470 kΩ) between **Pin 1 (Output 1OUT)** and **Pin 3 (1IN+)**.
3. **U1:B (High Level Comparator):**
   - Connect **Pin 6 (Inverting Input 2IN-)** to **Node A** (\(V_{ref2} = 3.33\ \text{V}\)).
   - Connect **Pin 5 (Non-Inverting Input 2IN+)** directly to **Node D** (High Probe Input).
   - **Pin 7 (Output 2OUT)** provides the high-level tank full logic cutoff signal.

### D. NE555 Precision Timer Stage:
1. Connect `U2 (NE555)` **Pin 8 (\(V_{CC}\))** to `+5V_VCC_BUS`.
2. Connect `U2 (NE555)` **Pin 1 (GND)** to `GND (0V)`.
3. Connect `U2` **Pin 5 (CONTROL)** through capacitor `C5` (\(0.01\ \mu\text{F}\)) to `GND`.
4. Connect `LM358` **Pin 1 (1OUT)** to `NE555` **Pin 2 (TRIGGER)**.
5. Connect `LM358` **Pin 7 (2OUT)** to `NE555` **Pin 4 (RESET)**.
6. Connect timing resistor `RA` (100 kΩ) between `+5V_VCC_BUS` and `NE555` **Pin 7 (DISCHARGE)**.
7. Connect a jumper wire between `NE555` **Pin 7 (DISCHARGE)** and **Pin 6 (THRESHOLD)**.
8. Connect timing electrolytic capacitor `C_time` (47 µF) positive terminal to **Pin 6/7**, and negative terminal to `GND`.
9. `NE555` **Pin 3 (OUTPUT)** provides the stable debounced latched pump control signal.

### E. Actuator Driver & Relay Stage:
1. Connect `NE555` **Pin 3 (OUTPUT)** through resistor `RB` (1 kΩ) to `Q1 (BC547B)` **Base**.
2. Connect `Q1` **Emitter** directly to `GND (0V)`.
3. Connect `Q1` **Collector** to:
   - `K1 (RELAY_SPDT)` **Coil Terminal A2**.
   - `D1 (1N4007)` **Anode** terminal.
4. Connect `+12V_BUS` to:
   - `K1 (RELAY_SPDT)` **Coil Terminal A1**.
   - `D1 (1N4007)` **Cathode** terminal (silver stripe towards +12V).
   - `K1 (RELAY_SPDT)` **Common Contact (COM)**.
5. Connect `K1` **Normally Open Contact (NO)** to `M1 (12V DC Motor Pump)` **Positive (+)** lead.
6. Connect `M1 (12V DC Motor Pump)` **Negative (-)** lead to `GND (0V)`.
7. Connect `D2 (LED_BLUE)` in series with resistor `R_LED` (330 Ω) from `NE555 Pin 3` to `GND` for visual pump status.
8. Connect `BZ1 (5V Buzzer)` from `LM358 Pin 7 (High Out)` to `GND` for tank overflow audio warning.

---

## 4. 📊 Multisim Virtual Instrument Setup

### 4-Channel Oscilloscope (XSC1) Test Points:
Place the 4-channel oscilloscope from the right toolbar and connect the probes:
- **Channel A (Red Wire):** Connect to `LM358 Pin 3` (Low sensor Schmitt input).
- **Channel B (Blue Wire):** Connect to `LM358 Pin 1` (Schmitt trigger output).
- **Channel C (Orange Wire):** Connect to `NE555 Pin 6/7` (Exponential RC charging ramp).
- **Channel D (Green Wire):** Connect to `NE555 Pin 3` (Pump relay drive output).
- **Scope Ground:** Connect the scope ground terminal to `GND`.

**Recommended Oscilloscope Knob Settings:**
- **Timebase:** `1.0 s/Div` (or `500 ms/Div`)
- **Channel A, B, C, D Scale:** `2.0 V/Div`, Coupling: `DC`
- **Trigger:** Type: `Edge`, Source: `Channel B`, Slope: `Falling (Negative Edge)`

---

## 5. 🧪 Interactive Simulation Verification Protocol

Press **F5** (or click the green **Run** arrow at top) to start interactive simulation:

| Simulation Step | Tank Condition | Switch S_LOW [L] | Switch S_HIGH [H] | LM358 Pin 1 (Low) | LM358 Pin 7 (High) | NE555 Pin 3 (Output) | Relay (K1) | Pump Motor (M1) |
|:---:|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **Step 1** | **Empty Tank** (Dry) | **OPEN** (Dry) | **OPEN** (Dry) | **LOW (~0.05V)** | **LOW (~0.05V)** | **HIGH (~3.6V)** | **ENERGIZED** | **RUNNING (ON)** |
| **Step 2** | **Filling Tank** (Submerged Low) | **CLOSED** (Wet) | **OPEN** (Dry) | **HIGH (~3.8V)** | **LOW (~0.05V)** | **HIGH (Latched)** | **ENERGIZED** | **RUNNING (ON)** |
| **Step 3** | **Full Tank** (Target Reached) | **CLOSED** (Wet) | **CLOSED** (Wet) | **HIGH (~3.8V)** | **HIGH (~3.8V)** | **LOW (~0.1V)** | **DE-ENERGIZED**| **STOPPED (OFF)** |
| **Step 4** | **Draining Tank** (Receding) | **CLOSED** (Wet) | **OPEN** (Dry) | **HIGH (~3.8V)** | **LOW (~0.05V)** | **LOW (Latched)** | **DE-ENERGIZED**| **STOPPED (OFF)** |

> [!TIP]
> **Observation Key:** In Step 2 vs. Step 4, notice that the switch states are **identical** (`S_LOW` CLOSED, `S_HIGH` OPEN), but the pump status is opposite (ON during filling, OFF during draining). This experimentally validates the **bistable hysteresis memory loop** in Multisim without a single line of microcontroller code!

---

## 6. ⚠️ Troubleshooting Multisim SPICE Convergence & Simulation Warnings

If Multisim flags a simulation warning or does not switch:

1. **"Timestep too small" or Convergence Error:**
   - Go to `Simulate > Interactive Simulation Settings`.
   - Set **Initial conditions** to `Set to zero` or `Automatically determine`.
   - Under **Analysis Options**, click `Customize...` and change `TRTOL` from 7 to **10**, and set `ABSTOL = 1e-9`.
2. **Relay Does Not Click ON:**
   - Double-click `K1 (RELAY_SPDT)`. Ensure **Coil Voltage** is set to `12 V` and **Coil Resistance** is set to `400 Ω`.
   - Verify `BC547` Base resistor is \(1\ \text{k}\Omega\). Check that base voltage reaches \(\approx 0.75\ \text{V}\).
3. **555 Timer Remains Stuck High:**
   - Ensure `NE555 Pin 4 (RESET)` is pulled to GND when Pin 7 goes HIGH, or add an inverter BJT stage if using an active-low reset model in older Multisim 12 versions.
4. **Floating Node Error:**
   - Ensure a **`GROUND`** component is placed from `Sources > POWER_SOURCES > GROUND`. SPICE cannot compute nodal voltages without reference node 0.

---

## 7. 📥 Direct SPICE Netlist File (`sim/water_level_controller.cir`)

You can also directly load the pre-configured SPICE circuit file located at:  
👉 **[`sim/water_level_controller.cir`](file:///d:/Projects/PBL%20Project/sim/water_level_controller.cir)**

To import into Multisim:
1. Open NI Multisim.
2. Select `File > Open...`
3. Change file filter to **All Files (*.*)** and select `water_level_controller.cir`.
4. Click `Open` to run the transient analysis directly.

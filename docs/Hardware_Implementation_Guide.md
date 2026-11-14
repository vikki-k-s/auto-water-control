# 🛠️ Physical Hardware Implementation & Construction Guide
### Automatic Water-Level Controller Using Op-Amp and 555 Timer
**Course Code:** UE25EC3502 (Linear Integrated Circuits with Practice)  
**Institution:** GM University, Davanagere | **Semester:** 3rd | **Total Marks:** 40

---

## 1. 🛒 Complete Bill of Materials (BOM & Component Checklist)

All components listed below are standard electronic parts readily available from **Robu.in**, **Amazon.in**, or local electronics vendors in Davanagere / SP Road, Bengaluru.

| Sl. No. | Component Name | Description / Part No. | Package | Qty | Approx. Price (INR ₹) | Function in Hardware Circuit |
|:---:|:---|:---|:---:|:---:|:---:|:---|
| **1** | **Operational Amplifier IC** | **LM358** (Dual Low-Power Op-Amp) | DIP-8 | 1 | ₹18 | Dual comparators & Schmitt trigger threshold detection |
| **2** | **Precision Timer IC** | **NE555 / LM555** | DIP-8 | 1 | ₹15 | Monostable slosh-debounce delay & bistable flip-flop latch |
| **3** | **Voltage Regulator IC** | **LM7805** (+5.0V, 1.0A Positive Regulator) | TO-220 | 1 | ₹15 | Stable +5V DC power rail for LIC control circuitry |
| **4** | **Power Relay** | **12V SPDT Relay** (Songle SRD-12VDC-SL-C) | 5-Pin PCB | 1 | ₹35 | Electrical isolation & high-power switching for pump motor |
| **5** | **Driver Transistor** | **BC547B** (or 2N2222) NPN BJT | TO-92 | 2 | ₹4 each (₹8) | Transistor saturated switch driving relay coil & buzzer |
| **6** | **Flyback Clamp Diode** | **1N4007** (1000V, 1A Rectifier) | DO-41 | 2 | ₹2 each (₹4) | Suppresses inductive coil collapse voltage spikes (\(-L \frac{di}{dt}\)) |
| **7** | **Submersible Mini Pump** | 12V / 5V DC Mini Water Pump (3W, 240 L/H) | Submersible | 1 | ₹160 | Lifts water from underground sump to overhead tank |
| **8** | **Flexible Vinyl Tubing** | 6mm Inner Diameter Food-Grade PVC Hose | 1 Meter | 1 | ₹25 | Connects pump discharge nozzle to overhead tank inlet |
| **9** | **Water Sensor Probes** | SS304 Stainless Steel Screws / Rods (or Carbon) | Screws M4 | 3 | ₹15 | Corrosion-resistant conductive probes (COM, LOW, HIGH) |
| **10** | **Indicator LEDs** | 5mm Diffused (Red, Green, Blue, Amber) | Radial | 4 | ₹2 each (₹8) | Status: Low Water (Red), High (Green), Pump ON (Blue) |
| **11** | **Audible Piezo Buzzer** | 5V Continuous Active Electronic Buzzer | 2-Pin Radial| 1 | ₹20 | High-water overflow and dry-run audible alarm |
| **12** | **Decoupling Capacitors** | 0.33 µF (Input) & 0.1 µF (Output & Noise filter) | Ceramic Disc| 5 | ₹2 each (₹10) | 7805 RF stability, noise filtering across sensing probes |
| **13** | **Timing & Filter Caps** | 47 µF / 25V (Monostable) & 10 µF / 25V (Electrolytic)| Radial Can | 2 | ₹5 each (₹10) | Determines 5.17-second monostable debounce delay |
| **14** | **Precision Resistors** | 10 kΩ 1/4W 1% Metal Film | Axial | 4 | ₹1 each (₹4) | Precision 3-resistor potential divider (\(V_{ref1}, V_{ref2}\)) |
| **15** | **Biasing & Pull-down Resistors**| 100 kΩ 1/4W 5% Carbon Film | Axial | 2 | ₹1 each (₹2) | Pull-down resistors across Low and High sensing probes |
| **16** | **Hysteresis Resistor** | 470 kΩ 1/4W 5% Carbon Film | Axial | 1 | ₹1 | Positive feedback resistor for LM358 Schmitt trigger |
| **17** | **Base Drive & Current Limit** | 1 kΩ (Base) & 330 Ω (LED Ballast) | Axial | 5 | ₹1 each (₹5) | Drives transistor into saturation & prevents LED burnout |
| **18** | **Solderless Breadboard**| MB-102 (830 Tie-Points with Power Rails) | Standard | 1 | ₹140 | Prototype assembly and circuit interconnects |
| **19** | **Jumper Wires** | Male-to-Male & Male-to-Female Rainbow Jumper Wires| 20 cm | 1 Set (40 pcs)| ₹75 | Breadboard routing and off-board sensor interfacing |
| **20** | **DC Power Adapter** | 12V 1.0A Regulated SMPS Wall Adapter with DC Jack | 2.1mm Pin | 1 | ₹180 | Main DC source powering 7805 regulator and 12V pump |
| **21** | **Diorama Water Tanks** | Transparent 500 mL Plastic Containers (Sump & Overhead)| Acrylic/PET | 2 | ₹40 | Physical demonstration model displaying water level |
| **TOTAL** | — | — | — | — | **~₹770 – ₹850** | *(Full hardware budget for 4-student group)* |

---

## 2. 🔌 Breadboard Pinout & Wiring Connection Table

### Master Interconnect Wiring List:

| From Component & Pin | To Component & Pin | Wire Color Code | Functional Purpose |
|:---|:---|:---:|:---|
| **12V Adapter (+)** | Breadboard Top Red Rail (`+12V`) | Red | Primary 12V DC input bus |
| **12V Adapter (–)** | Breadboard Bottom Blue Rail (`GND`) | Black | Common circuit ground reference |
| **+12V Rail** | **IC 7805 Pin 1 (IN)** | Red | Unregulated DC input to voltage regulator |
| **GND Rail** | **IC 7805 Pin 2 (GND)** | Black | Regulator ground pin |
| **IC 7805 Pin 3 (OUT)** | Breadboard Inner Red Rail (`+5V V_CC`) | Orange | Regulated +5.0V power bus for LICs |
| **+12V to Pin 1** | **0.33 µF Ceramic Cap** to GND | Yellow | Input high-frequency bypass (prevents oscillation) |
| **+5V to Pin 3** | **0.1 µF Ceramic Cap** to GND | Yellow | Output transient stabilization |
| **+5V V_CC** | **R1 (10 kΩ)** to Node A | Brown | Top arm of reference potential divider |
| **Node A (V_ref_high)** | **R2 (10 kΩ)** to Node B & **LM358 Pin 6 (2IN-)** | Purple | Preset \(V_{ref2} = 3.33\ \text{V}\) for High Level Cutoff |
| **Node B (V_ref_low)** | **R3 (10 kΩ)** to GND & **LM358 Pin 2 (1IN-)** | Blue | Preset \(V_{ref1} = 1.67\ \text{V}\) for Low Level Pump Trigger |
| **Overhead Tank COM Probe** | **+5V V_CC Rail** | Orange | Injects +5V into water electrolyte |
| **Overhead Tank LOW Probe** | **Node C** (100 kΩ pull-down to GND + 0.1 µF cap)| Cyan | Conductive path for minimum water level detection |
| **Node C** | **10 kΩ \(R_{in}\)** to **LM358 Pin 3 (1IN+)** | Cyan | Input to Low-Level Schmitt Trigger Comparator |
| **LM358 Pin 1 (1OUT)** | **470 kΩ \(R_f\)** back to **LM358 Pin 3 (1IN+)** | White | Positive feedback creating 78 mV hysteresis band |
| **LM358 Pin 1 (1OUT)** | **NE555 Pin 2 (TRIGGER)** | Green | Triggers monostable timer & latches pump ON when water is low |
| **Overhead Tank HIGH Probe**| **Node D** (100 kΩ pull-down to GND + 0.1 µF cap)| Violet | Conductive path for maximum water level detection |
| **Node D** | **LM358 Pin 5 (2IN+)** | Violet | Non-inverting input to High-Level Comparator |
| **LM358 Pin 7 (2OUT)** | **NE555 Pin 4 (RESET)** & **Pin 6 (THRESHOLD)** | Gray | Resets latch & shuts pump OFF when water touches high probe |
| **NE555 Pin 8 (VCC)** | **+5V V_CC Rail** | Orange | 555 Supply voltage |
| **NE555 Pin 1 (GND)** | **GND Rail** | Black | 555 Ground |
| **NE555 Pin 5 (CTRL)** | **0.01 µF Ceramic Cap** to GND | Yellow | Noise decoupling for internal potential divider |
| **NE555 Pin 7 & 6** | **100 kΩ \(R_A\)** to +5V & **47 µF Cap** to GND | Brown | Monostable timing network: \(T = 1.1 \cdot R_A \cdot C = 5.17\ \text{s}\) |
| **NE555 Pin 3 (OUTPUT)** | **1 kΩ Base Resistor \(R_B\)** to **BC547 Base** | Blue | Saturated drive signal for relay switching |
| **BC547 Emitter** | **GND Rail** | Black | Common-emitter grounding |
| **BC547 Collector** | **12V Relay Coil (Pin 1)** & **1N4007 Anode** | Blue | Low-side switched collector output |
| **+12V Rail** | **12V Relay Coil (Pin 2)** & **1N4007 Cathode** | Red | Antiparallel inductive flyback clamp connection |
| **+12V Rail** | **Relay Common Contact (COM)** | Red | Power source for pump actuator |
| **Relay Normally Open (NO)**| **12V Mini Submersible Pump (+)** wire | Red | Power fed to pump only when relay is energized |
| **Pump (–) Wire** | **GND Rail** | Black | Return path for motor pump current |
| **BC547 Collector (2nd)** | **5V Buzzer (–)** (Buzzer (+) tied to +5V) | Gray | Audible alarm for tank full/overflow |

---

## 3. 🧪 Probe Design & Electrolysis Mitigation Techniques

A frequent failure mode in student water-level controller projects is **probe galvanic corrosion (electrolysis)**: when a continuous DC current passes through ordinary copper jumper wires immersed in tap water, the anode undergoes rapid oxidation (\(\text{Cu} \to \text{Cu}^{2+} + 2e^-\)), depositing green copper carbonate sludge within 48 to 72 hours and eroding the sensor wire.

### Academic Solutions Implemented in this Design:
1. **SS304 Stainless Steel Electrodes:** Using marine-grade 304 stainless steel screws or bicycle spoke segments. Stainless steel forms a self-healing passive chromium oxide (\(\text{Cr}_2\text{O}_3\)) film, preventing ionic degradation.
2. **Microampere Conduction Limiting:** By utilizing a large \(100\ \text{k}\Omega\) pull-down resistor and buffering the voltage through the ultra-high input impedance of the LM358 op-amp (\(R_{in} > 2\ \text{M}\Omega\)), the probe conduction current is strictly confined to:
   \[
   I_{probe} = \frac{V_{CC}}{R_{water} + R_{pulldown}} \approx \frac{5\ \text{V}}{2.5\ \text{k}\Omega + 100\ \text{k}\Omega} = 48.7\ \mu\text{A}
   \]
   At less than 50 microamperes, ionic transfer is negligible, extending probe lifespan to several years without requiring complex AC excitation generators.
3. **Electrode Insulation:** Heat-shrink tubing is shrunk over the entire length of the probe wires, exposing only the bottom 2 mm stainless steel tip. This eliminates false conduction from splashes clinging to the wire sides.

---

## 4. 📝 Step-by-Step Assembly & Testing Protocol

### Phase 1: Power Supply Subsystem Verification
1. Insert the **LM7805** regulator into the breadboard.
2. Connect \(0.33\ \mu\text{F}\) ceramic capacitor directly across Pin 1 (IN) and Pin 2 (GND).
3. Connect \(0.1\ \mu\text{F}\) ceramic capacitor across Pin 3 (OUT) and Pin 2 (GND).
4. Apply +12V DC from the wall adapter.
5. **DMM Check:** Measure voltage between Pin 3 and GND. Verify steady reading: **\(5.00\ \text{V} \pm 0.1\ \text{V}\)**. If voltage is erratic or IC warms up, immediately disconnect and check pin orientations.

### Phase 2: Precision Potential Divider & LM358 Op-Amp Comparators
1. Place three \(10\ \text{k}\Omega\) resistors in series between +5V and GND.
2. Verify node voltages using a Digital Multimeter:
   - Node between R1 and R2: **\(3.33\ \text{V}\)** (\(V_{ref2}\))
   - Node between R2 and R3: **\(1.67\ \text{V}\)** (\(V_{ref1}\))
3. Insert the **LM358** IC. Connect Pin 8 to +5V and Pin 4 to GND.
4. Route \(V_{ref1}\) (1.67V) to Pin 2 (Inverting Input 1) and \(V_{ref2}\) (3.33V) to Pin 6 (Inverting Input 2).
5. Add \(10\ \text{k}\Omega\) input resistor and \(470\ \text{k}\Omega\) feedback resistor across Pin 1 and Pin 3 to complete the Schmitt trigger.
6. Connect temporary jumper wires from +5V to the probe inputs and monitor Pin 1 and Pin 7 with DMM/LEDs to verify clean comparator switching.

### Phase 3: NE555 Monostable Timing & Bistable Latch Assembly
1. Insert the **NE555** IC. Connect Pin 8 to +5V, Pin 1 to GND, and Pin 5 through \(0.01\ \mu\text{F}\) capacitor to GND.
2. Connect \(100\ \text{k}\Omega\) resistor \(R_A\) from Pin 8 (+5V) to Pin 6/7, and \(47\ \mu\text{F}\) capacitor from Pin 6/7 to GND.
3. Connect LM358 Pin 1 (Low Level Comparator) to NE555 Pin 2 (TRIGGER).
4. Connect LM358 Pin 7 (High Level Comparator) to NE555 Pin 4 (RESET).
5. Connect a temporary test LED with \(330\ \Omega\) resistor to Pin 3 (OUTPUT).
6. **Timing Test:** Ground Pin 2 momentarily. The test LED will illuminate and hold for **\(5.17 \pm 0.3\ \text{seconds}\)** before turning off, proving monostable debounce operation!

### Phase 4: Relay Driver Stage & Submersible Pump Actuation
1. Insert **BC547** transistor. Connect Emitter to GND.
2. Route NE555 Pin 3 through a \(1\ \text{k}\Omega\) base resistor to the BC547 Base.
3. Connect the **12V SPDT Relay** coil between +12V rail and BC547 Collector.
4. **CRITICAL:** Insert **1N4007 diode** across the relay coil pins with the silver cathode band facing the +12V rail.
5. Connect Relay COM contact to +12V rail, and NO contact to the submersible pump positive (red) wire. Connect pump negative (black) wire to GND.
6. Submerge the pump in the lower sump container and secure the outlet tube into the upper tank.
7. Fill the tank gradually:
   - When water drops below Low Probe: Pump must engage with a firm mechanical relay "click".
   - When water rises between Low and High Probes: Pump must remain energised.
   - When water touches High Probe: Pump must immediately cut off and buzzer should emit a brief notification tone!

---

## 5. 🔍 Troubleshooting & Diagnostic Matrix

| Symptom / Observation | Probable Root Cause | Corrective Diagnostic Action |
|:---|:---|:---|
| **7805 Regulator becomes excessively hot to the touch** | DC pump or relay connected to +5V rail instead of +12V rail | Check wiring: High-current loads (pump & relay coil) must be powered directly from the +12V unregulated line, NOT the 7805 output. |
| **Relay chatters continuously when water touches probe** | Missing Schmitt trigger positive feedback resistor (\(R_f\)) or slosh delay capacitor | Verify that \(470\ \text{k}\Omega\) resistor is placed between LM358 Pin 1 and Pin 3, and ensure \(47\ \mu\text{F}\) capacitor is connected to 555 Pin 6/7. |
| **Pump does not turn ON when tank is empty** | Base drive current insufficient or BC547 oriented backwards | Check transistor pinout (Flat side facing you: Left=Collector, Center=Base, Right=Emitter for standard Indian TO-92 BC547). Ensure \(V_{BE} \approx 0.7\ \text{V}\). |
| **BC547 driver burns out after a few switching cycles** | 1N4007 flyback diode missing or inserted with reversed polarity | Inspect 1N4007 across relay coil: Silver cathode stripe MUST connect to +12V rail. Reverse polarity shorts the transistor to ground. |
| **Comparator does not detect water immersion** | Water resistance too high (distilled water) or pull-down resistor value too low | Add a pinch of table salt to simulate tap mineral conductivity, or increase pull-down resistor from \(100\ \text{k}\Omega\) to \(220\ \text{k}\Omega\). |

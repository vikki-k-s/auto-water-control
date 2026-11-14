# PowerShell script to generate Hardware Circuit Guide HTML and PDF
$ErrorActionPreference = "Stop"

$htmlPath = "d:\Projects\PBL Project\docs\Hardware_Circuit_Guide.html"
$pdfPath = "d:\Projects\PBL Project\docs\Hardware_Circuit_Guide.pdf"

$svgSchematic = Get-Content -Raw -Path "d:\Projects\PBL Project\docs\smart_signal_circuit_schematic.svg"

$html = @'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Hardware Circuit & Wiring Guide | GMU UE25EC2304</title>
<style>
  @page {
    size: A4 portrait;
    margin: 10mm 12mm 12mm 12mm;
  }
  * { box-sizing: border-box; }
  body {
    font-family: 'Segoe UI', Arial, sans-serif;
    font-size: 9pt;
    line-height: 1.35;
    color: #0f172a;
    margin: 0;
    padding: 0;
    background: #ffffff;
  }
  .header-box {
    background: linear-gradient(135deg, #1e3a8a 0%, #0284c7 100%);
    color: #ffffff;
    padding: 14px 18px;
    border-radius: 6px;
    margin-bottom: 12px;
  }
  .header-box h1 {
    margin: 0;
    font-size: 16pt;
    font-weight: 800;
    letter-spacing: 0.5px;
  }
  .header-box p {
    margin: 4px 0 0 0;
    font-size: 8.5pt;
    color: #e0f2fe;
  }
  h2 {
    font-size: 11pt;
    font-weight: 700;
    color: #1e3a8a;
    border-bottom: 2px solid #cbd5e1;
    padding-bottom: 3px;
    margin: 14px 0 6px 0;
  }
  h3 {
    font-size: 9.5pt;
    font-weight: 700;
    color: #0f766e;
    margin: 8px 0 3px 0;
  }
  p { margin: 0 0 6px 0; text-align: justify; }
  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 8pt;
    margin: 6px 0 10px 0;
  }
  table th, table td {
    border: 1px solid #cbd5e1;
    padding: 4px 7px;
    text-align: left;
  }
  table th {
    background: #1e3a8a;
    color: #ffffff;
    font-weight: 600;
  }
  table tr:nth-child(even) { background: #f8fafc; }
  .diagram-frame {
    text-align: center;
    margin: 10px 0;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 6px;
    background: #f8fafc;
  }
  .diagram-frame svg { max-width: 100%; height: auto; }
  .card {
    background: #f1f5f9;
    border-left: 3.5px solid #2563eb;
    padding: 6px 10px;
    margin: 6px 0;
    font-size: 8.5pt;
  }
  .green-card {
    background: #ecfdf5;
    border-left: 3.5px solid #059669;
    padding: 6px 10px;
    margin: 6px 0;
    font-size: 8.5pt;
  }
  .page-break { page-break-after: always; }
</style>
</head>
<body>

<div class="header-box">
  <h1>SMART REAL-TIME SIGNAL MONITORING SYSTEM</h1>
  <p><strong>Hardware Model Architecture, Circuit Schematic & Wiring Guide</strong> | Course Code: UE25EC2304</p>
  <p>GM UNIVERSITY | Faculty of Engineering &amp; Technology | Dept. of Electronics &amp; Communication Engineering</p>
</div>

<h2>1. Master Hardware Circuit Schematic Diagram</h2>
<p>
  The hardware acquisition model interfaces multi-modal physical electronic transducers with an embedded ATmega328P microcontroller running deterministic 500 Hz timer-driven sampling firmware. The circuit is segmented into 7 modular sections: (A) Low-Noise Regulated Power Supply &amp; AREF Reference; (B) AD8232 ECG Bio-Potential Instrumentation Front-End; (C) LM35 Precision Temperature Sensor; (D) Acoustic / Speech Electret Pre-Amplifier; (E) Active 2nd-Order Sallen-Key Anti-Aliasing Lowpass Filter; (F) Microcontroller ADC &amp; Telemetry Unit; and (G) PC Workstation UART Communication.
</p>

<div class="diagram-frame">
  <!-- SVG_SCHEMATIC -->
</div>

<div class="card">
  <strong>Key Circuit Highlights:</strong><br>
  &bull; <strong>Low-Noise ADC Reference:</strong> Precision AMS1117-3.3 regulator provides 3.30V rail to the MCU AREF pin, fixing quantization step size at <span style="font-family:monospace;">V_LSB = 3.222 mV</span> and achieving 61.00 dB SQNR.<br>
  &bull; <strong>Anti-Aliasing Filter:</strong> 2nd-Order active Sallen-Key lowpass filter with <span style="font-family:monospace;">fc = 194 Hz</span> eliminates spectral foldover artifacts prior to digital sampling at 500 Hz.<br>
  &bull; <strong>Isolated Transducer Grounding:</strong> Star-ground topology isolates digital high-speed UART switching noise from microvolt bio-potential signals.
</div>

<div class="page-break"></div>

<h2>2. Complete Bill of Materials (BOM)</h2>
<table>
  <thead>
    <tr>
      <th>Designator</th>
      <th>Component Description</th>
      <th>Part Number / Value</th>
      <th>Package / Form Factor</th>
      <th>Functional Role in System</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>U1</strong></td>
      <td>Bio-Potential Front-End IC</td>
      <td>AD8232 Heart Monitor Module</td>
      <td>Pre-assembled Breakout PCB</td>
      <td>Instrumentation amplification of Lead-II ECG with Right-Leg Drive (RLD).</td>
    </tr>
    <tr>
      <td><strong>U2</strong></td>
      <td>Precision Temperature Sensor</td>
      <td>LM35DZ Centigrade Sensor</td>
      <td>TO-92 (3-Pin)</td>
      <td>Linear thermal sensing with 10.0 mV/°C sensitivity from 0°C to 100°C.</td>
    </tr>
    <tr>
      <td><strong>U3</strong></td>
      <td>Dual Operational Amplifier</td>
      <td>LM358P Dual Op-Amp</td>
      <td>DIP-8</td>
      <td>Unit A: Audio microphone pre-amplifier (+33.6 dB gain); Unit B: Sallen-Key LPF.</td>
    </tr>
    <tr>
      <td><strong>U4</strong></td>
      <td>Low-Dropout Voltage Regulator</td>
      <td>AMS1117-3.3 LDO Regulator</td>
      <td>SOT-223 / Module</td>
      <td>Provides ultra-stable +3.30V analog reference rail for ATmega328P AREF pin.</td>
    </tr>
    <tr>
      <td><strong>U5</strong></td>
      <td>Microcontroller Unit (MCU)</td>
      <td>ATmega328P / Arduino Uno R3</td>
      <td>DIP-28 / Uno Board</td>
      <td>Executes 500 Hz Timer1 ISR, 10-bit SAR ADC, and UART serial framing.</td>
    </tr>
    <tr>
      <td><strong>MIC1</strong></td>
      <td>Electret Condenser Microphone</td>
      <td>6mm Omnidirectional Capsule</td>
      <td>Through-hole (2-Pin)</td>
      <td>Transduces acoustic speech and sound vibrations into electrical voltages.</td>
    </tr>
    <tr>
      <td><strong>R1, R2</strong></td>
      <td>Sallen-Key Filter Resistors</td>
      <td>8.2 kΩ &plusmn;1% Metal Film</td>
      <td>1/4 Watt Through-hole</td>
      <td>Sets anti-aliasing cutoff frequency fc = 194 Hz with C4, C5.</td>
    </tr>
    <tr>
      <td><strong>R_b</strong></td>
      <td>Microphone Bias Resistor</td>
      <td>2.2 kΩ &plusmn;5% Carbon Film</td>
      <td>1/4 Watt Through-hole</td>
      <td>Supplies operating JFET bias current to electret capsule from +5V rail.</td>
    </tr>
    <tr>
      <td><strong>R_f, R_in</strong></td>
      <td>Op-Amp Gain Network</td>
      <td>47 kΩ and 1.0 kΩ &plusmn;1%</td>
      <td>1/4 Watt Through-hole</td>
      <td>Sets non-inverting audio pre-amplifier voltage gain Av = 1 + 47k/1k = 48.</td>
    </tr>
    <tr>
      <td><strong>R_temp</strong></td>
      <td>Thermal Decoupling Resistor</td>
      <td>1.0 kΩ &plusmn;5% Carbon Film</td>
      <td>1/4 Watt Through-hole</td>
      <td>Forms 159 Hz lowpass RC filter with C_temp on LM35 output.</td>
    </tr>
    <tr>
      <td><strong>C1, C_temp</strong></td>
      <td>Electrolytic Bypass Capacitors</td>
      <td>10 µF and 1.0 µF (25V)</td>
      <td>Radial Aluminum Electrolytic</td>
      <td>Bulk power rail filtering and low-frequency DC voltage stabilization.</td>
    </tr>
    <tr>
      <td><strong>C2, C4, C5</strong></td>
      <td>Ceramic Noise Decoupling Caps</td>
      <td>0.1 µF (100 nF, 50V)</td>
      <td>Multilayer Ceramic (MLCC)</td>
      <td>High-frequency noise shunting and active Sallen-Key frequency tuning.</td>
    </tr>
  </tbody>
</table>

<h2>3. Breadboard / Hardware Pin-to-Pin Wiring Table</h2>
<table>
  <thead>
    <tr>
      <th>Signal Origin (Transducer Pin)</th>
      <th>Intermediate Component / Net</th>
      <th>MCU Destination Pin</th>
      <th>Signal Description &amp; Verification Point</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>AD8232 Pin OUTPUT</strong></td>
      <td>Direct connection</td>
      <td><strong>MCU Analog Pin A0</strong></td>
      <td>Bio-potential ECG Lead-II signal (0.2V to 3.0V). Monitored at <strong>TP1</strong>.</td>
    </tr>
    <tr>
      <td><strong>AD8232 Pin LO+</strong></td>
      <td>Direct connection</td>
      <td><strong>MCU Digital Pin D10</strong></td>
      <td>Digital logic HIGH when Right-Arm electrode falls off.</td>
    </tr>
    <tr>
      <td><strong>AD8232 Pin LO-</strong></td>
      <td>Direct connection</td>
      <td><strong>MCU Digital Pin D11</strong></td>
      <td>Digital logic HIGH when Left-Arm electrode falls off.</td>
    </tr>
    <tr>
      <td><strong>LM35 Pin 2 (VOUT)</strong></td>
      <td>Through 1.0 kΩ / 1.0 µF RC filter</td>
      <td><strong>MCU Analog Pin A1</strong></td>
      <td>Precision temperature voltage (285 mV @ 28.5°C). Monitored at <strong>TP2</strong>.</td>
    </tr>
    <tr>
      <td><strong>LM358 Pin 1 (Audio Out)</strong></td>
      <td>Through 2nd-order Sallen-Key filter</td>
      <td><strong>MCU Analog Pin A2</strong></td>
      <td>Pre-amplified audio vowel formants. Monitored at <strong>TP3</strong>.</td>
    </tr>
    <tr>
      <td><strong>AMS1117 Pin 2 (VOUT)</strong></td>
      <td>Filtered by 0.1 µF ceramic cap</td>
      <td><strong>MCU AREF Pin 21</strong></td>
      <td>3.30V Low-Noise Analog Reference for 10-bit SAR ADC.</td>
    </tr>
    <tr>
      <td><strong>MCU Digital Pin D1 / TX</strong></td>
      <td>USB Serial Bridge (CH340G / FT232)</td>
      <td><strong>PC USB Port</strong></td>
      <td>JSON telemetry stream at 115200 baud to Python engine / Web dashboard.</td>
    </tr>
  </tbody>
</table>

<h2>4. Step-by-Step Testing &amp; Calibration Procedure</h2>
<div class="green-card">
  <strong>Pre-Power Sanity Check:</strong> With power disconnected, verify continuity between all Ground nodes. Ensure no short circuit exists between the +5V and +3.3V rails.<br>
  <strong>Step 1 (AREF Calibration):</strong> Power the board via USB. Measure DC voltage at Pin 21 (AREF) with a digital multimeter. Verify it reads exactly <span style="font-family:monospace;">3.30V &plusmn; 0.03V</span>.<br>
  <strong>Step 2 (LM35 Temperature Check):</strong> Measure voltage at TP2. At typical room temperature (25°C to 28°C), the multimeter should read between <span style="font-family:monospace;">250 mV and 280 mV</span>.<br>
  <strong>Step 3 (Audio Pre-Amp Verification):</strong> Speak or hum near the electret microphone while observing TP3 on an oscilloscope. Confirm clean amplified audio waveforms without clipping.<br>
  <strong>Step 4 (ECG Leads Connection):</strong> Connect the 3 electrode pads (RA to right wrist/chest, LA to left wrist/chest, RL to right leg/abdomen). Verify that the status LED D13 pulses in synchrony with the cardiac rhythm.
</div>

</body>
</html>
'@

$html = $html.Replace('<!-- SVG_SCHEMATIC -->', $svgSchematic)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Host "Hardware Guide HTML written to $htmlPath"

# Compile to PDF using Microsoft Edge headless
$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf=`"$pdfPath`" `"file:///$($htmlPath.Replace('\', '/'))`"" -PassThru -Wait

Write-Host "Edge exited with code $($proc.ExitCode)"
if (Test-Path $pdfPath) {
    $pdfSize = (Get-Item $pdfPath).Length
    Write-Host "Hardware Circuit Guide PDF successfully created: $pdfPath (Size: $pdfSize bytes)"
}

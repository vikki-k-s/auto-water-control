"""
Generates clean vector SVGs for:
1. docs/system_block_diagram.svg (System Architecture)
2. docs/sensor_acquisition_schematic.svg (Hardware Schematic)
"""

def generate_system_block_diagram():
    svg = '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 950 360" width="100%" height="100%">
  <defs>
    <linearGradient id="gradHeader" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#1e3a8a"/>
      <stop offset="100%" stop-color="#0284c7"/>
    </linearGradient>
    <linearGradient id="gradBox1" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" stop-color="#f8fafc"/>
      <stop offset="100%" stop-color="#f1f5f9"/>
    </linearGradient>
    <filter id="cardShadow" x="-5%" y="-5%" width="110%" height="110%">
      <feDropShadow dx="1" dy="2" stdDeviation="2" flood-color="#0f172a" flood-opacity="0.12"/>
    </filter>
    <marker id="arrow" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M 0 1 L 9 5 L 0 9 z" fill="#1e3a8a"/>
    </marker>
    <marker id="arrowGreen" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M 0 1 L 9 5 L 0 9 z" fill="#047857"/>
    </marker>
  </defs>

  <style>
    .title { font-family: 'Segoe UI', Arial, sans-serif; font-size: 15px; font-weight: 800; fill: #ffffff; }
    .subtitle { font-family: 'Segoe UI', Arial, sans-serif; font-size: 10px; font-weight: 600; fill: #e0f2fe; }
    .box-title { font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 700; fill: #1e3a8a; }
    .item-text { font-family: 'Segoe UI', Arial, sans-serif; font-size: 9.5px; fill: #334155; }
    .item-bold { font-family: 'Segoe UI', Arial, sans-serif; font-size: 9.5px; font-weight: 700; fill: #0f172a; }
    .unit-tag { font-family: 'Segoe UI', Arial, sans-serif; font-size: 8px; font-weight: 800; fill: #ffffff; }
    .bus-label { font-family: 'Segoe UI', Arial, sans-serif; font-size: 9px; font-weight: 600; fill: #047857; }
  </style>

  <!-- Banner Header -->
  <rect x="10" y="8" width="930" height="42" rx="6" fill="url(#gradHeader)" filter="url(#cardShadow)"/>
  <text x="30" y="27" class="title">SMART REAL-TIME SIGNAL MONITORING AND ANALYSIS SYSTEM ARCHITECTURE</text>
  <text x="30" y="42" class="subtitle">Complete Coverage of Syllabus Units 1 through 6 | GM University - UE25EC2304</text>

  <!-- STAGE 1: SIGNAL ACQUISITION (UNIT 6) -->
  <g transform="translate(15, 62)">
    <rect x="0" y="0" width="165" height="280" rx="6" fill="url(#gradBox1)" stroke="#cbd5e1" stroke-width="1.5" filter="url(#cardShadow)"/>
    <rect x="0" y="0" width="165" height="26" rx="6" fill="#1e3a8a"/>
    <rect x="0" y="20" width="165" height="6" fill="#1e3a8a"/>
    <text x="12" y="17" style="font-family:'Segoe UI'; font-size:10.5px; font-weight:700; fill:#ffffff;">1. MULTI-SENSOR INPUTS</text>
    <rect x="110" y="6" width="45" height="14" rx="3" fill="#0284c7"/>
    <text x="115" y="16" class="unit-tag">UNIT 6</text>

    <!-- Sub items -->
    <rect x="10" y="36" width="145" height="48" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="16" y="51" class="item-bold">Biomedical: ECG Lead-II</text>
    <text x="16" y="64" class="item-text">AD8232 Analog Front-End</text>
    <text x="16" y="76" class="item-text">P-Q-R-S-T wave @ 72 BPM</text>

    <rect x="10" y="92" width="145" height="48" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="16" y="107" class="item-bold">Environmental: Temperature</text>
    <text x="16" y="120" class="item-text">LM35 Precision Sensor</text>
    <text x="16" y="132" class="item-text">10 mV/°C Diurnal Sinusoid</text>

    <rect x="10" y="148" width="145" height="48" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="16" y="163" class="item-bold">Acoustic: Speech / Audio</text>
    <text x="16" y="176" class="item-text">Electret Mic Transducer</text>
    <text x="16" y="188" class="item-text">Multi-formant Vocal Timbre</text>

    <rect x="10" y="204" width="145" height="48" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="16" y="219" class="item-bold">Communication: Modulated</text>
    <text x="16" y="232" class="item-text">FSK / AM Carrier Wave</text>
    <text x="16" y="244" class="item-text">1200 / 2200 Hz Shift Keying</text>
  </g>

  <!-- Arrow 1 to 2 -->
  <path d="M 180 202 L 205 202" stroke="#1e3a8a" stroke-width="2" marker-end="url(#arrow)" fill="none"/>

  <!-- STAGE 2: CONDITIONING & ADC (UNIT 6) -->
  <g transform="translate(205, 62)">
    <rect x="0" y="0" width="145" height="280" rx="6" fill="url(#gradBox1)" stroke="#cbd5e1" stroke-width="1.5" filter="url(#cardShadow)"/>
    <rect x="0" y="0" width="145" height="26" rx="6" fill="#1e3a8a"/>
    <rect x="0" y="20" width="145" height="6" fill="#1e3a8a"/>
    <text x="10" y="17" style="font-family:'Segoe UI'; font-size:10.5px; font-weight:700; fill:#ffffff;">2. HARDWARE &amp; ADC</text>
    <rect x="95" y="6" width="42" height="14" rx="3" fill="#0284c7"/>
    <text x="100" y="16" class="unit-tag">UNIT 6</text>

    <rect x="8" y="36" width="129" height="52" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="52" class="item-bold">Anti-Aliasing Filter</text>
    <text x="14" y="66" class="item-text">Active Butterworth LPF</text>
    <text x="14" y="80" class="item-text">fc &lt; fs/2 (Nyquist-Shannon)</text>

    <rect x="8" y="96" width="129" height="58" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="112" class="item-bold">10-Bit SAR ADC (MCU)</text>
    <text x="14" y="126" class="item-text">ATmega328P / ESP32</text>
    <text x="14" y="139" class="item-text">V_ref = 3.3V, LSB = 3.22 mV</text>
    <text x="14" y="151" class="item-text">Sampling Rate fs = 500 Hz</text>

    <rect x="8" y="162" width="129" height="52" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="178" class="item-bold">Serial Telemetry</text>
    <text x="14" y="192" class="item-text">UART Framing @ 115200</text>
    <text x="14" y="206" class="item-text">JSON / CSV Stream Stream</text>

    <rect x="8" y="222" width="129" height="48" rx="4" fill="#ecfdf5" stroke="#a7f3d0"/>
    <text x="14" y="238" class="item-bold" style="fill:#065f46;">Virtual Sensor Engine</text>
    <text x="14" y="252" class="item-text" style="fill:#047857;">Standalone Simulation</text>
    <text x="14" y="264" class="item-text" style="fill:#047857;">Zero-Hardware Mode</text>
  </g>

  <!-- Arrow 2 to 3 -->
  <path d="M 350 202 L 375 202" stroke="#1e3a8a" stroke-width="2" marker-end="url(#arrow)" fill="none"/>

  <!-- STAGE 3: CLASSIFICATION & OPERATIONS (UNIT 1) -->
  <g transform="translate(375, 62)">
    <rect x="0" y="0" width="175" height="280" rx="6" fill="url(#gradBox1)" stroke="#cbd5e1" stroke-width="1.5" filter="url(#cardShadow)"/>
    <rect x="0" y="0" width="175" height="26" rx="6" fill="#1e3a8a"/>
    <rect x="0" y="20" width="175" height="6" fill="#1e3a8a"/>
    <text x="10" y="17" style="font-family:'Segoe UI'; font-size:10px; font-weight:700; fill:#ffffff;">3. CLASSIFY &amp; OPERATE</text>
    <rect x="122" y="6" width="45" height="14" rx="3" fill="#0284c7"/>
    <text x="127" y="16" class="unit-tag">UNIT 1</text>

    <rect x="8" y="34" width="159" height="105" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="48" class="item-bold">Signal Classification Engine</text>
    <text x="14" y="62" class="item-text">• CT vs DT: fs, Nyquist limits</text>
    <text x="14" y="76" class="item-text">• Determ. vs Random: Autocorr.</text>
    <text x="14" y="90" class="item-text">• Periodic: T0 = 0.833s, f0 = 1.2Hz</text>
    <text x="14" y="104" class="item-text">• Energy: E = ∫ |x(t)|² dt</text>
    <text x="14" y="118" class="item-text">• Power: P = 1/T ∫ |x(t)|² dt</text>
    <text x="14" y="132" class="item-text">• Class: Power Signal (P &gt; 0)</text>

    <rect x="8" y="146" width="159" height="124" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="161" class="item-bold">Elementary Transformations</text>
    <text x="14" y="175" class="item-text">• Amp Scale: y(t) = A·x(t)</text>
    <text x="14" y="189" class="item-text">• Time Shift: y(t) = x(t - t0)</text>
    <text x="14" y="203" class="item-text">• Time Scale: y(t) = x(a·t)</text>
    <text x="14" y="217" class="item-text">• Reversal: y(t) = x(-t)</text>
    <text x="14" y="231" class="item-text">• Addition: x1(t) + x2(t)</text>
    <text x="14" y="245" class="item-text">• Modulation: x1(t) · x2(t)</text>
    <text x="14" y="259" class="item-text">• Even/Odd: xe(t) + xo(t)</text>
  </g>

  <!-- Arrow 3 to 4 -->
  <path d="M 550 202 L 575 202" stroke="#1e3a8a" stroke-width="2" marker-end="url(#arrow)" fill="none"/>

  <!-- STAGE 4: LTI CONVOLUTION, FOURIER & Z-TRANSFORM (UNITS 2, 3, 4, 5) -->
  <g transform="translate(575, 62)">
    <rect x="0" y="0" width="185" height="280" rx="6" fill="url(#gradBox1)" stroke="#cbd5e1" stroke-width="1.5" filter="url(#cardShadow)"/>
    <rect x="0" y="0" width="185" height="26" rx="6" fill="#1e3a8a"/>
    <rect x="0" y="20" width="185" height="6" fill="#1e3a8a"/>
    <text x="10" y="17" style="font-family:'Segoe UI'; font-size:10px; font-weight:700; fill:#ffffff;">4. LTI, FOURIER &amp; Z-PLANE</text>
    <rect x="125" y="6" width="52" height="14" rx="3" fill="#0284c7"/>
    <text x="128" y="16" class="unit-tag">UNITS 2-5</text>

    <rect x="8" y="34" width="169" height="52" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="48" class="item-bold">Unit 2: LTI System &amp; Convolution</text>
    <text x="14" y="61" class="item-text">• Impulse: h[n] (RC decay / MA)</text>
    <text x="14" y="73" class="item-text">• Linear Conv: y[n] = x[n] * h[n]</text>
    <text x="14" y="84" class="item-text">• BIBO Stability: ∑|h[n]| &lt; ∞</text>

    <rect x="8" y="92" width="169" height="56" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="106" class="item-bold">Unit 3: Fourier Series Analysis</text>
    <text x="14" y="120" class="item-text">• Trigonometric a0, an, bn integrals</text>
    <text x="14" y="132" class="item-text">• Harmonic synthesis (N=1..50)</text>
    <text x="14" y="144" class="item-text">• Gibbs Phenomenon overshoot</text>

    <rect x="8" y="154" width="169" height="56" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="168" class="item-bold">Unit 4: Fourier Transform (FFT)</text>
    <text x="14" y="182" class="item-text">• Magnitude |X(f)| &amp; Phase ∠X(f)</text>
    <text x="14" y="194" class="item-text">• 50 Hz Hum notch filtering</text>
    <text x="14" y="206" class="item-text">• Diagnostic Bandpass (0.5 - 40 Hz)</text>

    <rect x="8" y="216" width="169" height="54" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="14" y="230" class="item-bold">Unit 5: Z-Transform &amp; ROC</text>
    <text x="14" y="244" class="item-text">• Transfer Function H(z) = B(z)/A(z)</text>
    <text x="14" y="256" class="item-text">• Pole-Zero Map, |p|_max &lt; 1</text>
    <text x="14" y="267" class="item-text">• Difference Eqn Realization</text>
  </g>

  <!-- Arrow 4 to 5 -->
  <path d="M 760 202 L 785 202" stroke="#1e3a8a" stroke-width="2" marker-end="url(#arrow)" fill="none"/>

  <!-- STAGE 5: MONITORING & UI DASHBOARD -->
  <g transform="translate(785, 62)">
    <rect x="0" y="0" width="150" height="280" rx="6" fill="url(#gradBox1)" stroke="#cbd5e1" stroke-width="1.5" filter="url(#cardShadow)"/>
    <rect x="0" y="0" width="150" height="26" rx="6" fill="#047857"/>
    <rect x="0" y="20" width="150" height="6" fill="#047857"/>
    <text x="10" y="17" style="font-family:'Segoe UI'; font-size:10px; font-weight:700; fill:#ffffff;">5. OUTPUT &amp; VISUALS</text>
    <rect x="100" y="6" width="42" height="14" rx="3" fill="#10b981"/>
    <text x="105" y="16" class="unit-tag">RESULTS</text>

    <rect x="8" y="36" width="134" height="48" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="12" y="52" class="item-bold">Dual Scope Display</text>
    <text x="12" y="66" class="item-text">Real-time raw vs clean</text>
    <text x="12" y="78" class="item-text">Waveform overlay</text>

    <rect x="8" y="92" width="134" height="48" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="12" y="108" class="item-bold">Operations Sandbox</text>
    <text x="12" y="122" class="item-text">Live sliders: A, t0, a</text>
    <text x="12" y="134" class="item-text">Dynamic update</text>

    <rect x="8" y="148" width="134" height="48" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="12" y="164" class="item-bold">Spectral Analyzer</text>
    <text x="12" y="178" class="item-text">FFT magnitude dB plot</text>
    <text x="12" y="190" class="item-text">Harmonic bars (1..50)</text>

    <rect x="8" y="204" width="134" height="66" rx="4" fill="#ffffff" stroke="#e2e8f0"/>
    <text x="12" y="220" class="item-bold">Telemetry &amp; Alerts</text>
    <text x="12" y="234" class="item-text">Heart Rate: 72 BPM</text>
    <text x="12" y="246" class="item-text">Temp: 28.5 °C Normal</text>
    <text x="12" y="258" class="item-text">SNR Improvement: +26dB</text>
  </g>
</svg>'''
    with open('/mnt/d/Projects/PBL Project/docs/system_block_diagram.svg', 'w') as f:
        f.write(svg)
    print("Generated docs/system_block_diagram.svg successfully.")

def generate_sensor_schematic():
    svg = '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 850 300" width="100%" height="100%">
  <defs>
    <marker id="arrow" viewBox="0 0 10 10" refX="8" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M 0 1 L 9 5 L 0 9 z" fill="#1e3a8a"/>
    </marker>
  </defs>
  <style>
    .title { font-family: 'Segoe UI', Arial, sans-serif; font-size: 13px; font-weight: 700; fill: #1e3a8a; }
    .box-title { font-family: 'Segoe UI', Arial, sans-serif; font-size: 11px; font-weight: 700; fill: #ffffff; }
    .node-text { font-family: 'Segoe UI', Arial, sans-serif; font-size: 9px; fill: #334155; }
    .pin-label { font-family: 'Courier New', monospace; font-size: 9px; font-weight: bold; fill: #0f172a; }
  </style>

  <!-- Title -->
  <text x="20" y="22" class="title">HARDWARE SENSOR ACQUISITION &amp; ADC INTERFACE SCHEMATIC (UNIT 6)</text>
  <line x1="20" y1="28" x2="830" y2="28" stroke="#cbd5e1" stroke-width="1.2"/>

  <!-- Sensor 1: AD8232 ECG -->
  <g transform="translate(25, 45)">
    <rect x="0" y="0" width="150" height="95" rx="5" fill="#f8fafc" stroke="#3b82f6" stroke-width="1.5"/>
    <rect x="0" y="0" width="150" height="22" rx="5" fill="#3b82f6"/>
    <rect x="0" y="17" width="150" height="5" fill="#3b82f6"/>
    <text x="10" y="15" class="box-title">AD8232 ECG Module</text>
    <text x="10" y="38" class="node-text">Electrodes: RA, LA, RL</text>
    <text x="10" y="52" class="node-text">Gain: 100 V/V</text>
    <text x="10" y="66" class="node-text">Instrumentation Amp</text>
    <text x="10" y="80" class="node-text">Bandwidth: 0.5 - 40 Hz</text>
    <circle cx="150" cy="50" r="3" fill="#1e3a8a"/>
    <text x="120" y="46" class="pin-label">OUTPUT</text>
  </g>

  <!-- Sensor 2: LM35 Temperature -->
  <g transform="translate(25, 160)">
    <rect x="0" y="0" width="150" height="95" rx="5" fill="#f8fafc" stroke="#f59e0b" stroke-width="1.5"/>
    <rect x="0" y="0" width="150" height="22" rx="5" fill="#f59e0b"/>
    <rect x="0" y="17" width="150" height="5" fill="#f59e0b"/>
    <text x="10" y="15" class="box-title">LM35 Precision Temp</text>
    <text x="10" y="38" class="node-text">Calibrated in °Celsius</text>
    <text x="10" y="52" class="node-text">Sensitivity: 10 mV/°C</text>
    <text x="10" y="66" class="node-text">Range: -55°C to 150°C</text>
    <text x="10" y="80" class="node-text">Linear Scale Factor</text>
    <circle cx="150" cy="50" r="3" fill="#1e3a8a"/>
    <text x="125" y="46" class="pin-label">VOUT</text>
  </g>

  <!-- Signal Conditioning (Buffer / Low Pass) -->
  <g transform="translate(245, 95)">
    <polygon points="0,0 80,45 0,90" fill="#eff6ff" stroke="#2563eb" stroke-width="1.5"/>
    <text x="12" y="35" class="pin-label">+</text>
    <text x="12" y="65" class="pin-label">-</text>
    <text x="22" y="50" style="font-family:'Segoe UI'; font-size:10px; font-weight:700; fill:#1e3a8a;">OP-AMP</text>
    <text x="2" y="105" class="node-text">Anti-Aliasing Filter</text>
    <text x="2" y="118" class="node-text">Sallen-Key 2nd Order</text>
    <text x="2" y="130" class="node-text">fc = 200 Hz</text>
  </g>

  <!-- Wires from sensors to buffer -->
  <path d="M 175 95 L 210 95 L 210 120 L 245 120" stroke="#1e3a8a" stroke-width="1.5" fill="none"/>
  <path d="M 175 210 L 210 210 L 210 160 L 245 160" stroke="#1e3a8a" stroke-width="1.5" fill="none"/>

  <!-- Microcontroller Block (Arduino / ATmega328P / ESP32) -->
  <g transform="translate(390, 55)">
    <rect x="0" y="0" width="200" height="195" rx="6" fill="#f8fafc" stroke="#059669" stroke-width="1.8"/>
    <rect x="0" y="0" width="200" height="24" rx="6" fill="#059669"/>
    <rect x="0" y="18" width="200" height="6" fill="#059669"/>
    <text x="15" y="17" class="box-title">MICROCONTROLLER UNIT (MCU)</text>

    <!-- Pins -->
    <text x="12" y="45" class="pin-label">A0 (Pin 23)</text>
    <text x="75" y="45" class="node-text">&lt;- ECG Analog Input</text>

    <text x="12" y="70" class="pin-label">A1 (Pin 24)</text>
    <text x="75" y="70" class="node-text">&lt;- Temp Sensor Input</text>

    <text x="12" y="95" class="pin-label">AREF</text>
    <text x="75" y="95" class="node-text">&lt;- 3.3V Low-Noise Ref</text>

    <rect x="15" y="110" width="170" height="42" rx="3" fill="#ecfdf5" stroke="#a7f3d0"/>
    <text x="22" y="125" style="font-family:'Segoe UI'; font-size:9.5px; font-weight:700; fill:#065f46;">10-Bit SAR Analog-to-Digital</text>
    <text x="22" y="138" class="node-text">fs = 500 Hz (Timer1 ISR)</text>
    <text x="22" y="148" class="node-text">LSB = 3.3V / 1024 = 3.22 mV</text>

    <text x="12" y="172" class="pin-label">TX (Pin 1)</text>
    <text x="75" y="172" class="node-text">-&gt; UART Serial Telemetry</text>
  </g>

  <!-- Wire buffer to MCU A0 -->
  <path d="M 325 140 L 355 140 L 355 90 L 390 90" stroke="#1e3a8a" stroke-width="1.5" marker-end="url(#arrow)" fill="none"/>

  <!-- PC / Signal Processing Workstation -->
  <g transform="translate(660, 55)">
    <rect x="0" y="0" width="165" height="195" rx="6" fill="#f8fafc" stroke="#4f46e5" stroke-width="1.8"/>
    <rect x="0" y="0" width="165" height="24" rx="6" fill="#4f46e5"/>
    <rect x="0" y="18" width="165" height="6" fill="#4f46e5"/>
    <text x="10" y="17" class="box-title">PC WORKSTATION</text>

    <text x="10" y="48" class="pin-label">USB UART (CH340/FTDI)</text>
    <text x="10" y="62" class="node-text">Baud Rate: 115200 bps</text>
    
    <rect x="10" y="76" width="145" height="100" rx="3" fill="#eef2ff" stroke="#c7d2fe"/>
    <text x="16" y="92" style="font-family:'Segoe UI'; font-size:9.5px; font-weight:700; fill:#3730a3;">Python DSP Engine</text>
    <text x="16" y="106" class="node-text">• Unit 1: Signal Classify</text>
    <text x="16" y="120" class="node-text">• Unit 2: LTI Convolution</text>
    <text x="16" y="134" class="node-text">• Unit 3: Fourier Series</text>
    <text x="16" y="148" class="node-text">• Unit 4: FFT Spectrum</text>
    <text x="16" y="162" class="node-text">• Unit 5: Z-Transform</text>
  </g>

  <!-- Cable between MCU and PC -->
  <path d="M 590 152 L 660 152" stroke="#4f46e5" stroke-width="2.5" stroke-dasharray="4" marker-end="url(#arrow)" fill="none"/>
  <text x="596" y="144" style="font-family:'Segoe UI'; font-size:9px; font-weight:700; fill:#4f46e5;">USB Cable</text>
</svg>'''
    with open('/mnt/d/Projects/PBL Project/docs/sensor_acquisition_schematic.svg', 'w') as f:
        f.write(svg)
    print("Generated docs/sensor_acquisition_schematic.svg successfully.")

if __name__ == "__main__":
    generate_system_block_diagram()
    generate_sensor_schematic()

# Create SVG assets for UE26EC2303 PBL Report
$ErrorActionPreference = "Stop"
$docsDir = "d:\Projects\PBL Project\docs"

if (!(Test-Path $docsDir)) {
    New-Item -ItemType Directory -Path $docsDir -Force | Out-Null
}

# 1. System Architecture Diagram
$svgArch = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 135" width="100%" height="100%">
  <defs>
    <linearGradient id="gradBlue" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#1e3a8a"/>
      <stop offset="100%" stop-color="#3b82f6"/>
    </linearGradient>
    <linearGradient id="gradCyan" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0f766e"/>
      <stop offset="100%" stop-color="#14b8a6"/>
    </linearGradient>
    <linearGradient id="gradPurple" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#581c87"/>
      <stop offset="100%" stop-color="#8b5cf6"/>
    </linearGradient>
    <linearGradient id="gradAmber" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#b45309"/>
      <stop offset="100%" stop-color="#f59e0b"/>
    </linearGradient>
    <marker id="arrow" viewBox="0 0 10 10" refX="6" refY="5" markerWidth="6" markerHeight="6" orient="auto-start-reverse">
      <path d="M 0 1 L 10 5 L 0 9 z" fill="#1e3a8a"/>
    </marker>
  </defs>

  <!-- Background -->
  <rect x="0" y="0" width="720" height="135" fill="#f8fafc" rx="6" stroke="#cbd5e1" stroke-width="1.2"/>

  <!-- Block 1: Audio Signal Input -->
  <g transform="translate(15, 18)">
    <rect width="125" height="95" rx="5" fill="url(#gradBlue)" stroke="#1e3a8a" stroke-width="1.2"/>
    <text x="62" y="24" fill="#ffffff" font-family="'Segoe UI', Arial" font-size="10" font-weight="bold" text-anchor="middle">AUDIO SOURCE</text>
    <text x="62" y="42" fill="#bfdbfe" font-family="'Segoe UI', Arial" font-size="8" text-anchor="middle">Function Generator /</text>
    <text x="62" y="55" fill="#bfdbfe" font-family="'Segoe UI', Arial" font-size="8" text-anchor="middle">3.5mm Aux Audio</text>
    <rect x="12" y="66" width="101" height="20" rx="3" fill="#172554"/>
    <text x="62" y="80" fill="#93c5fd" font-family="monospace" font-size="7.5" font-weight="bold" text-anchor="middle">20 Hz - 20 kHz | 1 Vpp</text>
  </g>

  <!-- Arrow 1 -->
  <line x1="140" y1="65" x2="162" y2="65" stroke="#1e3a8a" stroke-width="2.5" marker-end="url(#arrow)"/>
  <text x="151" y="56" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold" text-anchor="middle">Vin(t)</text>

  <!-- Block 2: Input Buffer Stage -->
  <g transform="translate(165, 18)">
    <rect width="115" height="95" rx="5" fill="url(#gradCyan)" stroke="#0f766e" stroke-width="1.2"/>
    <text x="57" y="24" fill="#ffffff" font-family="'Segoe UI', Arial" font-size="9.5" font-weight="bold" text-anchor="middle">INPUT BUFFER</text>
    <text x="57" y="42" fill="#ccfbf1" font-family="'Segoe UI', Arial" font-size="8" text-anchor="middle">TL072 Non-Inverting</text>
    <text x="57" y="55" fill="#ccfbf1" font-family="'Segoe UI', Arial" font-size="8" text-anchor="middle">Voltage Follower</text>
    <rect x="10" y="66" width="95" height="20" rx="3" fill="#134e4a"/>
    <text x="57" y="80" fill="#5eead4" font-family="monospace" font-size="7.5" font-weight="bold" text-anchor="middle">Zin &gt; 10¹² Ω | Av = 1</text>
  </g>

  <!-- Arrow 2 -->
  <line x1="280" y1="65" x2="302" y2="65" stroke="#1e3a8a" stroke-width="2.5" marker-end="url(#arrow)"/>
  <text x="291" y="56" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold" text-anchor="middle">V1(s)</text>

  <!-- Block 3: RLC Resonant Bandpass Core -->
  <g transform="translate(305, 12)">
    <rect width="155" height="107" rx="6" fill="#ffffff" stroke="#1e3a8a" stroke-width="2" stroke-dasharray="none"/>
    <rect x="0" y="0" width="155" height="24" rx="5" fill="url(#gradPurple)"/>
    <text x="77" y="16" fill="#ffffff" font-family="'Segoe UI', Arial" font-size="9.5" font-weight="bold" text-anchor="middle">RLC RESONANT TANK</text>
    <text x="77" y="40" fill="#334155" font-family="'Segoe UI', Arial" font-size="8" font-weight="600" text-anchor="middle">Series L-C + Shunt RL</text>
    <text x="77" y="54" fill="#64748b" font-family="'Segoe UI', Arial" font-size="7.5" text-anchor="middle">L=100mH | C=253nF | RL=240Ω</text>
    <rect x="8" y="63" width="139" height="38" rx="3" fill="#faf5ff" stroke="#d8b4fe" stroke-width="1"/>
    <text x="77" y="77" fill="#6b21a8" font-family="'Segoe UI', Arial" font-size="8" font-weight="bold" text-anchor="middle">fo = 1000 Hz | Q = 2.0</text>
    <text x="77" y="92" fill="#7e22ce" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="600" text-anchor="middle">Passband BW = 500 Hz</text>
  </g>

  <!-- Arrow 3 -->
  <line x1="460" y1="65" x2="482" y2="65" stroke="#1e3a8a" stroke-width="2.5" marker-end="url(#arrow)"/>
  <text x="471" y="56" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold" text-anchor="middle">V2(s)</text>

  <!-- Block 4: Output Buffer Stage -->
  <g transform="translate(485, 18)">
    <rect width="105" height="95" rx="5" fill="url(#gradCyan)" stroke="#0f766e" stroke-width="1.2"/>
    <text x="52" y="24" fill="#ffffff" font-family="'Segoe UI', Arial" font-size="9.5" font-weight="bold" text-anchor="middle">OUTPUT BUFFER</text>
    <text x="52" y="42" fill="#ccfbf1" font-family="'Segoe UI', Arial" font-size="8" text-anchor="middle">Impedance Isolation</text>
    <text x="52" y="55" fill="#ccfbf1" font-family="'Segoe UI', Arial" font-size="8" text-anchor="middle">TL072 Stage 2</text>
    <rect x="8" y="66" width="89" height="20" rx="3" fill="#134e4a"/>
    <text x="52" y="80" fill="#5eead4" font-family="monospace" font-size="7.5" font-weight="bold" text-anchor="middle">Zout &lt; 0.1 Ω</text>
  </g>

  <!-- Arrow 4 -->
  <line x1="590" y1="65" x2="612" y2="65" stroke="#1e3a8a" stroke-width="2.5" marker-end="url(#arrow)"/>
  <text x="601" y="56" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold" text-anchor="middle">Vout(t)</text>

  <!-- Block 5: Output Load & CRO -->
  <g transform="translate(615, 18)">
    <rect width="95" height="95" rx="5" fill="url(#gradAmber)" stroke="#b45309" stroke-width="1.2"/>
    <text x="47" y="24" fill="#ffffff" font-family="'Segoe UI', Arial" font-size="9.5" font-weight="bold" text-anchor="middle">OUTPUT SYSTEM</text>
    <text x="47" y="42" fill="#fef3c7" font-family="'Segoe UI', Arial" font-size="8" text-anchor="middle">DSO / CRO (CH2)</text>
    <text x="47" y="55" fill="#fef3c7" font-family="'Segoe UI', Arial" font-size="8" text-anchor="middle">Spectrum Display</text>
    <rect x="8" y="66" width="79" height="20" rx="3" fill="#78350f"/>
    <text x="47" y="80" fill="#fde68a" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold" text-anchor="middle">Audio Earphone</text>
  </g>
</svg>
'@
[System.IO.File]::WriteAllText("$docsDir\rlc_system_architecture.svg", $svgArch, [System.Text.Encoding]::UTF8)

# 2. Detailed Circuit Schematic SVG
$svgSchematic = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 220" width="100%" height="100%">
  <defs>
    <marker id="dot" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="4" markerHeight="4">
      <circle cx="5" cy="5" r="4" fill="#1e3a8a"/>
    </marker>
  </defs>

  <rect width="720" height="220" fill="#ffffff" rx="5" stroke="#cbd5e1" stroke-width="1.2"/>

  <!-- Title Badge -->
  <rect x="15" y="10" width="690" height="22" rx="3" fill="#1e3a8a"/>
  <text x="360" y="25" fill="#ffffff" font-family="'Segoe UI', Arial" font-size="10.5" font-weight="bold" text-anchor="middle">PBL PRECISION RLC AUDIO BANDPASS FILTER (fo = 1000 Hz, Q = 2.0, BW = 500 Hz)</text>

  <!-- Input Terminals -->
  <circle cx="45" cy="80" r="4" fill="none" stroke="#1e3a8a" stroke-width="2"/>
  <text x="45" y="70" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold" text-anchor="middle">Vin (+)</text>
  <line x1="49" y1="80" x2="85" y2="80" stroke="#1e3a8a" stroke-width="2"/>

  <!-- Test Point 1 -->
  <circle cx="85" cy="80" r="3.5" fill="#2563eb"/>
  <text x="85" y="68" fill="#2563eb" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold" text-anchor="middle">TP1 (In)</text>

  <!-- Resistor R1 (50 Ohm) -->
  <line x1="85" y1="80" x2="110" y2="80" stroke="#1e3a8a" stroke-width="2"/>
  <!-- Resistor Zigzag -->
  <path d="M 110 80 L 115 72 L 123 88 L 131 72 L 139 88 L 147 72 L 155 88 L 160 80" fill="none" stroke="#dc2626" stroke-width="2"/>
  <text x="135" y="65" fill="#dc2626" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold" text-anchor="middle">R1 = 50 Ω</text>
  <text x="135" y="100" fill="#64748b" font-family="'Segoe UI', Arial" font-size="7" text-anchor="middle">(Gen / Input Match)</text>
  <line x1="160" y1="80" x2="195" y2="80" stroke="#1e3a8a" stroke-width="2"/>

  <!-- Test Point 2 -->
  <circle cx="195" cy="80" r="3.5" fill="#2563eb"/>
  <text x="195" y="68" fill="#2563eb" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold" text-anchor="middle">TP2</text>

  <!-- Inductor L1 (100 mH) with Internal Rcoil -->
  <line x1="195" y1="80" x2="220" y2="80" stroke="#1e3a8a" stroke-width="2"/>
  <!-- Inductor Arcs -->
  <path d="M 220 80 A 7 7 0 0 1 234 80 A 7 7 0 0 1 248 80 A 7 7 0 0 1 262 80 A 7 7 0 0 1 276 80" fill="none" stroke="#7c3aed" stroke-width="2.2"/>
  <text x="248" y="65" fill="#7c3aed" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold" text-anchor="middle">L1 = 100 mH</text>

  <!-- Inductor Internal Resistance Box Rcoil -->
  <line x1="276" y1="80" x2="295" y2="80" stroke="#1e3a8a" stroke-width="2"/>
  <rect x="295" y="73" width="36" height="14" fill="#f5f3ff" stroke="#7c3aed" stroke-width="1.5"/>
  <text x="313" y="83.5" fill="#6d28d9" font-family="monospace" font-size="7.5" font-weight="bold" text-anchor="middle">24 Ω</text>
  <text x="313" y="100" fill="#64748b" font-family="'Segoe UI', Arial" font-size="7" text-anchor="middle">(Rcoil)</text>
  <line x1="331" y1="80" x2="365" y2="80" stroke="#1e3a8a" stroke-width="2"/>

  <!-- Capacitor C1 (253 nF: 220nF || 33nF) -->
  <line x1="365" y1="80" x2="390" y2="80" stroke="#1e3a8a" stroke-width="2"/>
  <!-- Capacitor Parallel Plates -->
  <line x1="390" y1="66" x2="390" y2="94" stroke="#0284c7" stroke-width="2.5"/>
  <line x1="397" y1="66" x2="397" y2="94" stroke="#0284c7" stroke-width="2.5"/>
  <line x1="397" y1="80" x2="435" y2="80" stroke="#1e3a8a" stroke-width="2"/>
  <text x="393.5" y="60" fill="#0284c7" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold" text-anchor="middle">C1 = 253 nF</text>
  <text x="393.5" y="106" fill="#64748b" font-family="'Segoe UI', Arial" font-size="7" text-anchor="middle">(220nF || 33nF Poly)</text>

  <!-- Resonant Node A / TP3 -->
  <circle cx="435" cy="80" r="4.5" fill="#1e3a8a"/>
  <text x="435" y="68" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold" text-anchor="middle">Node A (TP3)</text>

  <!-- Shunt Load Resistor RL = 240 Ohm to Ground -->
  <line x1="435" y1="80" x2="435" y2="105" stroke="#1e3a8a" stroke-width="2"/>
  <!-- Resistor Zigzag Vertical -->
  <path d="M 435 105 L 427 110 L 443 118 L 427 126 L 443 134 L 427 142 L 443 150 L 435 155" fill="none" stroke="#059669" stroke-width="2"/>
  <text x="458" y="128" fill="#059669" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold">RL = 240 Ω</text>
  <text x="458" y="139" fill="#64748b" font-family="'Segoe UI', Arial" font-size="7">(Audio Load)</text>
  <line x1="435" y1="155" x2="435" y2="180" stroke="#1e3a8a" stroke-width="2"/>

  <!-- Buffer Connection to Op-Amp TL072 -->
  <line x1="435" y1="80" x2="515" y2="80" stroke="#1e3a8a" stroke-width="2"/>

  <!-- TL072 Op-Amp Triangle -->
  <polygon points="515,60 515,115 570,87.5" fill="#f8fafc" stroke="#0f172a" stroke-width="2"/>
  <!-- Inputs: Pin 3 (+), Pin 2 (-) -->
  <text x="522" y="76" fill="#0f172a" font-family="monospace" font-size="11" font-weight="bold">+</text>
  <text x="522" y="103" fill="#0f172a" font-family="monospace" font-size="11" font-weight="bold">-</text>
  <text x="502" y="73" fill="#475569" font-family="'Segoe UI', Arial" font-size="7">Pin 3</text>
  <text x="502" y="107" fill="#475569" font-family="'Segoe UI', Arial" font-size="7">Pin 2</text>
  <!-- Power Pins: Pin 8 (+12V), Pin 4 (-12V) -->
  <line x1="535" y1="70" x2="535" y2="45" stroke="#ef4444" stroke-width="1.5"/>
  <text x="535" y="40" fill="#ef4444" font-family="'Segoe UI', Arial" font-size="7" font-weight="bold" text-anchor="middle">+12V (Pin 8)</text>
  <line x1="535" y1="105" x2="535" y2="130" stroke="#3b82f6" stroke-width="1.5"/>
  <text x="535" y="139" fill="#3b82f6" font-family="'Segoe UI', Arial" font-size="7" font-weight="bold" text-anchor="middle">-12V (Pin 4)</text>

  <!-- Buffer Feedback Loop (Output to Inverting Pin 2) -->
  <line x1="570" y1="87.5" x2="590" y2="87.5" stroke="#1e3a8a" stroke-width="2"/>
  <circle cx="590" cy="87.5" r="3.5" fill="#1e3a8a"/>
  <!-- Loop wire -->
  <path d="M 590 87.5 L 590 120 L 505 120 L 505 101 L 515 101" fill="none" stroke="#0f172a" stroke-width="1.6"/>
  <text x="550" y="117" fill="#475569" font-family="'Segoe UI', Arial" font-size="6.8" text-anchor="middle">100% Negative Feedback (Av = 1.0)</text>

  <!-- Output Test Point 4 -->
  <line x1="590" y1="87.5" x2="645" y2="87.5" stroke="#1e3a8a" stroke-width="2"/>
  <circle cx="645" cy="87.5" r="3.5" fill="#2563eb"/>
  <text x="645" y="75" fill="#2563eb" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold" text-anchor="middle">TP4 (Out)</text>

  <!-- Output Terminal -->
  <line x1="645" y1="87.5" x2="675" y2="87.5" stroke="#1e3a8a" stroke-width="2"/>
  <circle cx="675" cy="87.5" r="4" fill="none" stroke="#1e3a8a" stroke-width="2"/>
  <text x="675" y="76" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold" text-anchor="middle">Vout</text>
  <text x="675" y="103" fill="#64748b" font-family="'Segoe UI', Arial" font-size="7" text-anchor="middle">To DSO CH2</text>

  <!-- Ground Bus Line -->
  <line x1="45" y1="180" x2="675" y2="180" stroke="#1e3a8a" stroke-width="2"/>
  <!-- Input GND Terminal -->
  <line x1="45" y1="90" x2="45" y2="180" stroke="#1e3a8a" stroke-width="2"/>
  <circle cx="45" cy="180" r="4" fill="none" stroke="#1e3a8a" stroke-width="2"/>
  <text x="45" y="196" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="8" font-weight="bold" text-anchor="middle">GND In</text>
  <!-- Output GND Terminal -->
  <line x1="675" y1="95" x2="675" y2="180" stroke="#1e3a8a" stroke-width="2"/>
  <circle cx="675" cy="180" r="4" fill="none" stroke="#1e3a8a" stroke-width="2"/>
  <text x="675" y="196" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="8" font-weight="bold" text-anchor="middle">GND Out</text>

  <!-- Central Earth Ground Symbol -->
  <g transform="translate(360, 180)">
    <line x1="0" y1="0" x2="0" y2="15" stroke="#1e3a8a" stroke-width="2"/>
    <line x1="-15" y1="15" x2="15" y2="15" stroke="#1e3a8a" stroke-width="2.5"/>
    <line x1="-10" y1="19" x2="10" y2="19" stroke="#1e3a8a" stroke-width="2"/>
    <line x1="-5" y1="23" x2="5" y2="23" stroke="#1e3a8a" stroke-width="1.5"/>
    <text x="0" y="34" fill="#64748b" font-family="'Segoe UI', Arial" font-size="7" text-anchor="middle">SYSTEM GROUND (0V)</text>
  </g>
</svg>
'@
[System.IO.File]::WriteAllText("$docsDir\rlc_filter_schematic.svg", $svgSchematic, [System.Text.Encoding]::UTF8)

# 3. S-Plane Pole-Zero Diagram SVG
$svgSplane = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 210" width="100%" height="100%">
  <rect width="340" height="210" fill="#ffffff" rx="4" stroke="#cbd5e1" stroke-width="1"/>
  <!-- Left Half Plane Shading (Stable Region) -->
  <rect x="15" y="15" width="150" height="180" fill="#f0fdf4" opacity="0.8"/>
  <text x="80" y="32" fill="#15803d" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold">STABLE REGION (LHP)</text>

  <!-- Axes -->
  <line x1="15" y1="105" x2="320" y2="105" stroke="#334155" stroke-width="1.5"/>
  <line x1="165" y1="15" x2="165" y2="195" stroke="#334155" stroke-width="1.5"/>
  <text x="315" y="100" fill="#334155" font-family="'Segoe UI', Arial" font-size="8" font-weight="bold">σ</text>
  <text x="170" y="25" fill="#334155" font-family="'Segoe UI', Arial" font-size="8" font-weight="bold">jω</text>

  <!-- Origin Zero (o) -->
  <circle cx="165" cy="105" r="4.5" fill="none" stroke="#2563eb" stroke-width="2"/>
  <text x="175" y="117" fill="#2563eb" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold">s = 0 (Zero)</text>

  <!-- Complex Poles (x) at -alpha +/- j*omega_d -->
  <!-- alpha = 1570.8 -> x = 165 - 45 = 120 -->
  <!-- omega_d = 6083.7 -> y = 105 - 55 = 50 and 105 + 55 = 160 -->
  <!-- Grid dashed lines -->
  <line x1="120" y1="50" x2="120" y2="160" stroke="#94a3b8" stroke-width="1" stroke-dasharray="2,2"/>
  <line x1="120" y1="50" x2="165" y2="50" stroke="#94a3b8" stroke-width="1" stroke-dasharray="2,2"/>
  <line x1="120" y1="160" x2="165" y2="160" stroke="#94a3b8" stroke-width="1" stroke-dasharray="2,2"/>

  <!-- Radial line omega_n -->
  <line x1="165" y1="105" x2="120" y2="50" stroke="#7c3aed" stroke-width="1.2" stroke-dasharray="3,2"/>
  <text x="135" y="73" fill="#7c3aed" font-family="'Segoe UI', Arial" font-size="7" font-weight="bold">ωn</text>

  <!-- Pole 1 (x) -->
  <g transform="translate(120, 50)">
    <line x1="-5" y1="-5" x2="5" y2="5" stroke="#dc2626" stroke-width="2.5"/>
    <line x1="-5" y1="5" x2="5" y2="-5" stroke="#dc2626" stroke-width="2.5"/>
  </g>
  <text x="25" y="48" fill="#dc2626" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold">s₁ = -1571 + j6084</text>

  <!-- Pole 2 (x) -->
  <g transform="translate(120, 160)">
    <line x1="-5" y1="-5" x2="5" y2="5" stroke="#dc2626" stroke-width="2.5"/>
    <line x1="-5" y1="5" x2="5" y2="-5" stroke="#dc2626" stroke-width="2.5"/>
  </g>
  <text x="25" y="165" fill="#dc2626" font-family="'Segoe UI', Arial" font-size="7.5" font-weight="bold">s₂ = -1571 - j6084</text>

  <!-- Labels on axes -->
  <text x="120" y="117" fill="#475569" font-family="'Segoe UI', Arial" font-size="7" text-anchor="middle">-α = -1571</text>
  <text x="170" y="53" fill="#475569" font-family="'Segoe UI', Arial" font-size="7">+jωd = +6084</text>
  <text x="170" y="163" fill="#475569" font-family="'Segoe UI', Arial" font-size="7">-jωd = -6084</text>

  <rect x="200" y="135" width="130" height="58" rx="3" fill="#f8fafc" stroke="#cbd5e1" stroke-width="1"/>
  <text x="205" y="148" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="7" font-weight="bold">Pole Locations &amp; Damping:</text>
  <text x="205" y="160" fill="#475569" font-family="'Segoe UI', Arial" font-size="6.8">• ζ = 0.25 (Underdamped)</text>
  <text x="205" y="172" fill="#475569" font-family="'Segoe UI', Arial" font-size="6.8">• ωn = 6283.2 rad/s</text>
  <text x="205" y="184" fill="#475569" font-family="'Segoe UI', Arial" font-size="6.8">• θ = 75.52° (arccos ζ)</text>
</svg>
'@
[System.IO.File]::WriteAllText("$docsDir\rlc_s_plane_pole_zero.svg", $svgSplane, [System.Text.Encoding]::UTF8)

# 4. Bode Frequency Response Diagram SVG
$svgBode = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 210" width="100%" height="100%">
  <rect width="340" height="210" fill="#ffffff" rx="4" stroke="#cbd5e1" stroke-width="1"/>

  <!-- Title -->
  <text x="170" y="18" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold" text-anchor="middle">BODE MAGNITUDE RESPONSE | fo = 1 kHz, BW = 500 Hz</text>

  <!-- Plot Area Frame: x: 38 to 325, y: 28 to 180 -->
  <rect x="38" y="28" width="287" height="152" fill="#fafafa" stroke="#94a3b8" stroke-width="1"/>

  <!-- Horizontal Grid Lines (-30, -20, -10, -5.35, -2.34, 0 dB) -->
  <!-- y mapping: 0dB -> 32, -10dB -> 75, -20dB -> 118, -30dB -> 161 -->
  <line x1="38" y1="32" x2="325" y2="32" stroke="#e2e8f0" stroke-width="1"/>
  <text x="34" y="35" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="end">0 dB</text>

  <line x1="38" y1="75" x2="325" y2="75" stroke="#e2e8f0" stroke-width="1"/>
  <text x="34" y="78" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="end">-10</text>

  <line x1="38" y1="118" x2="325" y2="118" stroke="#e2e8f0" stroke-width="1"/>
  <text x="34" y="121" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="end">-20</text>

  <line x1="38" y1="161" x2="325" y2="161" stroke="#e2e8f0" stroke-width="1"/>
  <text x="34" y="164" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="end">-30</text>

  <!-- Vertical Freq Log Lines: 10Hz, 100Hz, 1kHz, 10kHz, 100kHz -->
  <!-- x coordinates: 10Hz->38, 100Hz->109, 1kHz->181, 10kHz->253, 100kHz->325 -->
  <line x1="109" y1="28" x2="109" y2="180" stroke="#e2e8f0" stroke-width="1"/>
  <line x1="181" y1="28" x2="181" y2="180" stroke="#cbd5e1" stroke-width="1.2"/>
  <line x1="253" y1="28" x2="253" y2="180" stroke="#e2e8f0" stroke-width="1"/>

  <text x="38" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">10 Hz</text>
  <text x="109" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">100 Hz</text>
  <text x="181" y="193" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="7" font-weight="bold" text-anchor="middle">1 kHz</text>
  <text x="253" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">10 kHz</text>
  <text x="325" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">100k</text>

  <!-- Shaded Passband: f1=781Hz (x=174) to f2=1281Hz (x=188) -->
  <rect x="172" y="28" width="19" height="152" fill="#dbeafe" opacity="0.6"/>

  <!-- -3dB Level Line: -2.34 - 3.01 = -5.35 dB -> y = 55 -->
  <line x1="38" y1="55" x2="325" y2="55" stroke="#ef4444" stroke-width="1" stroke-dasharray="3,2"/>
  <text x="290" y="51" fill="#ef4444" font-family="'Segoe UI', Arial" font-size="6.5" font-weight="bold">-3 dB Level</text>

  <!-- Bode Curve -->
  <!-- 20Hz: -32dB(169), 100Hz: -18.5dB(111), 300Hz: -9.3dB(72), 781Hz: -5.35dB(55), 1kHz: -2.34dB(42), 1281Hz: -5.35dB(55), 3kHz: -9.3dB(72), 10kHz: -22.4dB(128), 20kHz: -28.4dB(154) -->
  <path d="M 38 178 C 75 160, 109 112, 145 78 C 160 64, 172 55, 181 42 C 190 55, 202 64, 217 78 C 253 112, 287 155, 325 178" fill="none" stroke="#2563eb" stroke-width="2.5"/>

  <!-- Peak Marker at 1 kHz -->
  <circle cx="181" cy="42" r="3.5" fill="#dc2626"/>
  <text x="181" y="38" fill="#dc2626" font-family="'Segoe UI', Arial" font-size="7" font-weight="bold" text-anchor="middle">fo = 1.0 kHz (-2.3 dB)</text>

  <!-- Cutoff Markers -->
  <circle cx="172" cy="55" r="2.5" fill="#ef4444"/>
  <circle cx="191" cy="55" r="2.5" fill="#ef4444"/>

  <!-- Bandwidth Callout -->
  <line x1="172" y1="85" x2="191" y2="85" stroke="#1e3a8a" stroke-width="1.5"/>
  <polyline points="175,82 172,85 175,88" fill="none" stroke="#1e3a8a" stroke-width="1.5"/>
  <polyline points="188,82 191,85 188,88" fill="none" stroke="#1e3a8a" stroke-width="1.5"/>
  <text x="181.5" y="97" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="6.8" font-weight="bold" text-anchor="middle">BW = 500 Hz</text>

  <!-- Slopes -->
  <text x="80" y="145" fill="#059669" font-family="'Segoe UI', Arial" font-size="6.5" font-weight="bold">+20 dB/dec</text>
  <text x="260" y="145" fill="#059669" font-family="'Segoe UI', Arial" font-size="6.5" font-weight="bold">-20 dB/dec</text>
</svg>
'@
[System.IO.File]::WriteAllText("$docsDir\rlc_bode_response.svg", $svgBode, [System.Text.Encoding]::UTF8)

# 5. Transient Step Response Diagram SVG
$svgTransient = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 210" width="100%" height="100%">
  <rect width="340" height="210" fill="#ffffff" rx="4" stroke="#cbd5e1" stroke-width="1"/>

  <!-- Title -->
  <text x="170" y="18" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="8.5" font-weight="bold" text-anchor="middle">STEP TRANSIENT RESPONSE | ζ = 0.25 (UNDERDAMPED)</text>

  <!-- Plot Area Frame: x: 38 to 325, y: 28 to 180 -->
  <rect x="38" y="28" width="287" height="152" fill="#fafafa" stroke="#94a3b8" stroke-width="1"/>

  <!-- Zero baseline: y = 104 -->
  <line x1="38" y1="104" x2="325" y2="104" stroke="#64748b" stroke-width="1.2"/>
  <text x="34" y="107" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="end">0 V</text>

  <line x1="38" y1="45" x2="325" y2="45" stroke="#e2e8f0" stroke-width="1"/>
  <text x="34" y="48" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="end">+0.5V</text>

  <line x1="38" y1="163" x2="325" y2="163" stroke="#e2e8f0" stroke-width="1"/>
  <text x="34" y="166" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="end">-0.5V</text>

  <!-- Time markers: 0ms -> 38, 1ms -> 95, 2ms -> 152, 3ms -> 209, 4ms -> 266, 5ms -> 323 -->
  <line x1="95" y1="28" x2="95" y2="180" stroke="#e2e8f0" stroke-width="1"/>
  <line x1="152" y1="28" x2="152" y2="180" stroke="#e2e8f0" stroke-width="1"/>
  <line x1="209" y1="28" x2="209" y2="180" stroke="#e2e8f0" stroke-width="1"/>
  <line x1="266" y1="28" x2="266" y2="180" stroke="#e2e8f0" stroke-width="1"/>

  <text x="38" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">0 ms</text>
  <text x="95" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">1 ms</text>
  <text x="152" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">2 ms</text>
  <text x="209" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">3 ms</text>
  <text x="266" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">4 ms</text>
  <text x="323" y="193" fill="#64748b" font-family="'Segoe UI', Arial" font-size="6.5" text-anchor="middle">5 ms</text>

  <!-- Exponential Decay Envelope (dashed red) -->
  <path d="M 38 45 Q 95 62, 152 82 T 266 100 T 325 104" fill="none" stroke="#ef4444" stroke-width="1.2" stroke-dasharray="3,2"/>
  <path d="M 38 163 Q 95 146, 152 126 T 266 108 T 325 104" fill="none" stroke="#ef4444" stroke-width="1.2" stroke-dasharray="3,2"/>
  <text x="220" y="78" fill="#ef4444" font-family="'Segoe UI', Arial" font-size="6.5" font-weight="bold">Envelope ±e^(-αt)</text>

  <!-- Underdamped Oscillatory Waveform vout(t) = V0/wdL * exp(-at) * sin(wd*t) -->
  <!-- wd = 6084 rad/s -> fd = 968 Hz -> Td ~ 1.03 ms -> 59 pixels per cycle -->
  <path d="M 38 104 
           C 48 48, 62 48, 67 104 
           C 72 145, 88 145, 96 104 
           C 105 75, 117 75, 125 104 
           C 133 125, 145 125, 154 104 
           C 162 90, 174 90, 183 104 
           C 192 114, 204 114, 212 104 
           C 220 98, 232 98, 241 104 
           C 250 108, 262 108, 270 104 
           L 325 104" 
        fill="none" stroke="#7c3aed" stroke-width="2.2"/>

  <!-- Settling Time Indicator (ts = 4/alpha = 2.55 ms -> x = 183) -->
  <line x1="183" y1="28" x2="183" y2="180" stroke="#059669" stroke-width="1.2" stroke-dasharray="2,2"/>
  <text x="183" y="38" fill="#059669" font-family="'Segoe UI', Arial" font-size="6.8" font-weight="bold" text-anchor="middle">ts = 2.55 ms</text>

  <rect x="45" y="138" width="125" height="38" rx="2" fill="#ffffff" stroke="#cbd5e1" stroke-width="0.8"/>
  <text x="50" y="149" fill="#1e3a8a" font-family="'Segoe UI', Arial" font-size="6.8" font-weight="bold">Transient Parameters:</text>
  <text x="50" y="159" fill="#475569" font-family="'Segoe UI', Arial" font-size="6.5">• α = 1570.8 s⁻¹ (Damping)</text>
  <text x="50" y="169" fill="#475569" font-family="'Segoe UI', Arial" font-size="6.5">• Td = 1.033 ms (Period)</text>
</svg>
'@
[System.IO.File]::WriteAllText("$docsDir\rlc_transient_response.svg", $svgTransient, [System.Text.Encoding]::UTF8)

Write-Host "All 5 vector SVGs successfully generated in $docsDir"

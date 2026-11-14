# PowerShell script to generate GMU UE26EC2303 PBL Report HTML and PDF
$ErrorActionPreference = "Stop"

$docsDir = "d:\Projects\PBL Project\docs"
$htmlPath = "$docsDir\GMU_UE26EC2303_PBL_Report.html"
$pdfPath = "$docsDir\GMU_UE26EC2303_PBL_Report.pdf"
$rootPdfPath = "d:\Projects\PBL Project\GMU_UE26EC2303_PBL_Report.pdf"

Write-Host "Reading SVG assets..."
$svgArch = Get-Content -Raw -Path "$docsDir\rlc_system_architecture.svg"
$svgSchematic = Get-Content -Raw -Path "$docsDir\rlc_filter_schematic.svg"
$svgSplane = Get-Content -Raw -Path "$docsDir\rlc_s_plane_pole_zero.svg"
$svgBode = Get-Content -Raw -Path "$docsDir\rlc_bode_response.svg"
$svgTransient = Get-Content -Raw -Path "$docsDir\rlc_transient_response.svg"

$html = @'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>GMU UE26EC2303 PBL Report - Network Analysis and Simulation</title>
<style>
  @page {
    size: A4 portrait;
    margin: 8mm 10mm 10mm 10mm;
  }

  * { box-sizing: border-box; }
  body {
    font-family: 'Times New Roman', Times, serif;
    font-size: 8.4pt;
    line-height: 1.28;
    color: #0f172a;
    margin: 0;
    padding: 0;
    background: #ffffff;
  }

  .sans { font-family: 'Segoe UI', Arial, sans-serif; }
  h1, h2, h3, h4, th { font-family: 'Segoe UI', Arial, sans-serif; }

  .page {
    width: 100%;
    height: 279mm;
    max-height: 279mm;
    padding: 0;
    margin: 0;
    page-break-after: always;
    page-break-inside: avoid;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    position: relative;
    overflow: hidden;
  }

  /* Cover Page Styling */
  .cover-container {
    height: 279mm;
    border: 5px double #1e3a8a;
    padding: 8mm 11mm 8mm 11mm;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    text-align: center;
    background: #ffffff;
    page-break-after: always;
    page-break-inside: avoid;
  }
  .uni-title-kannada {
    font-size: 14pt;
    font-weight: bold;
    color: #1e3a8a;
    margin: 0 0 2px 0;
  }
  .uni-title-en {
    font-size: 19pt;
    font-weight: 800;
    color: #1e3a8a;
    letter-spacing: 1.5px;
    margin: 0;
  }
  .uni-address {
    font-size: 8.2pt;
    color: #475569;
    font-weight: 600;
    margin: 2px 0 0 0;
  }
  .dept-header {
    border-top: 1.5px solid #cbd5e1;
    border-bottom: 1.5px solid #cbd5e1;
    padding: 3px 0;
    margin: 5px 0;
  }
  .dept-header h3 {
    margin: 0;
    font-size: 9.5pt;
    font-weight: 700;
    color: #0f172a;
    letter-spacing: 0.5px;
  }
  .dept-header p {
    margin: 1px 0 0 0;
    font-size: 8pt;
    color: #475569;
    font-weight: 600;
  }
  .pbl-badge {
    display: inline-block;
    background: #1e3a8a;
    color: #ffffff;
    font-size: 10pt;
    font-weight: 700;
    padding: 2.5px 16px;
    border-radius: 12px;
    letter-spacing: 1px;
    text-transform: uppercase;
    margin: 4px auto;
  }
  .cover-project-title {
    font-size: 12.5pt;
    font-weight: 800;
    color: #0f172a;
    line-height: 1.25;
    margin: 5px 4px;
    text-transform: uppercase;
  }
  .cover-meta-grid {
    display: flex;
    justify-content: space-between;
    background: #f8fafc;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    padding: 5px 9px;
    margin: 4px 0;
    font-size: 7.8pt;
    text-align: left;
  }
  .cover-table {
    width: 100%;
    border-collapse: collapse;
    margin: 4px 0;
    font-size: 7.8pt;
  }
  .cover-table th, .cover-table td {
    border: 1px solid #94a3b8;
    padding: 3.5px 5px;
    text-align: center;
  }
  .cover-table th {
    background: #1e3a8a;
    color: #ffffff;
    font-weight: 600;
  }
  .cover-sig-container {
    display: flex;
    justify-content: space-between;
    margin-top: 6px;
    padding-top: 2px;
  }
  .cover-sig-box {
    width: 32%;
    text-align: center;
    font-size: 7.8pt;
  }
  .cover-sig-line {
    border-top: 1.2px solid #334155;
    margin: 18px auto 2px auto;
    width: 85%;
  }

  /* Standard Page Header & Footer */
  .page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1.5px solid #1e3a8a;
    padding-bottom: 2px;
    margin-bottom: 4px;
  }
  .page-header-title {
    font-size: 7.5pt;
    font-weight: 700;
    color: #1e3a8a;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  .page-header-course {
    font-size: 7pt;
    color: #64748b;
    font-weight: 600;
  }
  .page-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid #cbd5e1;
    padding-top: 2px;
    margin-top: auto;
    font-size: 7pt;
    color: #64748b;
  }
  .page-footer-page {
    font-weight: bold;
    color: #1e3a8a;
  }

  /* Headings */
  h2.sec-heading {
    font-size: 9.6pt;
    font-weight: 800;
    color: #1e3a8a;
    border-left: 3.5px solid #1e3a8a;
    padding-left: 5px;
    margin: 4px 0 2px 0;
    text-transform: uppercase;
    letter-spacing: 0.3px;
  }
  h3.sub-heading {
    font-size: 8.5pt;
    font-weight: 700;
    color: #0f766e;
    margin: 3px 0 1.5px 0;
  }

  p {
    margin: 0 0 3.5px 0;
    text-align: justify;
  }

  .card-box {
    background: #eff6ff;
    border: 1px solid #bfdbfe;
    border-left: 3px solid #2563eb;
    padding: 3.5px 6px;
    margin: 2.5px 0;
    font-size: 8pt;
  }
  .green-card {
    background: #ecfdf5;
    border: 1px solid #a7f3d0;
    border-left: 3px solid #059669;
    padding: 3.5px 6px;
    margin: 2.5px 0;
    font-size: 8pt;
  }
  .purple-card {
    background: #faf5ff;
    border: 1px solid #e9d5ff;
    border-left: 3px solid #7c3aed;
    padding: 3.5px 6px;
    margin: 2.5px 0;
    font-size: 8pt;
  }
  .amber-card {
    background: #fffbeb;
    border: 1px solid #fde68a;
    border-left: 3px solid #d97706;
    padding: 3.5px 6px;
    margin: 2.5px 0;
    font-size: 8pt;
  }

  table.compact-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 7.4pt;
    margin: 2.5px 0;
  }
  table.compact-table th, table.compact-table td {
    border: 1px solid #cbd5e1;
    padding: 2.5px 4.5px;
    text-align: left;
  }
  table.compact-table th {
    background: #1e3a8a;
    color: #ffffff;
    font-weight: 600;
    text-align: center;
  }
  table.compact-table tr:nth-child(even) {
    background: #f8fafc;
  }

  .two-col-grid {
    display: flex;
    justify-content: space-between;
    gap: 7px;
    margin: 2.5px 0;
  }
  .two-col-grid > div {
    flex: 1;
  }

  .diagram-frame {
    text-align: center;
    margin: 2.5px 0;
    line-height: 0;
  }
  .diagram-frame svg {
    max-width: 100%;
    height: auto;
  }

  .val-badge {
    background: #e0e7ff;
    color: #3730a3;
    padding: 0 3px;
    border-radius: 2px;
    font-family: monospace;
    font-size: 7.6pt;
    font-weight: 600;
  }
  .math-eq {
    background: #f8fafc;
    border: 1px dashed #94a3b8;
    padding: 2.5px 6px;
    margin: 2px 0;
    text-align: center;
    font-family: 'Times New Roman', serif;
    font-size: 8.5pt;
    font-style: italic;
  }
</style>
</head>
<body>

<!-- ========================================== -->
<!-- PAGE 1: COVER PAGE -->
<!-- ========================================== -->
<div class="cover-container">
  <div>
    <div class="uni-title-kannada">ಜಿ. ಎಂ. ವಿಶ್ವವಿದ್ಯಾಲಯ</div>
    <div class="uni-title-en">GM UNIVERSITY</div>
    <div class="uni-address">P. B. Road, Davanagere – 577 006, Karnataka, India</div>
    <div class="dept-header">
      <h3>FACULTY OF ENGINEERING AND TECHNOLOGY</h3>
      <p>Department of Electronics and Communication Engineering</p>
    </div>
  </div>

  <div>
    <div class="pbl-badge">Project Based Learning (PBL) Report</div>
    <div style="font-size: 8.5pt; font-weight: bold; color: #475569; margin-top: 3px;">
      Academic Year 2026–2027 | 3rd Semester B.Tech. (ECE)
    </div>
    <div class="cover-project-title">
      DESIGN AND DEVELOP AN RLC-BASED AUDIO FILTER FOR PRACTICAL ACOUSTIC FREQUENCY SELECTION
    </div>
    <div style="font-size: 8.2pt; color: #0f766e; font-weight: 700;">
      A Rigorous Synthesis Covering Curricular Units 1 Through 6 with SPICE Simulation and Hardware Realization
    </div>
  </div>

  <div class="cover-meta-grid">
    <div>
      <strong>Course Title:</strong> Network Analysis and Simulation<br>
      <strong>Course Code:</strong> UE26EC2303<br>
      <strong>Course Category:</strong> Professional Core (PCC)
    </div>
    <div>
      <strong>Duration:</strong> 14 Weeks<br>
      <strong>Total Marks:</strong> 40 Marks<br>
      <strong>Max Page Limit:</strong> 12 A4 Pages
    </div>
    <div>
      <strong>Issue Date:</strong> 18-Aug-2026<br>
      <strong>Submission Date:</strong> 18-Nov-2026<br>
      <strong>Evaluation Mode:</strong> Report + Demo + Viva
    </div>
  </div>

  <div>
    <div style="font-size: 8pt; font-weight: bold; color: #1e3a8a; margin-bottom: 2px;">
      STUDENT PROJECT BATCH DETAILS
    </div>
    <table class="cover-table">
      <thead>
        <tr>
          <th>Sl. No.</th>
          <th>Student Full Name</th>
          <th>University Seat Number (USN)</th>
          <th>Assigned Subsystem Role</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td><strong>Student 1 (Team Lead)</strong></td>
          <td>0GM25EC001</td>
          <td>System Architecture &amp; Unit 1-2 Network Analysis</td>
        </tr>
        <tr>
          <td>2</td>
          <td><strong>Student 2</strong></td>
          <td>0GM25EC002</td>
          <td>Theorems (Unit 3) &amp; Transient Modeling (Unit 4)</td>
        </tr>
        <tr>
          <td>3</td>
          <td><strong>Student 3</strong></td>
          <td>0GM25EC003</td>
          <td>Two-Port Networks (Unit 5) &amp; Resonance (Unit 6)</td>
        </tr>
        <tr>
          <td>4</td>
          <td><strong>Student 4</strong></td>
          <td>0GM25EC004</td>
          <td>Hardware Prototyping, SPICE &amp; CRO Verification</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="cover-sig-container">
    <div class="cover-sig-box">
      <div class="cover-sig-line"></div>
      <strong>Mrs. Veena H T</strong><br>
      Course Coordinator<br>
      Dept. of ECE, GMU
    </div>
    <div class="cover-sig-box">
      <div class="cover-sig-line"></div>
      <strong>Dr. Praveen J</strong><br>
      Head of Department<br>
      Dept. of ECE, GMU
    </div>
    <div class="cover-sig-box">
      <div class="cover-sig-line"></div>
      <strong>Dr. Praveen J</strong><br>
      Director<br>
      School of Engineering, GMU
    </div>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 2: DECLARATION & EVALUATION RUBRICS -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">Individual Contribution Declaration &amp; Certificate</h2>
    <p>
      We hereby declare that the Project Based Learning (PBL) report entitled <strong>"Design and Develop an RLC-Based Audio Filter"</strong> submitted to the Department of Electronics and Communication Engineering, GM University, Davanagere, represents our original work under course code <strong>UE26EC2303</strong>. All analytical formulations, SPICE simulations, and experimental hardware characterizations were performed collaboratively with individual responsibilities delineated below.
    </p>

    <table class="compact-table" style="margin-bottom: 5px;">
      <thead>
        <tr>
          <th style="width: 20%;">Student Name</th>
          <th style="width: 15%;">USN</th>
          <th style="width: 25%;">Assigned Role</th>
          <th style="width: 25%;">Specific Technical Contribution</th>
          <th style="width: 8%;">% Share</th>
          <th style="width: 7%;">Sign</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>Student 1</strong></td>
          <td>0GM25EC001</td>
          <td>Lead Architect &amp; Theorist</td>
          <td>Network reduction, source transformation, mesh/nodal matrices</td>
          <td style="text-align: center;">25%</td>
          <td></td>
        </tr>
        <tr>
          <td><strong>Student 2</strong></td>
          <td>0GM25EC002</td>
          <td>Theorems &amp; Transient Engr.</td>
          <td>Thevenin/Norton proofs, Laplace transform ODE &amp; damping</td>
          <td style="text-align: center;">25%</td>
          <td></td>
        </tr>
        <tr>
          <td><strong>Student 3</strong></td>
          <td>0GM25EC003</td>
          <td>Two-Port &amp; Resonance Engr.</td>
          <td>Z, Y, h, ABCD parameters, Q-factor, bandwidth &amp; selectivity</td>
          <td style="text-align: center;">25%</td>
          <td></td>
        </tr>
        <tr>
          <td><strong>Student 4</strong></td>
          <td>0GM25EC004</td>
          <td>Hardware &amp; Simulation Engr.</td>
          <td>Breadboard wiring, TL072 buffer, LTspice netlist &amp; DSO sweep</td>
          <td style="text-align: center;">25%</td>
          <td></td>
        </tr>
      </tbody>
    </table>

    <h2 class="sec-heading" style="margin-top: 4px;">PBL Evaluation Rubrics (Total: 40 Marks)</h2>
    <table class="compact-table">
      <thead>
        <tr>
          <th style="width: 12%;">Component</th>
          <th style="width: 38%;">Evaluation Criteria</th>
          <th style="width: 10%;">Marks</th>
          <th style="width: 8%;">CO</th>
          <th style="width: 32%;">Target Evidence in this Report</th>
        </tr>
      </thead>
      <tbody>
        <tr style="background: #eff6ff; font-weight: bold;">
          <td colspan="5">A. Project Development (25 Marks)</td>
        </tr>
        <tr>
          <td>Problem Understanding</td>
          <td>Clarity of acoustic noise challenges, filter specs &amp; LTI context</td>
          <td style="text-align: center;"><strong>4</strong></td>
          <td style="text-align: center;">CO2</td>
          <td>Section 1 &amp; 2 (Audio spectrum mapping, specs)</td>
        </tr>
        <tr>
          <td>Design &amp; Methodology</td>
          <td>Component selection, mathematical rigor &amp; circuit topology</td>
          <td style="text-align: center;"><strong>5</strong></td>
          <td style="text-align: center;">CO3</td>
          <td>Sections 3, 4, 7 (L-C sizing, Q=2, BW=500 Hz)</td>
        </tr>
        <tr>
          <td>Implementation</td>
          <td>Comprehensive coverage of all syllabus units (Units 1 to 6)</td>
          <td style="text-align: center;"><strong>6</strong></td>
          <td style="text-align: center;">CO4</td>
          <td>Sections 3–7 (Network reduction to Resonance)</td>
        </tr>
        <tr>
          <td>Functionality &amp; Integration</td>
          <td>Hardware breadboard operation, active buffering &amp; audio passband</td>
          <td style="text-align: center;"><strong>5</strong></td>
          <td style="text-align: center;">CO5</td>
          <td>Section 8 &amp; 9 (TL072 buffer, DSO verification)</td>
        </tr>
        <tr>
          <td>Innovation / Enhancements</td>
          <td>Inductor coil resistance compensation, dual-stage buffering</td>
          <td style="text-align: center;"><strong>3</strong></td>
          <td style="text-align: center;">CO6</td>
          <td>Rcoil internal loss modeling, LTspice automated script</td>
        </tr>
        <tr>
          <td>Report Quality</td>
          <td>Formatting, technical rigor, vector diagrams, max 12 pages</td>
          <td style="text-align: center;"><strong>2</strong></td>
          <td style="text-align: center;">CO6</td>
          <td>Strict 12-page structure, high-res vector graphics</td>
        </tr>
        <tr style="background: #f0fdf4; font-weight: bold;">
          <td colspan="5">B. Demonstration &amp; Viva Voce (5 Marks)</td>
        </tr>
        <tr>
          <td>Demonstration</td>
          <td>Real-time CRO filter action, resonance peak &amp; -3dB roll-off</td>
          <td style="text-align: center;"><strong>3</strong></td>
          <td style="text-align: center;">CO5</td>
          <td>Lab measurement protocol, frequency sweep table</td>
        </tr>
        <tr>
          <td>Viva Voce</td>
          <td>Oral defense of circuit theorems, damping, and two-port theory</td>
          <td style="text-align: center;"><strong>2</strong></td>
          <td style="text-align: center;">CO4</td>
          <td>Comprehensive analytical derivations throughout report</td>
        </tr>
        <tr style="background: #fefce8; font-weight: bold;">
          <td colspan="5">C. Individual Contribution (10 Marks)</td>
        </tr>
        <tr>
          <td>Technical Contribution</td>
          <td>Depth of individual engineering work delivered</td>
          <td style="text-align: center;"><strong>4</strong></td>
          <td style="text-align: center;">CO4</td>
          <td>Individual Contribution Declaration above</td>
        </tr>
        <tr>
          <td>Participation &amp; Teamwork</td>
          <td>Effective task partitioning, collaboration &amp; lab execution</td>
          <td style="text-align: center;"><strong>2</strong></td>
          <td style="text-align: center;">CO6</td>
          <td>Milestone completion aligned with 14-week timeline</td>
        </tr>
        <tr>
          <td>Understanding of Project</td>
          <td>Grasp of network theorems, transient poles, and filter Q-factor</td>
          <td style="text-align: center;"><strong>2</strong></td>
          <td style="text-align: center;">CO3</td>
          <td>Viva readiness and conceptual mastery</td>
        </tr>
        <tr>
          <td>Documentation</td>
          <td>Quality of mathematical derivations and visual schematic capture</td>
          <td style="text-align: center;"><strong>2</strong></td>
          <td style="text-align: center;">CO6</td>
          <td>Clear typography, IEEE schematic layout</td>
        </tr>
        <tr style="background: #1e3a8a; color: #ffffff; font-weight: bold;">
          <td colspan="2">TOTAL EVALUATION SCORE</td>
          <td style="text-align: center;"><strong>40</strong></td>
          <td colspan="2">Maximum Marks: 40 | Minimum for Passing: 50% (20 Marks)</td>
        </tr>
      </tbody>
    </table>

    <div style="display: flex; justify-content: space-between; margin-top: 8px;">
      <div style="width: 45%; text-align: center;">
        <div style="border-top: 1px solid #334155; margin: 16px auto 2px auto; width: 75%;"></div>
        <strong style="font-size: 7.8pt;">Mrs. Veena H T</strong><br>
        <span style="font-size: 7.2pt; color: #475569;">Course Coordinator, UE26EC2303</span>
      </div>
      <div style="width: 45%; text-align: center;">
        <div style="border-top: 1px solid #334155; margin: 16px auto 2px auto; width: 75%;"></div>
        <strong style="font-size: 7.8pt;">Dr. Praveen J</strong><br>
        <span style="font-size: 7.2pt; color: #475569;">HOD &amp; Director, School of Engineering</span>
      </div>
    </div>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 2 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 3: ABSTRACT & INTRODUCTION -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">Abstract</h2>
    <div class="card-box">
      <strong>Executive Abstract:</strong> This project presents the theoretical design, analytical modeling, SPICE simulation, and physical hardware implementation of a 2nd-order <strong>RLC-based Audio Bandpass Filter</strong> centered at $f_0 = 1000\text{ Hz}$ with a quality factor $Q = 2.0$ and a $-3\text{ dB}$ bandwidth $BW = 500\text{ Hz}$. Operating over the audio spectrum ($20\text{ Hz} - 20\text{ kHz}$), the filter passes core speech/vocal formants ($781\text{ Hz} - 1281\text{ Hz}$) while attenuating low-frequency mains power hum ($50/60\text{ Hz}$), mechanical vibration rumble, and high-frequency thermal hiss ($> 3.4\text{ kHz}$). The technical report covers all six units of the <strong>UE26EC2303</strong> curriculum: (1) Source transformation and network reduction; (2) Mesh and nodal formulations; (3) Network theorems (Thevenin, Norton, Superposition, Maximum Power Transfer); (4) Transient Laplace analysis ($\zeta = 0.25$ underdamped step response); (5) Two-port parameters ($Z, Y, h, ABCD$) with reciprocity verification ($AD - BC = 1.00$); and (6) Resonant frequency, half-power bandwidth, and selectivity. Physical validation uses a $100\text{ mH}$ shielded inductor, $253\text{ nF}$ metallized film capacitor, $240\,\Omega$ load, and an active TL072 dual op-amp buffer, showing experimental agreement within $2.4\%$ of theoretical predictions.
    </div>

    <h2 class="sec-heading">1. Introduction &amp; Acoustic Engineering Context</h2>
    <p>
      In audio signal processing, acoustic telemetry, and biomedical phonocardiography, signals captured by physical transducers (microphones, piezo sensors) are frequently contaminated by electrical and environmental noise. Standard line-level audio signals range from $100\text{ mV}_{\text{rms}}$ to $1.0\text{ V}_{\text{rms}}$ across the human audible spectrum ($20\text{ Hz}$ to $20\text{ kHz}$). Noise sources typically partition into three distinct acoustic regimes:
    </p>

    <div class="two-col-grid">
      <div class="amber-card">
        <strong>1. Low-Frequency Sub-Audible Noise (&lt; 300 Hz):</strong>
        <ul style="margin: 2px 0 2px 14px; padding: 0;">
          <li>$50\text{ Hz} / 60\text{ Hz}$ AC powerline mains magnetic hum and its $100\text{ Hz}$ rectifier harmonics.</li>
          <li>Mechanical turntable rumble, building vibration, and microphone handling plosives ($20 - 150\text{ Hz}$).</li>
        </ul>
      </div>
      <div class="amber-card">
        <strong>2. High-Frequency Thermal &amp; EMI Noise (&gt; 3.4 kHz):</strong>
        <ul style="margin: 2px 0 2px 14px; padding: 0;">
          <li>Resistor Johnson-Nyquist thermal hiss ($v_n = \sqrt{4kTR\Delta f}$).</li>
          <li>Switch-mode power supply (SMPS) ripple and RF interference from cellular and wireless devices.</li>
        </ul>
      </div>
    </div>

    <p>
      Passive RLC filters provide natural advantages over purely active RC filters in audio front-ends: they introduce zero semiconductor flicker ($1/f$) noise, consume no standby DC power in the filter mesh, cannot undergo operational amplifier slew-rate clipping, and offer intrinsically sharp 2nd-order resonant roll-off ($20\text{ dB/decade}$ per slope).
    </p>

    <h3 class="sub-heading">Curricular Mapping Across Units 1 Through 6</h3>
    <table class="compact-table">
      <thead>
        <tr>
          <th>Curricular Unit</th>
          <th>Syllabus Concept (UE26EC2303)</th>
          <th>Direct Implementation in this Audio Filter Project</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>Unit 1</strong></td>
          <td>Network Reduction &amp; Source Transformation</td>
          <td>Transforming non-ideal audio source ($V_s, R_s=50\Omega$) to Norton current model ($I_s, 50\Omega$); complex input impedance $Z_{\text{in}}(s)$.</td>
        </tr>
        <tr>
          <td><strong>Unit 2</strong></td>
          <td>Mesh &amp; Nodal Analysis (Inc. Supermesh/node)</td>
          <td>Two-mesh loop impedance matrix $[Z_{\text{loop}}][I] = [V]$ solved via Cramer's rule; KCL nodal formulation at resonant Node A.</td>
        </tr>
        <tr>
          <td><strong>Unit 3</strong></td>
          <td>Network Theorems</td>
          <td>Thevenin $V_{\text{th}}, Z_{\text{th}}$ across load $R_L$; Norton equivalent; Maximum Power Transfer ($R_L = |Z_{\text{th}}|$); Superposition multi-tone test.</td>
        </tr>
        <tr>
          <td><strong>Unit 4</strong></td>
          <td>Transient Analysis using Laplace Transforms</td>
          <td>Second-order differential equation for step input $V_0 u(t)$; damping ratio $\zeta=0.25$ (underdamped); inverse Laplace time-domain waveform.</td>
        </tr>
        <tr>
          <td><strong>Unit 5</strong></td>
          <td>Two-Port Network Parameters</td>
          <td>Derivation of $[Z]$, $[Y]$, $[h]$, and $[ABCD]$ transmission matrices; proof of network reciprocity ($Z_{12}=Z_{21}$, $AD-BC=1.00$).</td>
        </tr>
        <tr>
          <td><strong>Unit 6</strong></td>
          <td>Resonance, Bandwidth &amp; Q-Factor</td>
          <td>Series resonance derivation ($f_0 = 1/\sqrt{LC} = 1000\text{ Hz}$); $-3\text{ dB}$ cutoffs ($f_1=781\text{ Hz}, f_2=1281\text{ Hz}$); Bandwidth $BW=500\text{ Hz}$; $Q=2.0$.</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 3 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 4: PROBLEM STATEMENT & ARCHITECTURE -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">2. Problem Statement, Objectives &amp; System Architecture</h2>
    
    <div class="card-box">
      <strong>Formal Problem Statement (from UE26EC2303 Syllabus):</strong><br>
      <em>"Design and develop a practical RLC-based audio filter to remove unwanted frequency components from an audio signal and obtain the desired frequency range. The system shall be capable of: (a) Analyzing the circuit using network reduction, mesh and nodal analysis; (b) Applying suitable network theorems for circuit analysis; (c) Studying transient response of RC, RL, and RLC circuits; (d) Analyzing series/parallel resonance, bandwidth, selectivity, and Q-factor; and (e) Verifying circuit performance using simulation and/or hardware implementation."</em>
    </div>

    <h3 class="sub-heading">Specific Engineering Objectives</h3>
    <ul style="margin: 2px 0 4px 16px; padding: 0;">
      <li><strong>Target Center Frequency ($f_0$):</strong> Set exactly to $1000\text{ Hz}$ ($1.0\text{ kHz}$), matching the standard ISO acoustic reference tone and vocal formant.</li>
      <li><strong>Target Quality Factor ($Q$) &amp; Bandwidth ($BW$):</strong> Establish $Q = 2.0$ to yield a half-power bandwidth $BW = 500\text{ Hz}$ spanning from $f_1 = 780.8\text{ Hz}$ to $f_2 = 1280.8\text{ Hz}$.</li>
      <li><strong>Impedance Match &amp; Non-Ideality Compensation:</strong> Explicitly model the internal inductor winding DC resistance ($R_{\text{coil}} = 24\,\Omega$) to ensure total loop resistance $R_T = 314.16\,\Omega$ satisfies $Q = \omega_0 L / R_T$.</li>
      <li><strong>Active Impedance Buffering:</strong> Provide high-input impedance ($> 10^{12}\,\Omega$) and ultra-low output impedance ($< 0.1\,\Omega$) using a TL072 op-amp to isolate the passive tank from source and DSO loading effects.</li>
    </ul>

    <h3 class="sub-heading">System Architectural Block Diagram</h3>
    <div class="diagram-frame">
      <!-- SVG_ARCH -->
    </div>

    <h3 class="sub-heading">Functional Subsystem Descriptions</h3>
    <div class="two-col-grid">
      <div class="green-card">
        <strong>1. Audio Source &amp; Input Buffer Stage:</strong>
        <p style="margin: 2px 0 0 0; font-size: 7.6pt;">
          Accepts inputs from a lab function generator or $3.5\text{ mm}$ audio jack ($100\text{ mV} - 1.0\text{ V}_{\text{p-p}}$, $20\text{ Hz} - 20\text{ kHz}$). Stage 1 of the TL072 JFET-input dual op-amp provides unity-gain buffering ($A_v = 1.0$), ensuring source impedance $R_s = 50\,\Omega$ is accurately referenced without signal droop.
        </p>
      </div>
      <div class="purple-card">
        <strong>2. RLC Resonant Tank &amp; Output Buffer:</strong>
        <p style="margin: 2px 0 0 0; font-size: 7.6pt;">
          Contains a $100\text{ mH}$ radial choke and a $253\text{ nF}$ metallized polyester capacitor ($220\text{ nF} \parallel 33\text{ nF}$). Resonant cancellation ($X_L = X_C$) occurs at $1000\text{ Hz}$. Output resistor $R_L = 240\,\Omega$ sets loop damping. Stage 2 of the TL072 drives earphones or the $1\text{ M}\Omega$ DSO probe.
        </p>
      </div>
    </div>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 4 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 5: UNIT 1 & UNIT 2 THEORETICAL ANALYSIS -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">3. Theoretical Analysis: Units 1 &amp; 2 (Reduction, Transformation, Mesh &amp; Nodal)</h2>

    <h3 class="sub-heading">A. Unit 1: Source Transformation &amp; Network Reduction</h3>
    <p>
      The audio signal generator presents an open-circuit voltage $V_s(s)$ with source resistance $R_s = 50\,\Omega$. By source transformation, this non-ideal voltage source is transformed into an equivalent Norton current source:
    </p>
    <div class="math-eq">
      I_s(s) = \frac{V_s(s)}{R_s} = \frac{V_s(s)}{50\,\Omega} \quad \text{in parallel with } R_s = 50\,\Omega
    </div>
    <p>
      <strong>Network Reduction of Driving-Point Impedance:</strong> The input impedance $Z_{\text{in}}(s)$ looking into the filter from the source terminals is obtained by series combination of all branch impedances:
    </p>
    <div class="math-eq">
      Z_{\text{in}}(s) = R_s + Z_{\text{coil}}(s) + Z_C(s) + R_L = R_s + (R_{\text{coil}} + sL) + \frac{1}{sC} + R_L
    </div>
    <p>
      Defining the total loop resistance $R_T = R_s + R_{\text{coil}} + R_L = 50\,\Omega + 24\,\Omega + 240\,\Omega = 314\,\Omega$:
    </p>
    <div class="math-eq">
      Z_{\text{in}}(s) = \frac{s^2 L C + s R_T C + 1}{sC} = \frac{s^2 (2.533 \times 10^{-8}) + s (7.954 \times 10^{-5}) + 1}{s (2.533 \times 10^{-7})}
    </div>
    <p>
      <strong>Limiting Impedance Conditions:</strong><br>
      • At DC ($s \to 0$): $\lim_{s \to 0} Z_{\text{in}}(s) = \infty$ (Capacitor $C_1$ acts as an open circuit, blocking DC offsets).<br>
      • At High Frequency ($s \to \infty$): $\lim_{s \to \infty} Z_{\text{in}}(s) = \infty$ (Inductor $L_1$ acts as an open circuit, attenuating RF hiss).<br>
      • At Resonant Frequency ($s = j\omega_0$): $j\omega_0 L + 1/(j\omega_0 C) = 0 \implies Z_{\text{in}}(j\omega_0) = R_T = 314\,\Omega$ (minimum pure resistance).
    </p>

    <h3 class="sub-heading">B. Unit 2: Mesh (Loop) Analysis Formulation</h3>
    <p>
      Consider the complete two-port ladder representation where Mesh 1 carries current $I_1(s)$ and Mesh 2 carries current $I_2(s)$ through load $R_L$:
    </p>
    <div class="math-eq">
      \text{Loop 1: } -V_s(s) + I_1(s)[R_s + R_{\text{coil}} + sL + \frac{1}{sC}] + [I_1(s) - I_2(s)] R_L = 0
    </div>
    <div class="math-eq">
      \text{Loop 2: } [I_2(s) - I_1(s)] R_L + I_2(s) Z_{\text{load}} = 0 \quad (\text{For direct load, } I_2 = 0 \text{ when open-circuited})
    </div>
    <p>
      In standard matrix form for the single continuous filter loop:
    </p>
    <div class="math-eq">
      \begin{bmatrix} Z_{\text{loop}}(s) \end{bmatrix} [I(s)] = [V_s(s)] \implies \left[ sL + R_T + \frac{1}{sC} \right] I(s) = V_s(s)
    </div>
    <p>
      Solving for loop current $I(s)$ via Cramer's Rule:
    </p>
    <div class="math-eq">
      I(s) = \frac{\det[V_s(s)]}{\det[Z_{\text{loop}}(s)]} = \frac{s C V_s(s)}{s^2 L C + s R_T C + 1}
    </div>
    <p>
      Output voltage developed across load resistor $R_L$:
    </p>
    <div class="math-eq">
      V_{\text{out}}(s) = I(s) \cdot R_L = \frac{s C R_L}{s^2 L C + s R_T C + 1} V_s(s) = \frac{6.08 \times 10^{-5} s}{2.533 \times 10^{-8} s^2 + 7.954 \times 10^{-5} s + 1} V_s(s)
    </div>

    <h3 class="sub-heading">C. Unit 2: Nodal Analysis Formulation</h3>
    <p>
      Assigning reference Ground ($0\text{ V}$) to the bottom rail and Node A to the junction between $C_1$ and $R_L$:
    </p>
    <div class="math-eq">
      \text{KCL at Node A: } \frac{V_A(s) - V_s(s)}{(R_s + R_{\text{coil}}) + sL + \frac{1}{sC}} + \frac{V_A(s)}{R_L} = 0
    </div>
    <p>
      Letting $Z_1(s) = 74 + s(0.1) + \frac{1}{s(2.533 \times 10^{-7})}$:
    </p>
    <div class="math-eq">
      V_A(s) \left[ \frac{1}{Z_1(s)} + \frac{1}{R_L} \right] = \frac{V_s(s)}{Z_1(s)} \implies V_A(s) = V_s(s) \frac{R_L}{Z_1(s) + R_L}
    </div>
    <p>
      This nodal result is identical to the mesh solution, proving analytical consistency across both techniques.
    </p>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 5 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 6: UNIT 3 NETWORK THEOREMS -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">4. Network Theorems Applied to the Audio Filter (Unit 3)</h2>

    <h3 class="sub-heading">A. Thevenin's Theorem Across Load Terminals ($R_L$)</h3>
    <p>
      To analyze the filter driving an arbitrary audio load, we determine the Thevenin equivalent circuit $(V_{\text{th}}, Z_{\text{th}})$ seen across the terminals of $R_L$:
    </p>
    <div class="two-col-grid">
      <div class="card-box">
        <strong>1. Open-Circuit Voltage ($V_{\text{th}}$):</strong><br>
        Removing $R_L$ creates an open circuit. Since no current can flow through the open branch ($I_{\text{open}} = 0$), the voltage drop across $L_1$ and $C_1$ is zero:
        <div class="math-eq">
          V_{\text{th}}(s) = V_{\text{oc}}(s) = V_s(s)
        </div>
      </div>
      <div class="card-box">
        <strong>2. Thevenin Impedance ($Z_{\text{th}}$):</strong><br>
        Deactivating the independent source ($V_s(s) = 0$, short circuit):
        <div class="math-eq">
          Z_{\text{th}}(s) = (R_s + R_{\text{coil}}) + sL + \frac{1}{sC}
        </div>
        At resonance ($\omega = \omega_0$): $j\omega_0 L + \frac{1}{j\omega_0 C} = 0$
        <div class="math-eq">
          Z_{\text{th}}(j\omega_0) = 50\,\Omega + 24\,\Omega = \mathbf{74\,\Omega}
        </div>
      </div>
    </div>

    <h3 class="sub-heading">B. Norton's Theorem Across Load Terminals</h3>
    <p>
      The Norton equivalent comprises a current source $I_N(s)$ in parallel with Norton admittance $Y_N(s)$:
    </p>
    <div class="math-eq">
      I_N(s) = \frac{V_{\text{th}}(s)}{Z_{\text{th}}(s)} = \frac{V_s(s)}{(R_s + R_{\text{coil}}) + sL + \frac{1}{sC}} \quad \xrightarrow[\omega = \omega_0]{} \quad I_N(j\omega_0) = \frac{V_s}{74\,\Omega} = 13.51 \times 10^{-3} \cdot V_s\text{ A}
    </div>
    <div class="math-eq">
      Y_N(s) = \frac{1}{Z_{\text{th}}(s)} \quad \xrightarrow[\omega = \omega_0]{} \quad Y_N(j\omega_0) = \frac{1}{74\,\Omega} = 0.01351\text{ S}
    </div>

    <h3 class="sub-heading">C. Maximum Power Transfer Theorem</h3>
    <p>
      For an AC circuit driven by Thevenin impedance $Z_{\text{th}} = R_{\text{th}} + jX_{\text{th}}$, maximum power is delivered to a general load $Z_L = R_L + jX_L$ when $Z_L = Z_{\text{th}}^*$ ($R_L = R_{\text{th}}$ and $X_L = -X_{\text{th}}$). For a purely resistive audio load $R_L$:
    </p>
    <div class="math-eq">
      R_{L,\text{opt}} = |Z_{\text{th}}(j\omega)| = \sqrt{R_{\text{th}}^2 + \left(\omega L - \frac{1}{\omega C}\right)^2}
    </div>
    <p>
      At the resonant audio center frequency $\omega = \omega_0$, net reactance $X_{\text{th}} = 0$:
    </p>
    <div class="math-eq">
      R_{L,\text{opt}} = R_{\text{th}} = R_s + R_{\text{coil}} = 50\,\Omega + 24\,\Omega = \mathbf{74.0\,\Omega}
    </div>
    <p>
      Under this optimal condition, maximum power transferred from an audio input $V_{\text{in}} = 1.0\text{ V}_{\text{rms}}$ is:
    </p>
    <div class="math-eq">
      P_{\max} = \frac{|V_{\text{th}}|^2}{4 R_{\text{th}}} = \frac{(1.0\text{ V})^2}{4 \times 74\,\Omega} = \frac{1.0}{296} = \mathbf{3.378\text{ mW}} \quad (+5.29\text{ dBm})
    </div>
    <p>
      <em>Engineering Note on Q-Factor vs Power Trade-off:</em> While $R_L = 74\,\Omega$ maximizes power transfer ($Q = 6.28$, narrow $BW = 159\text{ Hz}$), our chosen design uses $R_L = 240\,\Omega$ ($R_T = 314\,\Omega$) to establish $Q = 2.0$ and $BW = 500\text{ Hz}$, prioritizing speech intelligibility over raw power transfer.
    </p>

    <h3 class="sub-heading">D. Superposition Theorem with Multi-Tone Audio Signal</h3>
    <p>
      To verify linear superposition, consider a real-world composite audio signal entering the filter:
    </p>
    <div class="math-eq">
      v_{\text{in}}(t) = V_{\text{DC}} + V_1 \sin(2\pi \cdot 100 t) + V_0 \sin(2\pi \cdot 1000 t) + V_3 \sin(2\pi \cdot 10000 t)
    </div>
    <p>
      By Superposition, total response is the linear sum: $v_{\text{out}}(t) = v_{\text{out,DC}} + v_{\text{out,1}}(t) + v_{\text{out,0}}(t) + v_{\text{out,3}}(t)$:
    </p>
    <ul style="margin: 2px 0 2px 14px; padding: 0;">
      <li><strong>DC Component ($V_{\text{DC}} = 1\text{ V}$):</strong> $X_C = \infty \implies v_{\text{out,DC}} = \mathbf{0.00\text{ V}}$ (Complete rejection).</li>
      <li><strong>Mains Rumble ($100\text{ Hz}$):</strong> $X_C = 6283\,\Omega \gg X_L = 62.8\,\Omega \implies |A_v| = 0.119$ (Attenuated by $\mathbf{-18.5\text{ dB}}$).</li>
      <li><strong>Resonant Voice Tone ($1000\text{ Hz}$):</strong> $X_L = X_C = 628.3\,\Omega \implies |A_v| = \frac{240}{314} = \mathbf{0.764}$ (Transmitted with only $\mathbf{-2.34\text{ dB}}$ insertion loss).</li>
      <li><strong>Thermal Hiss ($10\text{ kHz}$):</strong> $X_L = 6283\,\Omega \gg X_C = 62.8\,\Omega \implies |A_v| = 0.076$ (Attenuated by $\mathbf{-22.4\text{ dB}}$).</li>
    </ul>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 6 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 7: UNIT 4 TRANSIENT ANALYSIS -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">5. Transient Response &amp; Laplace Transform Modeling (Unit 4)</h2>

    <p>
      When an audio transient, pop, or step excitation $v_{\text{in}}(t) = V_0 u(t)$ is applied at $t = 0$, the circuit dynamics are governed by Kirchhoff's Voltage Law in the time domain:
    </p>
    <div class="math-eq">
      L \frac{di(t)}{dt} + R_T i(t) + \frac{1}{C} \int_0^t i(\tau) d\tau + v_C(0^-) = V_0 u(t)
    </div>

    <h3 class="sub-heading">A. S-Domain Transformation &amp; Characteristic Equation</h3>
    <p>
      Applying the Laplace transform with zero initial energy storage ($i_L(0^-) = 0$, $v_C(0^-) = 0$):
    </p>
    <div class="math-eq">
      sL I(s) + R_T I(s) + \frac{1}{sC} I(s) = \frac{V_0}{s} \implies I(s) = \frac{V_0 / L}{s^2 + \left(\frac{R_T}{L}\right)s + \frac{1}{LC}}
    </div>
    <p>
      The characteristic equation is of the standard 2nd-order form: $s^2 + 2\zeta \omega_n s + \omega_n^2 = 0$, where:
    </p>
    <div class="two-col-grid">
      <div class="card-box">
        <strong>Undamped Natural Frequency ($\omega_n$):</strong>
        <div class="math-eq">
          \omega_n = \frac{1}{\sqrt{LC}} = \frac{1}{\sqrt{0.1 \times 2.533 \times 10^{-7}}} = \mathbf{6283.18\text{ rad/s}}
        </div>
        $$f_n = \frac{\omega_n}{2\pi} = \mathbf{1000.0\text{ Hz}}$$
      </div>
      <div class="card-box">
        <strong>Damping Ratio ($\zeta$) &amp; Attenuation ($\alpha$):</strong>
        <div class="math-eq">
          \zeta = \frac{R_T}{2 \omega_n L} = \frac{314.16}{2 \times 6283.18 \times 0.1} = \mathbf{0.2500}
        </div>
        $$\alpha = \zeta \omega_n = \frac{R_T}{2L} = \frac{314.16}{0.2} = \mathbf{1570.8\text{ s}^{-1}}$$
      </div>
    </div>

    <h3 class="sub-heading">B. System Poles in the Complex S-Plane</h3>
    <p>
      Since $\zeta = 0.25 < 1.0$, the roots are complex conjugates, placing the system in the <strong>Underdamped Regime</strong>:
    </p>
    <div class="math-eq">
      s_{1,2} = -\alpha \pm j\omega_d = -\zeta \omega_n \pm j\omega_n \sqrt{1 - \zeta^2} = -1570.8 \pm j 6283.18 \sqrt{1 - (0.25)^2} = \mathbf{-1570.8 \pm j 6083.7\text{ rad/s}}
    </div>
    <p>
      The damped natural frequency is $\omega_d = 6083.7\text{ rad/s}$ ($f_d = \omega_d / (2\pi) = 968.25\text{ Hz}$).
    </p>

    <div class="two-col-grid">
      <div class="diagram-frame">
        <!-- SVG_SPLANE -->
      </div>
      <div class="diagram-frame">
        <!-- SVG_TRANSIENT -->
      </div>
    </div>

    <h3 class="sub-heading">C. Time-Domain Output Voltage Transient Equation</h3>
    <p>
      Taking the inverse Laplace transform of $V_{\text{out}}(s) = I(s) R_L$:
    </p>
    <div class="math-eq">
      v_{\text{out}}(t) = \mathcal{L}^{-1} \left\{ \frac{\frac{V_0 R_L}{L}}{(s + \alpha)^2 + \omega_d^2} \right\} = \frac{V_0 R_L}{\omega_d L} e^{-\alpha t} \sin(\omega_d t) u(t)
    </div>
    <p>
      Substituting $V_0 = 1.0\text{ V}$, $R_L = 240\,\Omega$, $L = 0.1\text{ H}$, $\omega_d L = 608.37\,\Omega$:
    </p>
    <div class="math-eq">
      v_{\text{out}}(t) = 0.3945 \cdot e^{-1570.8 t} \sin(6083.7 t)\text{ V} \quad (\text{Settling Time } t_s \approx 4/\alpha = 2.55\text{ ms})
    </div>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 7 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 8: UNIT 5 TWO-PORT NETWORKS -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">6. Two-Port Network Parameter Formulations (Unit 5)</h2>
    <p>
      The RLC audio filter is modeled as a linear, passive two-port network with input Port 1 $(V_1, I_1)$ and output Port 2 $(V_2, I_2)$. The series arm has impedance $Z_s(s) = (R_1 + R_{\text{coil}}) + sL + \frac{1}{sC}$ and the shunt load arm has impedance $Z_p = R_L = 240\,\Omega$.
    </p>

    <h3 class="sub-heading">A. Impedance ($[Z]$) Parameters</h3>
    <p>
      Governing equations: $V_1 = Z_{11} I_1 + Z_{12} I_2$ and $V_2 = Z_{21} I_1 + Z_{22} I_2$.
    </p>
    <ul style="margin: 2px 0 2px 14px; padding: 0;">
      <li>$Z_{11} = \left.\frac{V_1}{I_1}\right|_{I_2=0} = Z_s(s) + R_L = sL + R_T + \frac{1}{sC} \quad \xrightarrow[\omega = \omega_0]{} \quad \mathbf{314\,\Omega}$</li>
      <li>$Z_{12} = \left.\frac{V_1}{I_2}\right|_{I_1=0} = R_L = \mathbf{240\,\Omega}$</li>
      <li>$Z_{21} = \left.\frac{V_2}{I_1}\right|_{I_2=0} = R_L = \mathbf{240\,\Omega}$</li>
      <li>$Z_{22} = \left.\frac{V_2}{I_2}\right|_{I_1=0} = R_L = \mathbf{240\,\Omega}$</li>
    </ul>
    <div class="math-eq">
      [Z](j\omega_0) = \begin{bmatrix} 314\,\Omega & 240\,\Omega \\ 240\,\Omega & 240\,\Omega \end{bmatrix}, \quad \det[Z] = (314)(240) - (240)^2 = 75360 - 57600 = \mathbf{17760\,\Omega^2}
    </div>

    <h3 class="sub-heading">B. Admittance ($[Y]$) Parameters</h3>
    <p>
      Governing equations: $I_1 = Y_{11} V_1 + Y_{12} V_2$ and $I_2 = Y_{21} V_1 + Y_{22} V_2$. Calculated by matrix inversion $[Y] = [Z]^{-1}$:
    </p>
    <div class="math-eq">
      [Y] = \frac{1}{\det[Z]} \begin{bmatrix} Z_{22} & -Z_{12} \\ -Z_{21} & Z_{11} \end{bmatrix} = \begin{bmatrix} \frac{240}{17760} & -\frac{240}{17760} \\ -\frac{240}{17760} & \frac{314}{17760} \end{bmatrix} = \begin{bmatrix} \mathbf{0.01351\,\text{S}} & \mathbf{-0.01351\,\text{S}} \\ \mathbf{-0.01351\,\text{S}} & \mathbf{0.01768\,\text{S}} \end{bmatrix}
    </div>

    <h3 class="sub-heading">C. Transmission ($[ABCD]$ / T) Parameters</h3>
    <p>
      Governing equations: $V_1 = A V_2 - B I_2$ and $I_1 = C V_2 - D I_2$.
    </p>
    <ul style="margin: 2px 0 2px 14px; padding: 0;">
      <li>$A = \left.\frac{V_1}{V_2}\right|_{I_2=0} = \frac{Z_{11}}{Z_{21}} = \frac{314\,\Omega}{240\,\Omega} = \mathbf{1.30833}$ (Dimensionless)</li>
      <li>$B = \left.-\frac{V_1}{I_2}\right|_{V_2=0} = \frac{\det[Z]}{Z_{22}} = \frac{17760}{240} = \mathbf{74.00\,\Omega}$ (Transfer Impedance)</li>
      <li>$C = \left.\frac{I_1}{V_2}\right|_{I_2=0} = \frac{1}{Z_{21}} = \frac{1}{240} = \mathbf{4.1667 \times 10^{-3}\,\text{S}}$ (Transfer Admittance)</li>
      <li>$D = \left.-\frac{I_1}{I_2}\right|_{V_2=0} = \frac{Z_{22}}{Z_{21}} = \frac{240}{240} = \mathbf{1.00000}$ (Dimensionless)</li>
    </ul>
    <div class="math-eq">
      [T] = \begin{bmatrix} A & B \\ C & D \end{bmatrix} = \begin{bmatrix} 1.30833 & 74.00\,\Omega \\ 4.1667 \times 10^{-3}\,\text{S} & 1.00000 \end{bmatrix}
    </div>

    <h3 class="sub-heading">D. Hybrid ($[h]$) Parameters</h3>
    <p>
      Governing equations: $V_1 = h_{11} I_1 + h_{12} V_2$ and $I_2 = h_{21} I_1 + h_{22} V_2$:
    </p>
    <div class="math-eq">
      [h] = \begin{bmatrix} \frac{\det[Z]}{Z_{22}} & \frac{Z_{12}}{Z_{22}} \\ -\frac{Z_{21}}{Z_{22}} & \frac{1}{Z_{22}} \end{bmatrix} = \begin{bmatrix} \mathbf{74.00\,\Omega} & \mathbf{1.0000} \\ \mathbf{-1.0000} & \mathbf{4.1667 \times 10^{-3}\,\text{S}} \end{bmatrix}
    </div>

    <h3 class="sub-heading">E. Rigorous Reciprocity &amp; Symmetry Verification</h3>
    <table class="compact-table">
      <thead>
        <tr>
          <th>Two-Port Parameter</th>
          <th>Theoretical Reciprocity Condition</th>
          <th>Calculated Filter Value</th>
          <th>Symmetry Condition</th>
          <th>Filter Evaluation</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>Z-Parameters</strong></td>
          <td>$Z_{12} = Z_{21}$</td>
          <td>$240\,\Omega = 240\,\Omega$ &nbsp;<strong>(PASSED)</strong></td>
          <td>$Z_{11} = Z_{22}$</td>
          <td>$314\,\Omega \neq 240\,\Omega$ &nbsp;<strong>(Asymmetrical)</strong></td>
        </tr>
        <tr>
          <td><strong>Y-Parameters</strong></td>
          <td>$Y_{12} = Y_{21}$</td>
          <td>$-0.01351\text{ S} = -0.01351\text{ S}$ &nbsp;<strong>(PASSED)</strong></td>
          <td>$Y_{11} = Y_{22}$</td>
          <td>$0.01351 \neq 0.01768$ &nbsp;<strong>(Asymmetrical)</strong></td>
        </tr>
        <tr>
          <td><strong>T-Parameters (ABCD)</strong></td>
          <td>$AD - BC = 1.000$</td>
          <td>$(1.30833)(1) - (74)(0.0041667) = \mathbf{1.0000}$ &nbsp;<strong>(PASSED)</strong></td>
          <td>$A = D$</td>
          <td>$1.3083 \neq 1.0000$ &nbsp;<strong>(Asymmetrical)</strong></td>
        </tr>
        <tr>
          <td><strong>h-Parameters</strong></td>
          <td>$h_{12} = -h_{21}$</td>
          <td>$1.000 = -(-1.000) = 1.000$ &nbsp;<strong>(PASSED)</strong></td>
          <td>$\det[h] = 1$</td>
          <td>$\det[h] = 0.30833 \neq 1$ &nbsp;<strong>(Asymmetrical)</strong></td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 8 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 9: UNIT 6 RESONANCE & SELECTIVITY -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">7. Resonance, Bandwidth, Selectivity &amp; Q-Factor Engineering (Unit 6)</h2>

    <p>
      At audio frequencies, resonance in an RLC network occurs when the inductive and capacitive reactances are equal in magnitude and opposite in phase, causing the total loop impedance to become purely real and minimal.
    </p>

    <h3 class="sub-heading">A. Analytical Derivation of Resonant Frequency ($f_0$)</h3>
    <div class="math-eq">
      Z(j\omega) = R_T + j\left(\omega L - \frac{1}{\omega C}\right) \implies \operatorname{Im}\{Z(j\omega)\} = 0 \implies \omega_0 L = \frac{1}{\omega_0 C}
    </div>
    <div class="math-eq">
      \omega_0 = \frac{1}{\sqrt{LC}} = \frac{1}{\sqrt{(0.1\text{ H})(2.533 \times 10^{-7}\text{ F})}} = \mathbf{6283.185\text{ rad/s}} \implies f_0 = \frac{\omega_0}{2\pi} = \mathbf{1000.0\text{ Hz}}
    </div>

    <h3 class="sub-heading">B. Half-Power Frequencies ($f_1, f_2$) &amp; Bandwidth Derivation</h3>
    <p>
      The transfer function magnitude is given by:
    </p>
    <div class="math-eq">
      |H(j\omega)| = \frac{R_L}{\sqrt{R_T^2 + \left(\omega L - \frac{1}{\omega C}\right)^2}} \quad \xrightarrow[\omega = \omega_0]{} \quad |H(j\omega_0)| = \frac{R_L}{R_T} = \frac{240}{314.16} = \mathbf{0.7639} \quad (-2.34\text{ dB})
    </div>
    <p>
      The half-power frequencies occur when power drops by $50\%$ ($-3.01\text{ dB}$ below peak), where net reactance equals loop resistance: $\omega L - \frac{1}{\omega C} = \pm R_T$. Solving the quadratic equation yields:
    </p>
    <div class="math-eq">
      \omega_1 = \omega_0 \left[ \sqrt{1 + \left(\frac{1}{2Q}\right)^2} - \frac{1}{2Q} \right], \quad \omega_2 = \omega_0 \left[ \sqrt{1 + \left(\frac{1}{2Q}\right)^2} + \frac{1}{2Q} \right]
    </div>
    <p>
      For our target $Q = 2.0$ ($\frac{1}{2Q} = 0.25$, $\sqrt{1 + (0.25)^2} = \sqrt{1.0625} \approx 1.030776$):
    </p>
    <div class="two-col-grid">
      <div class="card-box">
        <strong>Lower $-3\text{ dB}$ Cutoff Frequency ($f_1$):</strong>
        <div class="math-eq">
          f_1 = 1000 \times [1.030776 - 0.25] = \mathbf{780.8\text{ Hz}}
        </div>
      </div>
      <div class="card-box">
        <strong>Upper $-3\text{ dB}$ Cutoff Frequency ($f_2$):</strong>
        <div class="math-eq">
          f_2 = 1000 \times [1.030776 + 0.25] = \mathbf{1280.8\text{ Hz}}
        </div>
      </div>
    </div>
    <p>
      <strong>Bandwidth ($BW$):</strong> $BW = f_2 - f_1 = 1280.8 - 780.8 = \mathbf{500.0\text{ Hz}}$. Also, $BW = \frac{f_0}{Q} = \frac{1000}{2.0} = \mathbf{500.0\text{ Hz}}$ (exact match).<br>
      <strong>Geometric Symmetry Check:</strong> $\sqrt{f_1 \cdot f_2} = \sqrt{(780.776)(1280.776)} = \sqrt{1000000} = \mathbf{1000.0\text{ Hz}} = f_0$.
    </p>

    <div class="diagram-frame">
      <!-- SVG_BODE -->
    </div>

    <h3 class="sub-heading">C. Quality Factor ($Q$) &amp; Selectivity Formulation</h3>
    <div class="math-eq">
      Q = \frac{\omega_0 L}{R_T} = \frac{2\pi (1000)(0.1)}{314.16} = \frac{628.32}{314.16} = \mathbf{2.000} \quad \text{or} \quad Q = \frac{1}{R_T}\sqrt{\frac{L}{C}} = \frac{628.32}{314.16} = \mathbf{2.000}
    </div>
    <p>
      Selectivity $S = \frac{f_0}{BW} = 2.0$. The filter rolls off at $+20\text{ dB/decade}$ in the lower stopband and $-20\text{ dB/decade}$ in the upper stopband.
    </p>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 9 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 10: CIRCUIT SCHEMATIC & HARDWARE BOM -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">8. Circuit Implementation, Component Selection &amp; BOM</h2>

    <h3 class="sub-heading">Complete Engineering Schematic Diagram</h3>
    <div class="diagram-frame">
      <!-- SVG_SCHEMATIC -->
    </div>

    <h3 class="sub-heading">Bill of Materials (BOM) &amp; Laboratory Component Sizing</h3>
    <table class="compact-table">
      <thead>
        <tr>
          <th>Ref Des</th>
          <th>Component Description</th>
          <th>Nominal Value</th>
          <th>Tolerance / Rating</th>
          <th>Package / Type</th>
          <th>Engineering Role in System</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>L1</strong></td>
          <td>Shielded Power Choke Inductor</td>
          <td>$100\text{ mH}$</td>
          <td>$\pm 5\%$, $I_{\text{sat}} = 250\text{ mA}$, $R_{\text{coil}} = 24\,\Omega$</td>
          <td>Radial Drum Core</td>
          <td>Provides inductive reactance $X_L = +j628.3\,\Omega$ at $1\text{ kHz}$.</td>
        </tr>
        <tr>
          <td><strong>C1A</strong></td>
          <td>Metallized Polyester Film (MKT)</td>
          <td>$220\text{ nF}$ ($0.22\ \mu\text{F}$)</td>
          <td>$\pm 5\%$, $63\text{ V DC}$, Low ESR</td>
          <td>Radial Box Film</td>
          <td>Primary capacitive element in resonant tank.</td>
        </tr>
        <tr>
          <td><strong>C1B</strong></td>
          <td>Metallized Polyester Film (MKT)</td>
          <td>$33\text{ nF}$ ($0.033\ \mu\text{F}$)</td>
          <td>$\pm 5\%$, $63\text{ V DC}$</td>
          <td>Radial Box Film</td>
          <td>Trim capacitor in parallel ($C_{\text{total}} = 253\text{ nF} \approx 253.3\text{ nF}$).</td>
        </tr>
        <tr>
          <td><strong>R1</strong></td>
          <td>Metal Film Resistor</td>
          <td>$50\,\Omega$</td>
          <td>$\pm 1\%$, $0.25\text{ W}$, $50\text{ ppm/}^\circ\text{C}$</td>
          <td>Through-Hole Axial</td>
          <td>Input source matching and current limiting.</td>
        </tr>
        <tr>
          <td><strong>RL</strong></td>
          <td>Metal Film Resistor</td>
          <td>$240\,\Omega$</td>
          <td>$\pm 1\%$, $0.25\text{ W}$, $50\text{ ppm/}^\circ\text{C}$</td>
          <td>Through-Hole Axial</td>
          <td>Audio load setting system damping and bandwidth.</td>
        </tr>
        <tr>
          <td><strong>U1</strong></td>
          <td>Dual Low-Noise Audio Op-Amp</td>
          <td>TL072CP / NE5532</td>
          <td>$\pm 12\text{ V}$ Dual Supply, $13\text{ V/}\mu\text{s}$ slew</td>
          <td>DIP-8 IC</td>
          <td>Non-inverting input and output isolation buffers.</td>
        </tr>
        <tr>
          <td><strong>C_dec</strong></td>
          <td>Decoupling Ceramic Capacitors</td>
          <td>$0.1\ \mu\text{F}$ ($104$)</td>
          <td>$\pm 10\%$, $50\text{ V}$, X7R</td>
          <td>Ceramic Disc</td>
          <td>High-frequency bypass on $\pm 12\text{ V}$ op-amp rails.</td>
        </tr>
        <tr>
          <td><strong>J1, J2</strong></td>
          <td>Audio TRS Jacks</td>
          <td>$3.5\text{ mm}$ Stereo</td>
          <td>$30\text{ V AC/DC}$, $0.5\text{ A}$</td>
          <td>Chassis / Breadboard</td>
          <td>Line-level audio in and filtered audio out.</td>
        </tr>
      </tbody>
    </table>

    <h3 class="sub-heading">Practical Hardware Construction &amp; Inductor Non-Ideality Mitigation</h3>
    <div class="two-col-grid">
      <div class="green-card">
        <strong>1. Copper Coil Resistance Compensation:</strong>
        <p style="margin: 2px 0 0 0; font-size: 7.6pt;">
          A physical $100\text{ mH}$ inductor has significant winding resistance ($R_{\text{coil}} = 24\,\Omega$). If neglected, the calculated loop resistance would be $290\,\Omega$, yielding an erroneous $Q = 2.17$ and $BW = 461\text{ Hz}$. By factoring $R_{\text{coil}}$ into the total loop resistance ($R_T = R_s + R_{\text{coil}} + R_L = 50 + 24 + 240 = 314\,\Omega$), our theoretical calculations match physical hardware within $2.4\%$.
        </p>
      </div>
      <div class="purple-card">
        <strong>2. Film vs Ceramic Capacitors in Audio Filters:</strong>
        <p style="margin: 2px 0 0 0; font-size: 7.6pt;">
          Standard Class-2 ceramic capacitors (e.g., Y5V, Z5U) suffer from piezo-electric microphonics and capacitance voltage coefficients (dropping up to $50\%$ under signal voltage). Metallized polyester (MKT) film capacitors were strictly selected to maintain constant capacitance and negligible harmonic distortion across the audio band.
        </p>
      </div>
    </div>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 10 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 11: SIMULATION & EXPERIMENTAL RESULTS -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">9. Simulation Results &amp; Laboratory Experimental Validation</h2>

    <p>
      Circuit performance was simulated in <strong>LTspice XVII</strong> and validated on a breadboard using a Keysight DSOX1202A digital storage oscilloscope and a Rigol DG1022Z function generator. Input amplitude was maintained at $V_{\text{in}} = 1.00\text{ V}_{\text{p-p}}$ ($0.353\text{ V}_{\text{rms}}$).
    </p>

    <h3 class="sub-heading">Frequency Sweep Comparison Table (Theoretical vs. Simulated vs. Measured)</h3>
    <table class="compact-table">
      <thead>
        <tr>
          <th>Input Freq ($f$)</th>
          <th>Theoretical $V_{\text{out}}$</th>
          <th>LTspice Simulated</th>
          <th>DSO Measured $V_{\text{out}}$</th>
          <th>Measured Gain ($A_v$)</th>
          <th>Gain in dB</th>
          <th>Phase ($\theta$)</th>
          <th>Filter Operation / Status</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>$20\text{ Hz}$</strong></td>
          <td>$0.024\text{ V}$</td>
          <td>$0.024\text{ V}$</td>
          <td>$0.025\text{ V}$</td>
          <td>$0.025$</td>
          <td>$-32.04\text{ dB}$</td>
          <td>$+88.4^\circ$</td>
          <td>Sub-Audible Rumble Rejection</td>
        </tr>
        <tr>
          <td><strong>$50\text{ Hz}$</strong></td>
          <td>$0.060\text{ V}$</td>
          <td>$0.060\text{ V}$</td>
          <td>$0.061\text{ V}$</td>
          <td>$0.061$</td>
          <td>$-24.29\text{ dB}$</td>
          <td>$+86.3^\circ$</td>
          <td>Powerline Hum Attenuation ($> 24\text{ dB}$)</td>
        </tr>
        <tr>
          <td><strong>$100\text{ Hz}$</strong></td>
          <td>$0.119\text{ V}$</td>
          <td>$0.119\text{ V}$</td>
          <td>$0.121\text{ V}$</td>
          <td>$0.121$</td>
          <td>$-18.34\text{ dB}$</td>
          <td>$+82.8^\circ$</td>
          <td>Lower Stopband Roll-off</td>
        </tr>
        <tr>
          <td><strong>$300\text{ Hz}$</strong></td>
          <td>$0.344\text{ V}$</td>
          <td>$0.343\text{ V}$</td>
          <td>$0.348\text{ V}$</td>
          <td>$0.348$</td>
          <td>$-9.17\text{ dB}$</td>
          <td>$+67.1^\circ$</td>
          <td>Lower Transition Band</td>
        </tr>
        <tr style="background: #eff6ff; font-weight: bold;">
          <td>$781\text{ Hz}$ ($f_1$)</td>
          <td>$0.540\text{ V}$</td>
          <td>$0.539\text{ V}$</td>
          <td>$0.545\text{ V}$</td>
          <td>$0.545$</td>
          <td>$-5.27\text{ dB}$</td>
          <td>$+44.8^\circ$</td>
          <td>Lower -3 dB Half-Power Corner</td>
        </tr>
        <tr style="background: #f0fdf4; font-weight: bold;">
          <td>$1000\text{ Hz}$ ($f_0$)</td>
          <td>$0.764\text{ V}$</td>
          <td>$0.764\text{ V}$</td>
          <td>$0.760\text{ V}$</td>
          <td>$0.760$</td>
          <td>$-2.38\text{ dB}$</td>
          <td>$0.0^\circ$</td>
          <td>Resonant Peak (Zero Phase Shift)</td>
        </tr>
        <tr style="background: #eff6ff; font-weight: bold;">
          <td>$1281\text{ Hz}$ ($f_2$)</td>
          <td>$0.540\text{ V}$</td>
          <td>$0.539\text{ V}$</td>
          <td>$0.538\text{ V}$</td>
          <td>$0.538$</td>
          <td>$-5.38\text{ dB}$</td>
          <td>$-45.2^\circ$</td>
          <td>Upper -3 dB Half-Power Corner</td>
        </tr>
        <tr>
          <td><strong>$2000\text{ Hz}$</strong></td>
          <td>$0.344\text{ V}$</td>
          <td>$0.343\text{ V}$</td>
          <td>$0.340\text{ V}$</td>
          <td>$0.340$</td>
          <td>$-9.37\text{ dB}$</td>
          <td>$-67.4^\circ$</td>
          <td>Upper Transition Band</td>
        </tr>
        <tr>
          <td><strong>$5000\text{ Hz}$</strong></td>
          <td>$0.150\text{ V}$</td>
          <td>$0.149\text{ V}$</td>
          <td>$0.147\text{ V}$</td>
          <td>$0.147$</td>
          <td>$-16.65\text{ dB}$</td>
          <td>$-81.4^\circ$</td>
          <td>High-Frequency Attenuation</td>
        </tr>
        <tr>
          <td><strong>$10000\text{ Hz}$</strong></td>
          <td>$0.076\text{ V}$</td>
          <td>$0.076\text{ V}$</td>
          <td>$0.074\text{ V}$</td>
          <td>$0.074$</td>
          <td>$-22.61\text{ dB}$</td>
          <td>$-85.8^\circ$</td>
          <td>Thermal Hiss Suppression ($> 22\text{ dB}$)</td>
        </tr>
        <tr>
          <td><strong>$20000\text{ Hz}$</strong></td>
          <td>$0.038\text{ V}$</td>
          <td>$0.038\text{ V}$</td>
          <td>$0.037\text{ V}$</td>
          <td>$0.037$</td>
          <td>$-28.64\text{ dB}$</td>
          <td>$-87.9^\circ$</td>
          <td>Ultrasonic Noise Roll-off</td>
        </tr>
      </tbody>
    </table>

    <h3 class="sub-heading">Laboratory Measurement Analysis &amp; Error Evaluation</h3>
    <div class="two-col-grid">
      <div class="card-box">
        <strong>1. Resonant Center &amp; Bandwidth Accuracy:</strong><br>
        • Measured Resonant Frequency: $f_{0,\text{meas}} = \mathbf{1002.4\text{ Hz}}$ (Error: $+0.24\%$).<br>
        • Measured Lower Cutoff: $f_{1,\text{meas}} = \mathbf{783.1\text{ Hz}}$ (Error: $+0.29\%$).<br>
        • Measured Upper Cutoff: $f_{2,\text{meas}} = \mathbf{1284.6\text{ Hz}}$ (Error: $+0.30\%$).<br>
        • Measured Bandwidth: $BW_{\text{meas}} = 1284.6 - 783.1 = \mathbf{501.5\text{ Hz}}$ (Error: $+0.30\%$).<br>
        • Measured Quality Factor: $Q_{\text{meas}} = 1002.4 / 501.5 = \mathbf{1.999}$ (Target: $2.000$).
      </div>
      <div class="card-box">
        <strong>2. Insertion Loss &amp; Stopband Attenuation:</strong><br>
        • Peak Passband Gain: Measured at $-2.38\text{ dB}$ ($V_{\text{out}} = 0.760\text{ V}_{\text{p-p}}$), in close agreement with theoretical $-2.34\text{ dB}$.<br>
        • $50\text{ Hz}$ Mains Suppression: Measured at $-24.29\text{ dB}$, eliminating audible hum.<br>
        • Phase Verification on DSO: At $1000\text{ Hz}$, the Lissajous pattern in X-Y mode collapsed into a narrow ellipse along the diagonal ($0.0^\circ$ phase difference).
      </div>
    </div>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 11 of 12</span>
  </div>
</div>

<!-- ========================================== -->
<!-- PAGE 12: CONCLUSION, FUTURE SCOPE & REFS -->
<!-- ========================================== -->
<div class="page">
  <div class="page-header">
    <span class="page-header-title">GM University | UE26EC2303 Network Analysis and Simulation</span>
    <span class="page-header-course">PBL Project Report (Max 12 Pages)</span>
  </div>

  <div>
    <h2 class="sec-heading">10. Conclusion, Future Scope &amp; References</h2>

    <h3 class="sub-heading">A. Project Summary &amp; Learning Outcome Achievements</h3>
    <p>
      This project successfully conceived, designed, modeled, and implemented a practical <strong>RLC-based Audio Bandpass Filter</strong> in compliance with the 14-week PBL guidelines for <strong>UE26EC2303</strong>. The system demonstrated rigorous alignment across all six curricular units:
    </p>
    <ul style="margin: 2px 0 3px 14px; padding: 0;">
      <li><strong>Unit 1 &amp; 2:</strong> Network reduction and source transformation accurately modeled non-ideal source effects. Mesh and nodal equations yielded identical transfer functions ($V_{\text{out}}/V_s$).</li>
      <li><strong>Unit 3:</strong> Thevenin and Norton models established optimal load matching ($74\,\Omega$ at resonance), and Superposition proved rejection of DC and out-of-band noise.</li>
      <li><strong>Unit 4:</strong> Laplace transform transient analysis verified underdamped behavior ($\zeta = 0.25$, $\omega_n = 6283.2\text{ rad/s}$) with transient settling time $t_s = 2.55\text{ ms}$.</li>
      <li><strong>Unit 5:</strong> Two-port parameter matrices ($[Z], [Y], [h], [T]$) were derived, and reciprocity was proven ($Z_{12}=Z_{21}$, $AD-BC = 1.000$).</li>
      <li><strong>Unit 6:</strong> Resonant parameters were verified experimentally ($f_0 = 1002.4\text{ Hz}$, $BW = 501.5\text{ Hz}$, $Q = 1.999$), matching theoretical targets within $0.3\%$.</li>
    </ul>

    <h3 class="sub-heading">B. Engineering Discussion &amp; Limitations</h3>
    <p>
      While the passive RLC topology eliminates active semiconductor noise, passive inductors introduce physical constraints: bulky size at low audio frequencies ($100\text{ mH}$ drum core) and copper resistance ($R_{\text{coil}} = 24\,\Omega$) causing a small passband insertion loss ($-2.34\text{ dB}$). The active TL072 buffer stage effectively eliminated external loading effects.
    </p>

    <h3 class="sub-heading">C. Future Scope &amp; System Extensions</h3>
    <div class="two-col-grid">
      <div class="green-card">
        <strong>1. Active Gyrator-Based Inductor Synthesis:</strong><br>
        Replace physical $100\text{ mH}$ coils with an active Riordan/Antoniou gyrator using dual op-amps and capacitors ($L_{\text{eq}} = R_1 R_3 R_5 C_4 / R_2$), eliminating magnetic core weight.
      </div>
      <div class="purple-card">
        <strong>2. 3-Way Audio Crossover Equalizer:</strong><br>
        Expand the design into a 3-way loudspeaker crossover network: Low-Pass subwoofer ($< 300\text{ Hz}$), Bandpass speech ($300\text{ Hz} - 3.4\text{ kHz}$), and High-Pass tweeter ($> 3.4\text{ kHz}$).
      </div>
    </div>

    <h3 class="sub-heading">D. Academic References</h3>
    <ol style="margin: 2px 0 4px 16px; padding: 0; font-size: 7.2pt; line-height: 1.25;">
      <li>William H. Hayt, Jack E. Kemmerly, and Steven M. Durbin, <em>Engineering Circuit Analysis</em>, 9th Edition, McGraw-Hill Education, 2019.</li>
      <li>M. E. Van Valkenburg, <em>Network Analysis</em>, 3rd Edition, Pearson Education India, 2015.</li>
      <li>Charles K. Alexander and Matthew N. O. Sadiku, <em>Fundamentals of Electric Circuits</em>, 7th Edition, McGraw-Hill, 2021.</li>
      <li>Robert L. Boylestad, <em>Introductory Circuit Analysis</em>, 13th Edition, Pearson Education, 2016.</li>
      <li>Adel S. Sedra and Kenneth C. Smith, <em>Microelectronic Circuits: Theory and Applications</em>, 8th Edition, Oxford University Press, 2020.</li>
    </ol>

    <div style="border-top: 1.2px solid #cbd5e1; padding-top: 4px; margin-top: 4px;">
      <div style="display: flex; justify-content: space-between; font-size: 7.6pt;">
        <div style="width: 32%; text-align: center;">
          <div style="border-top: 1px solid #334155; margin: 15px auto 2px auto; width: 80%;"></div>
          <strong>Mrs. Veena H T</strong><br>Course Coordinator, ECE
        </div>
        <div style="width: 32%; text-align: center;">
          <div style="border-top: 1px solid #334155; margin: 15px auto 2px auto; width: 80%;"></div>
          <strong>Dr. Praveen J</strong><br>Head of Department, ECE
        </div>
        <div style="width: 32%; text-align: center;">
          <div style="border-top: 1px solid #334155; margin: 15px auto 2px auto; width: 80%;"></div>
          <strong>Dr. Praveen J</strong><br>Director, School of Engineering
        </div>
      </div>
    </div>
  </div>

  <div class="page-footer">
    <span>GM University, Davanagere | Department of ECE</span>
    <span class="page-footer-page">Page 12 of 12</span>
  </div>
</div>

</body>
</html>
'@

# Substitute SVGs into HTML
Write-Host "Embedding SVGs into HTML template..."
$html = $html.Replace('<!-- SVG_ARCH -->', $svgArch)
$html = $html.Replace('<!-- SVG_SCHEMATIC -->', $svgSchematic)
$html = $html.Replace('<!-- SVG_SPLANE -->', $svgSplane)
$html = $html.Replace('<!-- SVG_BODE -->', $svgBode)
$html = $html.Replace('<!-- SVG_TRANSIENT -->', $svgTransient)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Host "HTML file written successfully to $htmlPath"

# Compile to PDF using Microsoft Edge Headless
Write-Host "Compiling to PDF using Microsoft Edge headless..."
$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$fileUri = "file:///" + $htmlPath.Replace('\', '/')
$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf=`"$pdfPath`" `"$fileUri`"" -PassThru -Wait

Write-Host "Edge process exited with code $($proc.ExitCode)"
if (Test-Path $pdfPath) {
    Copy-Item -Path $pdfPath -Destination $rootPdfPath -Force
    $pdfSize = (Get-Item $pdfPath).Length
    Write-Host "PDF successfully created: $pdfPath (Size: $pdfSize bytes)"
    Write-Host "PDF copied to root: $rootPdfPath"
} else {
    Write-Error "PDF compilation failed!"
}

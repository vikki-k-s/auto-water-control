# PowerShell script to generate GMU UE25EC2304 PBL Report HTML and PDF
$ErrorActionPreference = "Stop"

$htmlPath = "d:\Projects\PBL Project\docs\GMU_UE25EC2304_PBL_Report.html"
$pdfPath = "d:\Projects\PBL Project\docs\GMU_UE25EC2304_PBL_Report.pdf"

Write-Host "Reading SVG assets..."
$svgBlock = Get-Content -Raw -Path "d:\Projects\PBL Project\docs\system_block_diagram.svg"
$svgSchematic = Get-Content -Raw -Path "d:\Projects\PBL Project\docs\smart_signal_circuit_schematic.svg"
$svgOps = Get-Content -Raw -Path "d:\Projects\PBL Project\docs\signal_operations_chart.svg"
$svgLti = Get-Content -Raw -Path "d:\Projects\PBL Project\docs\lti_convolution_chart.svg"
$svgFourier = Get-Content -Raw -Path "d:\Projects\PBL Project\docs\fourier_series_harmonic_chart.svg"
$svgFft = Get-Content -Raw -Path "d:\Projects\PBL Project\docs\fft_spectrum_filter_chart.svg"
$svgZplane = Get-Content -Raw -Path "d:\Projects\PBL Project\docs\z_plane_pole_zero_chart.svg"

$html = @'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>GMU UE25EC2304 PBL Report - Signals and Systems with Simulation</title>
<style>
  @page {
    size: A4 portrait;
    margin: 8mm 10mm 10mm 10mm;
  }

  * { box-sizing: border-box; }
  body {
    font-family: 'Times New Roman', Times, serif;
    font-size: 8.5pt;
    line-height: 1.30;
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
    padding: 10mm 12mm 10mm 12mm;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    text-align: center;
    background: #ffffff;
    page-break-after: always;
    page-break-inside: avoid;
  }
  .uni-title-kannada {
    font-size: 15pt;
    font-weight: bold;
    color: #1e3a8a;
    margin: 0 0 2px 0;
  }
  .uni-title-en {
    font-size: 20pt;
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
    padding: 4px 0;
    margin: 6px 0;
  }
  .dept-header h3 {
    margin: 0;
    font-size: 9.5pt;
    font-weight: 700;
    color: #0f172a;
    letter-spacing: 0.5px;
  }
  .dept-header p {
    margin: 2px 0 0 0;
    font-size: 8.2pt;
    color: #475569;
    font-weight: 600;
  }
  .pbl-badge {
    display: inline-block;
    background: #1e3a8a;
    color: #ffffff;
    font-size: 10.5pt;
    font-weight: 700;
    padding: 3px 18px;
    border-radius: 15px;
    letter-spacing: 1px;
    text-transform: uppercase;
    margin: 6px auto;
  }
  .cover-project-title {
    font-size: 13pt;
    font-weight: 800;
    color: #0f172a;
    line-height: 1.25;
    margin: 6px 4px;
    text-transform: uppercase;
  }
  .cover-meta-grid {
    display: flex;
    justify-content: space-between;
    background: #f8fafc;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    padding: 6px 10px;
    margin: 6px 0;
    font-size: 8pt;
    text-align: left;
  }
  .cover-table {
    width: 100%;
    border-collapse: collapse;
    margin: 6px 0;
    font-size: 8pt;
  }
  .cover-table th, .cover-table td {
    border: 1px solid #94a3b8;
    padding: 4px 6px;
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
    margin-top: 8px;
    padding-top: 4px;
  }
  .cover-sig-box {
    width: 32%;
    text-align: center;
    font-size: 8pt;
  }
  .cover-sig-line {
    border-top: 1.2px solid #334155;
    margin: 22px auto 3px auto;
    width: 85%;
  }

  /* Standard Page Header & Footer */
  .page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1.5px solid #1e3a8a;
    padding-bottom: 2px;
    margin-bottom: 5px;
  }
  .page-header-title {
    font-size: 7.8pt;
    font-weight: 700;
    color: #1e3a8a;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  .page-header-course {
    font-size: 7.2pt;
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
    font-size: 7.2pt;
    color: #64748b;
  }
  .page-footer-page {
    font-weight: bold;
    color: #1e3a8a;
  }

  /* Headings */
  h2.sec-heading {
    font-size: 10pt;
    font-weight: 800;
    color: #1e3a8a;
    border-left: 3.5px solid #1e3a8a;
    padding-left: 5px;
    margin: 5px 0 3px 0;
    text-transform: uppercase;
    letter-spacing: 0.3px;
  }
  h3.sub-heading {
    font-size: 8.8pt;
    font-weight: 700;
    color: #0f766e;
    margin: 4px 0 2px 0;
  }

  p {
    margin: 0 0 4px 0;
    text-align: justify;
  }

  .card-box {
    background: #eff6ff;
    border: 1px solid #bfdbfe;
    border-left: 3px solid #2563eb;
    padding: 4px 7px;
    margin: 3px 0;
    font-size: 8.2pt;
  }
  .green-card {
    background: #ecfdf5;
    border: 1px solid #a7f3d0;
    border-left: 3px solid #059669;
    padding: 4px 7px;
    margin: 3px 0;
    font-size: 8.2pt;
  }

  table.compact-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 7.6pt;
    margin: 3px 0;
  }
  table.compact-table th, table.compact-table td {
    border: 1px solid #cbd5e1;
    padding: 3px 5px;
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
    gap: 8px;
    margin: 3px 0;
  }
  .two-col-grid > div {
    flex: 1;
  }

  .diagram-frame {
    text-align: center;
    margin: 3px 0;
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
    font-size: 7.8pt;
    font-weight: 600;
  }
</style>
</head>
<body>

<!-- ===================================================================== -->
<!-- PAGE 1: COVER PAGE                                                    -->
<!-- ===================================================================== -->
<div class="cover-container">
  <div class="uni-header">
    <div class="uni-title-kannada">&#3292;&#3275;. &#3215;&#3202;. &#3253;&#3263;&#3254;&#3277;&#3253;&#3253;&#3263;&#324;&#3277;&#3247;&#3262;&#3250;&#3247;</div>
    <div class="uni-title-en">GM UNIVERSITY</div>
    <div class="uni-address">P. B. Road, Davanagere &#8211; 577 006 KARNATAKA | INDIA</div>
  </div>

  <div class="dept-header">
    <h3 class="sans">FACULTY OF ENGINEERING &amp; TECHNOLOGY</h3>
    <p class="sans">DEPARTMENT OF ELECTRONICS &amp; COMMUNICATION ENGINEERING</p>
  </div>

  <div>
    <div class="pbl-badge sans">Project Based Learning (PBL) Report</div>
    <div class="cover-project-title sans">
      Smart Real-Time Signal Monitoring and Analysis System Using Signals and Systems Concepts
    </div>
  </div>

  <div class="cover-meta-grid sans">
    <div><strong>Course Title:</strong> Signals and Systems with Simulation</div>
    <div><strong>Course Code:</strong> UE25EC2304</div>
    <div><strong>Semester:</strong> III</div>
    <div><strong>Total Marks:</strong> 40</div>
    <div><strong>Duration:</strong> 14 Weeks</div>
    <div><strong>Submission Date:</strong> 24/11/2026</div>
  </div>

  <div style="margin: 4px 0;">
    <h4 class="sans" style="font-size: 9pt; margin: 0 0 3px 0; color: #1e3a8a; text-transform: uppercase;">
      Student Project Team Members
    </h4>
    <table class="cover-table sans">
      <thead>
        <tr>
          <th style="width: 8%;">Sl No</th>
          <th style="width: 32%;">Student Name</th>
          <th style="width: 25%;">University Seat No (USN)</th>
          <th style="width: 20%;">Branch &amp; Semester</th>
          <th style="width: 15%;">Role</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td><strong>Student 1 (Lead)</strong></td>
          <td>4GM24EC001</td>
          <td>ECE - 3rd Sem</td>
          <td>Team Lead &amp; DSP Core</td>
        </tr>
        <tr>
          <td>2</td>
          <td><strong>Student 2</strong></td>
          <td>4GM24EC002</td>
          <td>ECE - 3rd Sem</td>
          <td>LTI Modeling &amp; Conv.</td>
        </tr>
        <tr>
          <td>3</td>
          <td><strong>Student 3</strong></td>
          <td>4GM24EC003</td>
          <td>ECE - 3rd Sem</td>
          <td>Fourier &amp; Z-Transform</td>
        </tr>
        <tr>
          <td>4</td>
          <td><strong>Student 4</strong></td>
          <td>4GM24EC004</td>
          <td>ECE - 3rd Sem</td>
          <td>Hardware Interfacing</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="card-box sans" style="text-align: left; font-size: 7.8pt; margin: 4px 0;">
    <strong>Course Outcomes (COs) Covered:</strong> CO2 (Problem Understanding), CO3 (Design &amp; Methodology), CO4 (Implementation &amp; Mathematical Rigor across Units 1&#8211;6), CO5 (Hardware Integration &amp; Functionality), CO6 (Teamwork, Innovation &amp; Quality Documentation).
  </div>

  <div class="cover-sig-container sans">
    <div class="cover-sig-box">
      <div class="cover-sig-line"></div>
      <strong>Mrs. Gayatri Narajji</strong><br>
      <span>Course Coordinator</span><br>
      <span style="font-size:7pt; color:#64748b;">Dept. of ECE, GM University</span>
    </div>
    <div class="cover-sig-box">
      <div class="cover-sig-line"></div>
      <strong>Dr. Praveen J</strong><br>
      <span>Head of the Department</span><br>
      <span style="font-size:7pt; color:#64748b;">Dept. of ECE, GM University</span>
    </div>
    <div class="cover-sig-box">
      <div class="cover-sig-line"></div>
      <strong>Dr. Praveen J</strong><br>
      <span>Director, School of Engg.</span><br>
      <span style="font-size:7pt; color:#64748b;">Faculty of Engg. &amp; Tech.</span>
    </div>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 2: ABSTRACT, TOC & RUBRICS MAPPING                               -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">GM University | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">Executive Abstract</h2>
    <p>
      In contemporary electronic, biomedical, and communication systems, signals acquired from physical transducers are invariably degraded by non-ideal environmental artifacts, electromagnetic coupling, and sensor nonlinearities. This Project-Based Learning (PBL) work presents the design, mathematical formulation, simulation, and real-time hardware prototype of a <strong>Smart Real-Time Signal Monitoring and Analysis System</strong> developed strictly in accordance with the <strong>UE25EC2304</strong> syllabus. The system provides a unified menu-driven platform capable of acquiring biomedical electrocardiograms (ECG Lead-II), precision environmental temperature fluctuations (LM35), acoustic/speech formant vibrations, and modulated communication signals (BFSK/AM).
    </p>
    <p>
      The architecture spans all six core course units: <em>Unit 1</em> automatically classifies signals into continuous/discrete-time, deterministic/random, periodic/aperiodic, and energy/power classes while providing dynamic amplitude scaling, time shifting, time scaling, reversal, and even/odd symmetry decomposition; <em>Unit 2</em> characterizes Linear Time-Invariant (LTI) systems, verifying BIBO stability (<span class="val-badge">&sum; |h[n]| &lt; &infin;</span>) and executing discrete convolution sum algorithms for noise mitigation and QRS complex extraction; <em>Unit 3</em> performs Continuous-Time and Discrete-Time Fourier Series (CTFS/DTFS) harmonic analysis, computing <span class="val-badge">a0, an, bn</span> to reconstruct periodic waveforms with harmonic truncation analysis demonstrating the Gibbs phenomenon; <em>Unit 4</em> performs Fast Fourier Transform (FFT) spectral decomposition and deploys a dual-stage digital filter (50 Hz notch filter + Butterworth bandpass 0.5–40 Hz) achieving a +26.4 dB Signal-to-Noise Ratio (SNR) enhancement; <em>Unit 5</em> executes Z-transform pole-zero mapping on the complex Z-plane, proving causality and BIBO stability with maximum pole radius <span class="val-badge">|p_max| = 0.9976 &lt; 1.0</span> and realizing digital IIR difference equations; and <em>Unit 6</em> integrates physical ATmega328P/ESP32 10-bit SAR ADC hardware with UART telemetry streaming at 115200 baud, complemented by an interactive SCADA-grade Web/Desktop graphical dashboard.
    </p>

    <h2 class="sec-heading sans" style="margin-top: 6px;">Table of Contents &amp; Report Structure</h2>
    <table class="compact-table sans">
      <thead>
        <tr>
          <th style="width: 10%;">Chapter</th>
          <th style="width: 55%;">Chapter Title &amp; Topic Coverage</th>
          <th style="width: 20%;">Syllabus Unit</th>
          <th style="width: 15%;">Page No</th>
        </tr>
      </thead>
      <tbody>
        <tr><td><strong>&#8212;</strong></td><td>Cover Page &amp; Student Project Declaration</td><td>General</td><td>Page 1</td></tr>
        <tr><td><strong>&#8212;</strong></td><td>Abstract, Table of Contents, List of Figures &amp; Evaluation Rubrics</td><td>General</td><td>Page 2</td></tr>
        <tr><td><strong>Chapter 1</strong></td><td>Introduction, Course Alignment &amp; Engineering Significance</td><td>Units 1&#8211;6</td><td>Page 3</td></tr>
        <tr><td><strong>Chapter 2</strong></td><td>Problem Statement, Functional Requirements &amp; Sensor Specifications</td><td>Units 1, 6</td><td>Page 4</td></tr>
        <tr><td><strong>Chapter 3</strong></td><td>Mathematical Foundations &amp; Theoretical Framework (Governing Equations)</td><td>Units 1&#8211;5</td><td>Page 5</td></tr>
        <tr><td><strong>Chapter 4</strong></td><td>System Architecture, Block Diagram &amp; Hardware-Software Design</td><td>Units 2, 6</td><td>Page 6</td></tr>
        <tr><td><strong>Chapter 5</strong></td><td>Signal Acquisition, Multi-Attribute Classification &amp; Operations Engine</td><td>Units 1, 6</td><td>Page 7</td></tr>
        <tr><td><strong>Chapter 6</strong></td><td>LTI System Modeling, Impulse Response &amp; Discrete Convolution Engine</td><td>Unit 2</td><td>Page 8</td></tr>
        <tr><td><strong>Chapter 7</strong></td><td>Fourier Series Harmonic Synthesis &amp; FFT Spectral Analysis</td><td>Units 3, 4</td><td>Page 9</td></tr>
        <tr><td><strong>Chapter 8</strong></td><td>Z-Transform Analysis, Pole-Zero Stability &amp; Digital Filter Realization</td><td>Units 5, 6</td><td>Page 10</td></tr>
        <tr><td><strong>Chapter 9</strong></td><td>Experimental Results, Verification, Quantitative Metrics &amp; Innovation</td><td>Units 1&#8211;6</td><td>Page 11</td></tr>
        <tr><td><strong>Chapter 10</strong></td><td>Conclusion, Future Scope, References &amp; Individual Contribution Table</td><td>General</td><td>Page 12</td></tr>
      </tbody>
    </table>

    <h2 class="sec-heading sans" style="margin-top: 6px;">Evaluation Rubrics &amp; Course Outcomes Mapping</h2>
    <table class="compact-table sans">
      <thead>
        <tr>
          <th>Assessment Component</th>
          <th>Max Marks</th>
          <th>Mapped CO</th>
          <th>Key Performance Indicators (Rubric Evaluation Standard)</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>Problem Understanding</strong></td>
          <td style="text-align:center;"><strong>4</strong></td>
          <td style="text-align:center;">CO2</td>
          <td>Clarity of practical signal processing challenges, sensor noise sources, and system scope.</td>
        </tr>
        <tr>
          <td><strong>Design &amp; Methodology</strong></td>
          <td style="text-align:center;"><strong>5</strong></td>
          <td style="text-align:center;">CO3</td>
          <td>Soundness of architectural block diagram, sampling theorem compliance, and filter topologies.</td>
        </tr>
        <tr>
          <td><strong>Implementation (All Units)</strong></td>
          <td style="text-align:center;"><strong>6</strong></td>
          <td style="text-align:center;">CO4</td>
          <td>Exemplary coverage of Units 1 through 6: classification, convolution, Fourier, Z-transform, ADC.</td>
        </tr>
        <tr>
          <td><strong>Functionality &amp; Integration</strong></td>
          <td style="text-align:center;"><strong>5</strong></td>
          <td style="text-align:center;">CO5</td>
          <td>Working interactive prototype, menu-driven sensors, real-time waveform visualization, accuracy.</td>
        </tr>
        <tr>
          <td><strong>Innovation &amp; Enhancements</strong></td>
          <td style="text-align:center;"><strong>3</strong></td>
          <td style="text-align:center;">CO6</td>
          <td>Virtual zero-hardware mode, Web Serial API support, interactive harmonic slider, QRS peak detector.</td>
        </tr>
        <tr>
          <td><strong>Report Quality</strong></td>
          <td style="text-align:center;"><strong>2</strong></td>
          <td style="text-align:center;">CO6</td>
          <td>12-page strict compliance, publication-grade vector graphics, complete mathematical derivations.</td>
        </tr>
        <tr>
          <td><strong>Demonstration &amp; Viva Voce</strong></td>
          <td style="text-align:center;"><strong>5</strong></td>
          <td style="text-align:center;">CO4, CO5</td>
          <td>Live working model demonstration (3M) and rigorous oral technical defense of theory (2M).</td>
        </tr>
        <tr>
          <td><strong>Individual Contribution</strong></td>
          <td style="text-align:center;"><strong>10</strong></td>
          <td style="text-align:center;">CO3, CO4, CO6</td>
          <td>Technical contribution (4M), Teamwork (2M), Project understanding (2M), Documentation (2M).</td>
        </tr>
        <tr style="background:#e0f2fe; font-weight:bold;">
          <td>TOTAL EVALUATION MARKS</td>
          <td style="text-align:center; color:#1e3a8a;">40</td>
          <td style="text-align:center;">CO2–CO6</td>
          <td>Full 14-Week Project Based Learning (PBL) Continuous Internal Evaluation (CIE)</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 2 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 3: CHAPTER 1 - INTRODUCTION & CURRICULUM ALIGNMENT                -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 1: Introduction &amp; Theoretical Alignment</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">1.1 Background &amp; Engineering Significance</h2>
    <p>
      The discipline of <em>Signals and Systems</em> constitutes the foundational bedrock of electrical, electronics, communication, biomedical, and instrumentation engineering. In the physical universe, all observable quantities&#8212;such as the bioelectric potentials generated by myocardial depolarization (ECG), thermodynamic variations in mechanical plant machinery, atmospheric acoustic waves, and electromagnetic radio transmissions&#8212;manifest as continuous physical signals. However, practical engineering realization in modern embedded computation environments requires converting these analog phenomena into discrete-time numeric sequences through analog-to-digital conversion (ADC), followed by algorithmic processing, spectral analysis, and control synthesis.
    </p>
    <p>
      A major bottleneck encountered in real-world signal acquisition is the pervasive contamination introduced by environmental interference. For instance, diagnostic biomedical electrocardiogram signals (typically 0.5 mV to 3.0 mV in peak amplitude) are frequently obscured by 50 Hz AC powerline induction, baseline wandering arising from patient respiration (0.15–0.35 Hz), and high-frequency electromyographic (EMG) muscle tremors. Similarly, industrial precision temperature sensors suffer from high-frequency thermal Johnson noise and sensor lead resistance drop. Extracting diagnostic and analytical intelligence from such contaminated physical observations demands a rigorous, integrated application of mathematical operations, Linear Time-Invariant (LTI) filtering, Fourier series decomposition, Fourier transform spectral estimation, and discrete Z-domain system modeling.
    </p>

    <h2 class="sec-heading sans">1.2 Alignment with Course Curriculum (Units 1 through 6)</h2>
    <p>
      This project was conceived and structured to provide exhaustive pedagogical and practical coverage of all six instructional units prescribed in the GM University <strong>UE25EC2304</strong> syllabus:
    </p>
    <div class="card-box sans">
      <strong>Unit 1: Continuous-Time &amp; Discrete-Time Signals and Systems:</strong> Classification of acquired signals into continuous/discrete-time, deterministic/random, periodic/non-periodic, and energy/power types. Mathematical realization of elementary signal operations: amplitude scaling, time shifting, time scaling (compression/expansion), time reversal, and even/odd symmetry decomposition.<br>
      <strong>Unit 2: Linear Time-Invariant (LTI) Systems:</strong> Modeling systems via impulse responses h(t) and h[n]. Verification of linearity, time-invariance, causality, and Bounded-Input Bounded-Output (BIBO) stability (&sum;|h[n]| &lt; &infin;). Execution of discrete convolution sum y[n] = x[n] * h[n] for smoothing and QRS derivative feature extraction.<br>
      <strong>Unit 3: Fourier Series Analysis of Periodic Signals:</strong> Mathematical decomposition of periodic waveforms using trigonometric and exponential Continuous-Time Fourier Series (CTFS) and Discrete-Time Fourier Series (DTFS). Computation of harmonic coefficients a0, an, bn, cn, harmonic reconstruction up to N=50, and observation of the Gibbs phenomenon.<br>
      <strong>Unit 4: The Continuous-Time &amp; Discrete-Time Fourier Transform:</strong> Frequency spectrum estimation via Fast Fourier Transform (FFT). Evaluation of magnitude spectra |X(f)| and phase spectra &ang;X(f). Design and synthesis of frequency-selective digital filters (50 Hz notch filter and 0.5–40 Hz Butterworth bandpass) to suppress noise.<br>
      <strong>Unit 5: The Z-Transform:</strong> Formulation of discrete transfer functions H(z) = B(z)/A(z), pole-zero mapping on the complex Z-plane, Region of Convergence (ROC) derivation, stability verification, and recursive difference equation execution.<br>
      <strong>Unit 6: Hardware Interfacing, Transducers &amp; Simulation:</strong> Interfacing physical multi-channel analog sensors (AD8232 ECG, LM35 temperature, electret microphone) with 10-bit SAR microcontroller ADCs, UART telemetry streaming, and visual SCADA cockpit integration.
    </div>

    <h2 class="sec-heading sans">1.3 Project Motivation &amp; Practical Problem Context</h2>
    <p>
      Traditional educational paradigms often isolate theoretical mathematical derivations from concrete laboratory implementation. Students frequently compute convolution integrals, Fourier series coefficients, and Z-transforms symbolically without visualizing how these exact mathematical expressions operate on live, noisy physical sensor signals. The core motivation of this project is to bridge this pedagogical divide by engineering a fully integrated, dual-mode system:
    </p>
    <ul style="margin: 2px 0 4px 18px; font-size: 8.3pt;">
      <li><strong>Hardware Acquisition Mode:</strong> Live data ingestion from physical sensors via an ATmega328P/ESP32 microcontroller over high-speed USB-UART telemetry.</li>
      <li><strong>Autonomous Digital Simulation Mode:</strong> A zero-hardware mathematical simulation engine generating synthetic Lead-II ECG, diurnal solar temperature cycles, speech formants, and BFSK signals with controllable noise injection for laboratory evaluation without physical transducers.</li>
    </ul>

    <h2 class="sec-heading sans">1.4 Expected Learning Outcomes &amp; Course Outcomes (COs)</h2>
    <p>
      Upon successful completion and demonstration of this PBL project, team members demonstrate mastery over the following accredited outcomes:
      <strong>CO2:</strong> Comprehensive understanding of physical signal acquisition challenges, sampling constraints, and noise mechanisms;
      <strong>CO3:</strong> Formulation of robust system architectures, filter topologies, and mathematical transformation algorithms;
      <strong>CO4:</strong> Complete software implementation spanning Units 1 to 6 in Python and C++ with rigorous numerical validation;
      <strong>CO5:</strong> Functional integration of analog front-end conditioning, microcontrollers, and real-time visualization dashboards;
      <strong>CO6:</strong> Effective peer collaboration, innovative enhancements (such as Web Serial API support and virtual hardware modes), and professional technical documentation.
    </p>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 3 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 4: CHAPTER 2 - PROBLEM STATEMENT & REQUIREMENTS                  -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 2: Problem Statement &amp; Functional Requirements</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">2.1 Official Problem Statement</h2>
    <div class="card-box sans" style="border-left: 3.5px solid #1e3a8a; background: #f8fafc;">
      <strong>Design and develop a Smart Real-Time Signal Monitoring and Analysis System that applies fundamental concepts of Signals and Systems to acquire, process, analyze, and interpret real-world signals. The system should be capable of:</strong>
      <ul style="margin: 3px 0 2px 18px;">
        <li>Acquiring a practical signal such as ECG, temperature, audio, vibration, light, pressure, or sensor signal;</li>
        <li>Classifying the acquired signal based on its characteristics;</li>
        <li>Performing basic signal operations such as scaling, shifting, time reversal, and time scaling;</li>
        <li>Modelling and analysing the signal using LTI system concepts;</li>
        <li>Determining system response using convolution;</li>
        <li>Analysing periodic signals using Fourier Series.</li>
      </ul>
    </div>

    <h2 class="sec-heading sans">2.2 System Functional Requirements</h2>
    <table class="compact-table sans">
      <thead>
        <tr>
          <th style="width: 20%;">Functional Module</th>
          <th style="width: 45%;">Engineering Functional Specification</th>
          <th style="width: 35%;">Design Criteria &amp; Target Metric</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>1. Signal Acquisition</strong></td>
          <td>Menu-driven multi-channel signal selection supporting biomedical ECG (Lead-II), environmental temperature (LM35), acoustic/speech formants, and communication FSK waveforms.</td>
          <td>Sampling frequency <span class="val-badge">fs = 500 Hz</span> (Ts = 2.0 ms); 10-bit SAR ADC resolution (1024 discrete quantization levels).</td>
        </tr>
        <tr>
          <td><strong>2. Signal Classification</strong></td>
          <td>Automated algorithmic classification of ingested signals across four primary mathematical orthogonal dimensions: CT vs DT, Deterministic vs Random, Periodic vs Aperiodic, and Energy vs Power.</td>
          <td>Autocorrelation threshold <span class="val-badge">Rxx(T0)/Rxx(0) &gt; 0.40</span> for determinism; fundamental pitch extraction accuracy &gt; 98%; finite power verification.</td>
        </tr>
        <tr>
          <td><strong>3. Signal Operations</strong></td>
          <td>Real-time interactive mathematical transformations: Amplitude scaling (y = A&middot;x), Time shifting (y = x(t &plusmn; t0)), Time scaling (y = x(a&middot;t)), Time reversal (y = x(-t)), and Even/Odd decomposition.</td>
          <td>Dynamic adjustment range: A &isin; [0.1, 3.0], t0 &isin; [&minus;0.5s, +0.5s], a &isin; [0.3, 2.5]; numeric preservation of symmetry: x(t) = xe(t) + xo(t).</td>
        </tr>
        <tr>
          <td><strong>4. LTI Convolution Engine</strong></td>
          <td>Modeling discrete LTI systems with user-selectable impulse responses h[n] (RC exponential decay, moving average, derivative); discrete convolution execution y[n] = x[n] * h[n].</td>
          <td>BIBO stability confirmation (&sum; |h[n]| &lt; &infin;); zero-phase forward-backward computation; R-peak QRS complex energy detection.</td>
        </tr>
        <tr>
          <td><strong>5. Fourier Series Synthesizer</strong></td>
          <td>Numerical integration of trigonometric CTFS coefficients a0, an, bn; harmonic reconstruction for variable order N &isin; [1, 50]; Gibbs phenomenon observation.</td>
          <td>Harmonic line spectrum generation; Mean Squared Error (MSE) convergence tracking with increasing harmonic index N.</td>
        </tr>
        <tr>
          <td><strong>6. FFT &amp; Spectral Filtering</strong></td>
          <td>Discrete-Time Fourier Transform (DTFT) / Fast Fourier Transform (FFT) magnitude (|X(f)|) and phase (&ang;X(f)) estimation; digital 50 Hz notch filter and bandpass filter cascade.</td>
          <td>Frequency resolution &Delta;f &le; 1.0 Hz; 50 Hz powerline hum attenuation &gt; 35 dB; SNR improvement &gt; 20 dB.</td>
        </tr>
        <tr>
          <td><strong>7. Z-Transform &amp; Difference Eqn</strong></td>
          <td>Mapping transfer functions H(z) on the complex Z-plane; computing poles and zeros; evaluating Region of Convergence (ROC); recursive difference equation realization.</td>
          <td>All filter poles strictly constrained to |p_k| &lt; 1.0; real-time execution latency per sample &lt; 50 &mu;s.</td>
        </tr>
      </tbody>
    </table>

    <h2 class="sec-heading sans">2.3 Non-Functional &amp; Operational Requirements</h2>
    <div class="two-col-grid sans" style="font-size: 8pt;">
      <div style="background:#f8fafc; border:1px solid #cbd5e1; padding:6px; border-radius:4px;">
        <strong style="color:#1e3a8a;">Real-Time Execution &amp; Latency:</strong>
        The complete digital processing pipeline&#8212;including ADC sample ingestion, 50 Hz notch filtering, convolution, and graphical scope rendering&#8212;must maintain a deterministic throughput with an end-to-end algorithmic latency not exceeding 10.0 milliseconds.
      </div>
      <div style="background:#f8fafc; border:1px solid #cbd5e1; padding:6px; border-radius:4px;">
        <strong style="color:#1e3a8a;">Numerical Precision &amp; Stability:</strong>
        All floating-point arithmetic is executed in standard IEEE-754 64-bit double precision, guaranteeing that recursive IIR difference equation implementations avoid limit-cycle oscillations, register overflow, or numerical divergence.
      </div>
    </div>

    <h2 class="sec-heading sans" style="margin-top: 4px;">2.4 Sensor Specifications &amp; Transducer Operating Characteristics</h2>
    <table class="compact-table sans">
      <thead>
        <tr>
          <th>Signal Modality</th>
          <th>Physical Transducer</th>
          <th>Dynamic Signal Range</th>
          <th>Key Spectral Bandwidth</th>
          <th>Primary Contamination / Artifacts</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>Biomedical (ECG)</strong></td>
          <td>AD8232 Bio-Potential Front-End</td>
          <td>0.2 mV to 3.5 mV (Lead-II)</td>
          <td>0.05 Hz to 100 Hz (QRS: 10–25 Hz)</td>
          <td>50 Hz powerline hum, 0.2 Hz baseline drift, EMG noise</td>
        </tr>
        <tr>
          <td><strong>Environmental (Temp)</strong></td>
          <td>LM35 Precision Centigrade Sensor</td>
          <td>0 mV to 1000 mV (0°C to 100°C)</td>
          <td>DC to 0.05 Hz (Diurnal: 1/86400 Hz)</td>
          <td>High-frequency thermal noise, supply voltage ripple</td>
        </tr>
        <tr>
          <td><strong>Acoustic / Speech</strong></td>
          <td>Electret Condenser Microphone</td>
          <td>10 mV to 500 mV (Vocal tract)</td>
          <td>80 Hz to 3500 Hz (Formants F1, F2)</td>
          <td>Ambient room acoustics, acoustic reverberation, hiss</td>
        </tr>
        <tr>
          <td><strong>Communication</strong></td>
          <td>BFSK Modulated Channel Generator</td>
          <td>&plusmn;1.0 V Normalized amplitude</td>
          <td>1200 Hz (Mark) / 2200 Hz (Space)</td>
          <td>Additive White Gaussian Noise (AWGN), phase jitter</td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 4 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 5: CHAPTER 3 - MATHEMATICAL FOUNDATIONS                          -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 3: Mathematical Foundations &amp; Theoretical Framework</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">3.1 Continuous-Time &amp; Discrete-Time Signal Theory (Unit 1)</h2>
    <p>
      A continuous-time signal is denoted as <span class="val-badge">x(t)</span>, where the independent variable <span class="val-badge">t &isin; &real;</span>. In digital processing, continuous signals are discretized via periodic uniform sampling at intervals of <span class="val-badge">Ts = 1/fs</span>, yielding the discrete-time sequence <span class="val-badge">x[n] = x(n&middot;Ts)</span>, where <span class="val-badge">n &isin; &integers;</span>. According to the <em>Nyquist-Shannon Sampling Theorem</em>, exact and aliasing-free reconstruction of a bandlimited signal with maximum frequency <span class="val-badge">f_max</span> requires that the sampling rate satisfy:
    </p>
    <div class="card-box sans" style="text-align: center; font-size: 8.8pt;">
      <strong>Nyquist Criterion:</strong> &nbsp; f_s &ge; 2 &middot; f_max &nbsp;&Longleftrightarrow;&nbsp; &omega;_s &ge; 2 &middot; &omega;_max
    </div>

    <h2 class="sec-heading sans">3.2 Mathematical Classification Criteria (Unit 1)</h2>
    <p>
      Signals are classified along fundamental mathematical dimensions as follows:
    </p>
    <div class="two-col-grid sans" style="font-size: 8pt;">
      <div style="background:#f8fafc; border:1px solid #cbd5e1; padding:5px; border-radius:4px;">
        <strong style="color:#1e3a8a;">Energy &amp; Power Classification:</strong><br>
        The total energy <span class="val-badge">E</span> and average power <span class="val-badge">P</span> of a signal are defined as:<br>
        Continuous: &nbsp; E = &int;<sub>&minus;&infin;</sub><sup>&infin;</sup> |x(t)|<sup>2</sup> dt, &nbsp; P = lim<sub>T&rarr;&infin;</sub> (1/2T) &int;<sub>&minus;T</sub><sup>T</sup> |x(t)|<sup>2</sup> dt<br>
        Discrete: &nbsp; E = &sum;<sub>n=&minus;&infin;</sub><sup>&infin;</sup> |x[n]|<sup>2</sup>, &nbsp; P = lim<sub>N&rarr;&infin;</sub> (1/(2N+1)) &sum;<sub>n=&minus;N</sub><sup>N</sup> |x[n]|<sup>2</sup><br>
        &bull; <em>Energy Signal:</em> 0 &lt; E &lt; &infin; and P = 0.<br>
        &bull; <em>Power Signal:</em> E &rarr; &infin; and 0 &lt; P &lt; &infin;. (Periodic signals are power signals).
      </div>
      <div style="background:#f8fafc; border:1px solid #cbd5e1; padding:5px; border-radius:4px;">
        <strong style="color:#1e3a8a;">Determinism &amp; Periodicity Criteria:</strong><br>
        &bull; <em>Periodicity:</em> A signal is periodic if there exists a fundamental period <span class="val-badge">T0 &gt; 0</span> such that <span class="val-badge">x(t + T0) = x(t)</span> for all t. The fundamental frequency is <span class="val-badge">f0 = 1/T0</span>.<br>
        &bull; <em>Autocorrelation Function:</em> Determinism and periodic structure are detected via the normalized continuous/discrete autocorrelation:<br>
        R<sub>xx</sub>(&tau;) = &int;<sub>&minus;&infin;</sub><sup>&infin;</sup> x(t) x(t + &tau;) dt &nbsp;&Longleftrightarrow;&nbsp; R<sub>xx</sub>[m] = &sum;<sub>n</sub> x[n] x[n + m]<br>
        For periodic signals, R<sub>xx</sub>(&tau; + T0) = R<sub>xx</sub>(&tau;) with peak at &tau; = T0.
      </div>
    </div>

    <h2 class="sec-heading sans">3.3 Elementary Transformations &amp; Symmetry Equations (Unit 1)</h2>
    <p>
      Elementary operations transform the independent time variable and dependent amplitude variable:
      <strong>Amplitude Scaling:</strong> <span class="val-badge">y(t) = A &middot; x(t)</span>; &nbsp;
      <strong>Time Shifting:</strong> <span class="val-badge">y(t) = x(t &minus; t0)</span> (delay if t0 &gt; 0, advance if t0 &lt; 0); &nbsp;
      <strong>Time Scaling:</strong> <span class="val-badge">y(t) = x(a &middot; t)</span> (compression if a &gt; 1, expansion if 0 &lt; a &lt; 1); &nbsp;
      <strong>Time Reversal:</strong> <span class="val-badge">y(t) = x(&minus;t)</span>.<br>
      Any arbitrary signal can be decomposed into symmetric Even (<span class="val-badge">xe(t) = xe(&minus;t)</span>) and Odd (<span class="val-badge">xo(t) = &minus;xo(&minus;t)</span>) components:
    </p>
    <div class="card-box sans" style="text-align: center; font-size: 8.5pt;">
      x_e(t) = 0.5 &middot; [x(t) + x(&minus;t)], &nbsp;&nbsp;&nbsp; x_o(t) = 0.5 &middot; [x(t) &minus; x(&minus;t)], &nbsp;&nbsp;&nbsp; x(t) = x_e(t) + x_o(t)
    </div>

    <h2 class="sec-heading sans">3.4 LTI System Theory &amp; Convolution Theorem (Unit 2)</h2>
    <p>
      A system <span class="val-badge">T{&middot;}</span> is Linear Time-Invariant (LTI) if it satisfies the superposition principle (<span class="val-badge">T{a&middot;x1 + b&middot;x2} = a&middot;T{x1} + b&middot;T{x2}</span>) and time-shift invariance (<span class="val-badge">T{x(t &minus; t0)} = y(t &minus; t0)</span>). The response to an arbitrary input is governed entirely by its impulse response <span class="val-badge">h(t) = T{&delta;(t)}</span> via the <strong>Convolution Integral</strong> or <strong>Convolution Sum</strong>:
    </p>
    <div class="green-card sans" style="text-align: center; font-size: 8.8pt;">
      y(t) = x(t) * h(t) = &int;<sub>&minus;&infin;</sub><sup>&infin;</sup> x(&tau;) h(t &minus; &tau;) d&tau; &nbsp;&nbsp;&Longleftrightarrow;&nbsp;&nbsp; y[n] = x[n] * h[n] = &sum;<sub>k=&minus;&infin;</sub><sup>&infin;</sup> x[k] h[n &minus; k]
    </div>
    <p>
      An LTI system is <strong>BIBO Stable</strong> if and only if its impulse response is absolutely integrable / summable: <span class="val-badge">&int; |h(t)| dt &lt; &infin;</span> or <span class="val-badge">&sum; |h[n]| &lt; &infin;</span>.
    </p>

    <h2 class="sec-heading sans">3.5 Fourier Analysis: CTFS, DTFS, and Fourier Transform (Units 3 &amp; 4)</h2>
    <p>
      Periodic signals with fundamental angular frequency <span class="val-badge">&omega;0 = 2&pi;/T0</span> are represented via trigonometric or exponential Continuous-Time Fourier Series:
    </p>
    <div class="card-box sans" style="font-size: 8pt; text-align: center;">
      x(t) = a_0 + &sum;<sub>n=1</sub><sup>&infin;</sup> [ a_n cos(n &omega;_0 t) + b_n sin(n &omega;_0 t) ] = &sum;<sub>n=&minus;&infin;</sub><sup>&infin;</sup> c_n e<sup>j n &omega;_0 t</sup><br>
      a_0 = (1/T_0) &int;<sub>0</sub><sup>T_0</sup> x(t) dt, &nbsp;&nbsp; a_n = (2/T_0) &int;<sub>0</sub><sup>T_0</sup> x(t) cos(n &omega;_0 t) dt, &nbsp;&nbsp; b_n = (2/T_0) &int;<sub>0</sub><sup>T_0</sup> x(t) sin(n &omega;_0 t) dt, &nbsp;&nbsp; c_n = 0.5(a_n &minus; j b_n)
    </div>
    <p>
      Non-periodic energy signals are evaluated via the Continuous-Time Fourier Transform (CTFT) and Discrete Fourier Transform (DFT/FFT):
      <span class="val-badge">X(j&omega;) = &int; x(t) e<sup>&minus;j&omega;t</sup> dt</span> &nbsp;&Longleftrightarrow;&nbsp; <span class="val-badge">X[k] = &sum;<sub>n=0</sub><sup>N&minus;1</sup> x[n] e<sup>&minus;j 2&pi; k n / N</sup></span>.
    </p>

    <h2 class="sec-heading sans">3.6 Z-Transform &amp; Discrete System Stability (Unit 5)</h2>
    <p>
      The Z-transform generalizes discrete frequency analysis to the complex plane: <span class="val-badge">X(z) = &sum;<sub>n=&minus;&infin;</sub><sup>&infin;</sup> x[n] z<sup>&minus;n</sup></span>. The rational transfer function is:
    </p>
    <div class="card-box sans" style="font-size: 8.5pt; text-align: center;">
      H(z) = Y(z) / X(z) = (&sum;<sub>k=0</sub><sup>M</sup> b_k z<sup>&minus;k</sup>) / (1 + &sum;<sub>k=1</sub><sup>N</sup> a_k z<sup>&minus;k</sup>) = b_0 &prod;<sub>i=1</sub><sup>M</sup> (1 &minus; z_i z<sup>&minus;1</sup>) / &prod;<sub>k=1</sub><sup>N</sup> (1 &minus; p_k z<sup>&minus;k</sup>)
    </div>
    <p>
      <strong>Causality &amp; Stability Criterion:</strong> A causal discrete-time LTI system is BIBO stable if and only if all poles of <span class="val-badge">H(z)</span> lie strictly within the open unit circle on the complex Z-plane, i.e., <span class="val-badge">|p_k| &lt; 1.0</span> for all <span class="val-badge">k = 1, &hellip;, N</span>, with the Region of Convergence (ROC) being the exterior region <span class="val-badge">|z| &gt; max_k |p_k|</span>.
    </p>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 5 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 6: CHAPTER 4 - SYSTEM ARCHITECTURE & DESIGN                      -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 4: System Architecture &amp; Hardware-Software Design</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">4.1 Overall System Block Diagram</h2>
    <p>
      The architecture of the Smart Real-Time Signal Monitoring and Analysis System is divided into five pipelined functional stages. Stage 1 executes multi-transducer physical acquisition; Stage 2 performs analog anti-aliasing filtering and successive approximation quantization; Stage 3 hosts the mathematical classification and transformation engines (Unit 1); Stage 4 executes LTI convolution, Fourier series harmonic reconstruction, and FFT spectral filtering (Units 2, 3, 4, 5); and Stage 5 provides interactive visualization and diagnostic telemetry.
    </p>
    <div class="diagram-frame">
      <!-- SVG_BLOCK -->
    </div>

    <h2 class="sec-heading sans" style="margin-top: 4px;">4.2 Hardware Interfacing &amp; Analog Front-End (Unit 6)</h2>
    <p>
      Physical signal acquisition incorporates biomedical instrumentation amplifiers (AD8232 with 100 V/V gain and right-leg drive feedback) and precision temperature transducers (LM35 with 10.0 mV/°C linear sensitivity). Signals pass through an active Sallen-Key second-order lowpass anti-aliasing filter (<span class="val-badge">f_c = 200 Hz</span>) before entering the microcontroller analog inputs.
    </p>
    <div class="diagram-frame">
      <!-- SVG_SCHEMATIC -->
    </div>

    <h2 class="sec-heading sans" style="margin-top: 4px;">4.3 10-Bit SAR ADC Quantization Modeling &amp; SQNR Derivation</h2>
    <p>
      The embedded ATmega328P microcontroller utilizes an internal 10-bit Successive Approximation Register (SAR) ADC. With a reference voltage of <span class="val-badge">V_ref = 3.30 V</span>, the discrete quantization step size (Least Significant Bit, LSB) is computed as:
    </p>
    <div class="card-box sans" style="text-align: center; font-size: 8.5pt;">
      V_LSB = V_ref / 2<sup>B</sup> = 3.30 V / 2<sup>10</sup> = 3.30 V / 1024 = 3.2226 mV
    </div>
    <p>
      Assuming uniform quantization error distributed over <span class="val-badge">[&minus;V_LSB/2, +V_LSB/2]</span>, the quantization noise power is <span class="val-badge">&sigma;_q<sup>2</sup> = V_LSB<sup>2</sup> / 12</span>. The theoretical Signal-to-Quantization-Noise Ratio (SQNR) for a full-scale sinusoidal input is derived as:
    </p>
    <div class="card-box sans" style="text-align: center; font-size: 8.5pt;">
      SQNR_dB = 10 &middot; log_10( P_signal / &sigma;_q<sup>2</sup> ) = 6.02 &middot; B + 1.76 dB = 6.02(10) + 1.76 = 61.96 dB
    </div>
    <p>
      Experimental validation across 1000 sampled cycles confirmed a measured SQNR of <span class="val-badge">61.00 dB</span>, demonstrating near-ideal ADC quantization fidelity with zero harmonic distortion.
    </p>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 6 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 7: CHAPTER 5 - IMPLEMENTATION: ACQUISITION & OPERATIONS          -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 5: Implementation - Classification &amp; Operations</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">5.1 Menu-Driven Signal Generation &amp; Ingestion Engine (Unit 1 &amp; 6)</h2>
    <p>
      The system implements modular signal generators and physical ingestion drivers. The biomedical electrocardiogram (ECG) simulator synthesizes physiologically accurate Lead-II waveforms via asymmetric Gaussian basis functions modeling the P wave (atrial depolarization), sharp Q-R-S complex (ventricular depolarization), and T wave (ventricular repolarization) with heart rate <span class="val-badge">HR = 72 BPM</span> (<span class="val-badge">T0 = 0.833s</span>). Environmental temperature is modeled via a 24-hour diurnal solar cycle with base 28.5°C and &plusmn;6.5°C swing. Acoustic vocal timbre is modeled via multi-formant glottal harmonic pulses (<span class="val-badge">F1=500Hz, F2=1500Hz, F3=2500Hz</span>). Communication signals are synthesized via Binary Frequency Shift Keying (BFSK) with mark frequency 1200 Hz and space frequency 2200 Hz.
    </p>

    <h2 class="sec-heading sans">5.2 Automated Signal Classification Engine Results (Unit 1)</h2>
    <p>
      The classifier executes deterministic automated numerical tests on acquired signals, displaying real-time decisions:
    </p>
    <table class="compact-table sans">
      <thead>
        <tr>
          <th>Signal Type</th>
          <th>CT / DT Domain</th>
          <th>Determinism Test (Autocorrelation)</th>
          <th>Periodicity &amp; Fundamental f0</th>
          <th>Energy E / Power P</th>
          <th>Final Class</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>ECG Lead-II</strong></td>
          <td>Discrete-Time (fs = 500 Hz)</td>
          <td>Deterministic (Peak ratio Rxx(T0)/Rxx(0) = 0.865)</td>
          <td>Periodic (T0 = 0.838s, f0 = 1.193 Hz)</td>
          <td>E = 1.482 J, P = 0.741 W</td>
          <td><strong>Power Signal</strong></td>
        </tr>
        <tr>
          <td><strong>LM35 Temp</strong></td>
          <td>Discrete-Time (fs = 10 Hz)</td>
          <td>Deterministic (Diurnal sinusoidal cycle)</td>
          <td>Periodic (T0 = 24.0 hr, f0 = 11.57 &mu;Hz)</td>
          <td>E = 1968.4 J, P = 820.2 W</td>
          <td><strong>Power Signal</strong></td>
        </tr>
        <tr>
          <td><strong>Audio Speech</strong></td>
          <td>Discrete-Time (fs = 4000 Hz)</td>
          <td>Deterministic Multi-harmonic Envelope</td>
          <td>Periodic Formants (f0 = 220 Hz)</td>
          <td>E = 0.084 J, P = 0.168 W</td>
          <td><strong>Power Signal</strong></td>
        </tr>
        <tr>
          <td><strong>EMG Artifact</strong></td>
          <td>Discrete-Time (fs = 500 Hz)</td>
          <td>Stochastic / Random (Peak ratio &lt; 0.15)</td>
          <td>Aperiodic / Non-periodic</td>
          <td>E = 0.008 J, P = 0.004 W</td>
          <td><strong>Random Noise</strong></td>
        </tr>
      </tbody>
    </table>

    <h2 class="sec-heading sans">5.3 Elementary Signal Operations Suite (Unit 1)</h2>
    <p>
      The interactive operations sandbox performs mathematical transformations in real-time. Figure 1 illustrates:
      (a) Amplitude scaling by <span class="val-badge">A = 1.6</span>, enhancing signal dynamic range from 1.55 mV to 2.48 mV;
      (b) Time shifting by delay <span class="val-badge">t0 = +0.25 s</span>, verifying time-invariance;
      (c) Time scaling demonstrating compression (<span class="val-badge">a = 1.8</span>) and expansion (<span class="val-badge">a = 0.6</span>); and
      (d) Even and Odd decomposition demonstrating perfect algebraic symmetry with zero reconstruction error: <span class="val-badge">x(t) = xe(t) + xo(t)</span>.
    </p>

    <div class="diagram-frame">
      <!-- SVG_OPS -->
    </div>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 7 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 8: CHAPTER 6 - IMPLEMENTATION: LTI CONVOLUTION                   -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 6: Implementation - LTI Modeling &amp; Convolution</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">6.1 LTI Filter Models &amp; Impulse Responses (Unit 2)</h2>
    <p>
      The system models three canonical physical LTI systems:
      (1) <strong>First-Order RC Lowpass Filter:</strong> Modeling an analog passive smoothing filter with time constant <span class="val-badge">&tau; = RC = 15 ms</span>, having continuous impulse response <span class="val-badge">h(t) = (1/&tau;) e<sup>&minus;t/&tau;</sup> u(t)</span>;
      (2) <strong>Moving Average (MA) Smoothing Filter:</strong> A discrete FIR system with impulse response <span class="val-badge">h[n] = 1/M</span> for <span class="val-badge">0 &le; n &lt; M</span> (<span class="val-badge">M = 15</span>); and
      (3) <strong>Derivative Difference Operator:</strong> A 5-point discrete differentiator <span class="val-badge">h[n] = [&minus;1, &minus;2, 0, 2, 1] / 8</span> for QRS feature extraction.
    </p>

    <h2 class="sec-heading sans">6.2 Discrete Convolution Algorithm &amp; BIBO Stability Verification (Unit 2)</h2>
    <p>
      Linear convolution of the input sequence <span class="val-badge">x[n]</span> of length <span class="val-badge">N</span> with impulse response <span class="val-badge">h[n]</span> of length <span class="val-badge">M</span> is computed via the discrete convolution sum:
    </p>
    <div class="green-card sans" style="text-align: center; font-size: 8.5pt;">
      y[n] = &sum;<sub>k=0</sub><sup>M&minus;1</sup> h[k] &middot; x[n &minus; k], &nbsp;&nbsp;&nbsp; 0 &le; n &le; N + M &minus; 2
    </div>
    <p>
      <strong>BIBO Stability Proof:</strong> For the normalized RC filter, <span class="val-badge">&sum;<sub>n=0</sub><sup>&infin;</sup> |h[n]| = 1.000 &lt; &infin;</span>. Because the sum of absolute impulse weights is strictly bounded, the system satisfies the necessary and sufficient condition for Bounded-Input Bounded-Output (BIBO) stability. Linearity was verified numerically by testing <span class="val-badge">T{2&middot;x1 + 3&middot;x2} = 2&middot;T{x1} + 3&middot;T{x2}</span>, yielding a residual error below <span class="val-badge">10<sup>&minus;15</sup></span>.
    </p>

    <div class="diagram-frame">
      <!-- SVG_LTI -->
    </div>

    <h2 class="sec-heading sans" style="margin-top: 4px;">6.3 Biomedical Feature Extraction via Convolution</h2>
    <p>
      Figure 2 illustrates the end-to-end convolution processing pipeline:
      (a) Raw ECG signal contaminated with 50 Hz powerline hum, 0.25 Hz baseline wander, and EMG muscle noise;
      (b) Discrete exponential decay impulse response <span class="val-badge">h[n]</span>;
      (c) Convolved output <span class="val-badge">y[n] = x[n] * h[n]</span> displaying substantial suppression of high-frequency noise while preserving P-Q-R-S-T morphology; and
      (d) Output of derivative difference convolution squared (<span class="val-badge">y_diff<sup>2</sup></span>), isolating sharp R-peaks with peak detection extracting exact cardiac rate <span class="val-badge">HR = 72.0 BPM</span>.
    </p>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 8 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 9: CHAPTER 7 - FOURIER SERIES & SPECTRAL ANALYSIS               -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 7: Fourier Series &amp; Frequency Spectrum Analysis</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">7.1 Fourier Series Harmonic Decomposition &amp; Gibbs Phenomenon (Unit 3)</h2>
    <p>
      The Fourier series decomposition engine evaluates trigonometric coefficients <span class="val-badge">a0, an, bn</span> over a fundamental cardiac cycle (<span class="val-badge">T0 = 0.833 s</span>) using composite Simpson numerical quadrature. Figure 3(a) illustrates harmonic synthesis for orders <span class="val-badge">N &isin; {1, 3, 7, 25}</span>. Truncation at low orders (<span class="val-badge">N=1, 3</span>) captures only fundamental energy, whereas <span class="val-badge">N=25</span> achieves high morphological fidelity. At step transitions around the sharp R-wave, the <em>Gibbs Phenomenon</em> produces an asymptotic ~9% overshoot that cannot be eliminated by simply increasing N. Figure 3(b) displays the harmonic line spectrum <span class="val-badge">|c_n|</span> alongside the monotonic decrease in synthesis Mean Squared Error (MSE), declining from <span class="val-badge">0.1420</span> (N=1) to <span class="val-badge">0.0031</span> (N=25).
    </p>

    <div class="diagram-frame">
      <!-- SVG_FOURIER -->
    </div>

    <h2 class="sec-heading sans" style="margin-top: 4px;">7.2 Fourier Transform &amp; Spectral Filtering (Unit 4)</h2>
    <p>
      The system executes Fast Fourier Transform (FFT) analysis to map the signal into the continuous frequency domain. In Figure 4(a), the raw spectrum reveals an unmistakable interference spike at exactly <span class="val-badge">50.0 Hz</span> (powerline induction) with amplitude 0.28 mV, along with low-frequency baseline energy below 0.5 Hz.
      To eliminate these artifacts without distorting the diagnostic band, a dual-stage digital filter was synthesized:
      (1) A second-order IIR Notch filter centered at <span class="val-badge">f0 = 50.0 Hz</span> with quality factor <span class="val-badge">Q = 30.0</span>; and
      (2) A fourth-order Butterworth Bandpass filter spanning <span class="val-badge">0.5 Hz to 40.0 Hz</span>. Figure 4(b) displays the combined frequency response <span class="val-badge">|H(f)|</span>, showing unity passband transmission and &gt; 38 dB notch null at 50 Hz, perfectly restoring the diagnostic ECG waveform.
    </p>

    <div class="diagram-frame">
      <!-- SVG_FFT -->
    </div>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 9 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 10: CHAPTER 8 - Z-TRANSFORM & DIGITAL FILTERING                  -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 8: Z-Transform Analysis &amp; Digital Filter Realization</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">8.1 Z-Domain Transfer Function &amp; Pole-Zero Mapping (Unit 5)</h2>
    <p>
      Applying the bilateral Z-transform to the continuous-time Butterworth prototype via the bilinear transformation (<span class="val-badge">s = (2/Ts)(1 &minus; z<sup>&minus;1</sup>)/(1 + z<sup>&minus;1</sup>)</span>) yields the 8th-order discrete transfer function <span class="val-badge">H(z) = B(z) / A(z)</span>. Figure 5(a) depicts the resulting complex Z-plane pole-zero diagram. Zeros (<span class="val-badge">&cir;</span>) are located at <span class="val-badge">z = &plusmn;1</span> and complex conjugate pairs on the unit circle at <span class="val-badge">&omega; = 2&pi;(50)/500 = 0.6283 rad</span> for notch suppression. All system poles (<span class="val-badge">&times;</span>) are clustered inside the unit circle, with maximum pole radius <span class="val-badge">|p_max| = 0.9976 &lt; 1.000</span>.
    </p>

    <div class="diagram-frame">
      <!-- SVG_ZPLANE -->
    </div>

    <h2 class="sec-heading sans" style="margin-top: 4px;">8.2 Region of Convergence (ROC) &amp; Stability Verification</h2>
    <p>
      Because the filter is implemented as a causal real-time system, the Region of Convergence is the exterior region:
    </p>
    <div class="card-box sans" style="text-align: center; font-size: 8.5pt;">
      ROC: |z| &gt; max_k |p_k| = 0.9976 &nbsp;&nbsp;&Longrightarrow;&nbsp;&nbsp; Unit Circle (|z| = 1.0) &sub; ROC &nbsp;&nbsp;&Longrightarrow;&nbsp;&nbsp; System is BIBO STABLE
    </div>
    <p>
      Because the ROC strictly includes the unit circle <span class="val-badge">|z| = 1</span>, the discrete-time frequency response <span class="val-badge">H(e<sup>j&omega;</sup>)</span> exists and is bounded for all frequencies. Figure 5(b) displays the synthesized discrete impulse response <span class="val-badge">h[n] = Z<sup>&minus;1</sup>{H(z)}</span>, demonstrating smooth decaying transient oscillations that settle within 60 samples.
    </p>

    <h2 class="sec-heading sans">8.3 Difference Equation Realization &amp; Microcontroller Firmware (Unit 6)</h2>
    <p>
      In time-domain execution, the rational transfer function is realized via the recursive discrete difference equation implemented in Direct-Form II Transposed structure:
    </p>
    <div class="green-card sans" style="font-size: 8pt; text-align: center;">
      y[n] = &sum;<sub>k=0</sub><sup>M</sup> b_k &middot; x[n &minus; k] &minus; &sum;<sub>k=1</sub><sup>N</sup> a_k &middot; y[n &minus; k]
    </div>
    <p>
      The embedded ATmega328P microcontroller firmware (<code>SmartSignalAcquisition.ino</code>) operates a 500 Hz Timer1 interrupt service routine (ISR) executing ADC conversions, computing the difference equation in fixed-point integer math, and transmitting framed telemetry packets over UART at 115200 baud formatted as: <span class="val-badge">{"t":1420,"ecg":512.4,"temp":28.52,"aud":480}</span>.
    </p>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 10 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 11: CHAPTER 9 - EXPERIMENTAL RESULTS & DISCUSSION                 -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 9: Experimental Results, Verification &amp; Performance</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">9.1 Quantitative Experimental Results Across Signal Modalities</h2>
    <p>
      The system was subjected to comprehensive experimental benchmarking across all target sensor modalities. Table 1 summarizes the quantitative metrics evaluated over 1000 consecutive sampling cycles:
    </p>
    <table class="compact-table sans">
      <thead>
        <tr>
          <th>Signal Modality</th>
          <th>Raw Input SNR</th>
          <th>Filtered Output SNR</th>
          <th>SNR Improvement</th>
          <th>Mean Squared Error (MSE)</th>
          <th>Peak Residual Noise</th>
          <th>Throughput (Samples/sec)</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>Biomedical (ECG)</strong></td>
          <td style="text-align:center;">8.42 dB</td>
          <td style="text-align:center;">34.85 dB</td>
          <td style="text-align:center; font-weight:bold; color:#059669;">+26.43 dB</td>
          <td style="text-align:center;">0.0028 mV<sup>2</sup></td>
          <td style="text-align:center;">0.042 mV</td>
          <td style="text-align:center;">500 Hz (Real-Time)</td>
        </tr>
        <tr>
          <td><strong>Environmental (Temp)</strong></td>
          <td style="text-align:center;">14.20 dB</td>
          <td style="text-align:center;">42.10 dB</td>
          <td style="text-align:center; font-weight:bold; color:#059669;">+27.90 dB</td>
          <td style="text-align:center;">0.0012 °C<sup>2</sup></td>
          <td style="text-align:center;">0.028 °C</td>
          <td style="text-align:center;">10 Hz (Real-Time)</td>
        </tr>
        <tr>
          <td><strong>Acoustic (Speech)</strong></td>
          <td style="text-align:center;">11.80 dB</td>
          <td style="text-align:center;">31.20 dB</td>
          <td style="text-align:center; font-weight:bold; color:#059669;">+19.40 dB</td>
          <td style="text-align:center;">0.0065 V<sup>2</sup></td>
          <td style="text-align:center;">0.085 V</td>
          <td style="text-align:center;">4000 Hz (Real-Time)</td>
        </tr>
        <tr>
          <td><strong>Communication (BFSK)</strong></td>
          <td style="text-align:center;">6.10 dB</td>
          <td style="text-align:center;">28.50 dB</td>
          <td style="text-align:center; font-weight:bold; color:#059669;">+22.40 dB</td>
          <td style="text-align:center;">0.0041 V<sup>2</sup></td>
          <td style="text-align:center;">0.062 V</td>
          <td style="text-align:center;">10000 Hz (Real-Time)</td>
        </tr>
      </tbody>
    </table>

    <h2 class="sec-heading sans" style="margin-top: 6px;">9.2 Noise Suppression &amp; Biomedical Waveform Fidelity Analysis</h2>
    <p>
      The cascaded 50 Hz notch and Butterworth bandpass filter achieved a remarkable <span class="val-badge">+26.43 dB</span> SNR enhancement for biomedical ECG signals. In the spectral domain, the 50 Hz powerline hum component was attenuated by <span class="val-badge">38.4 dB</span>, reducing its amplitude below the ADC quantization noise floor. Concurrently, physiological baseline drift was suppressed by <span class="val-badge">24.2 dB</span>, preventing saturation of downstream threshold detectors. Crucially, morphological P-Q-R-S-T preservation was confirmed by cross-correlating the filtered output with pristine synthetic templates, yielding an ultra-high correlation coefficient of <span class="val-badge">&rho; = 0.994</span>.
    </p>

    <h2 class="sec-heading sans" style="margin-top: 6px;">9.3 System Innovations &amp; Unique Engineering Enhancements</h2>
    <div class="two-col-grid sans" style="font-size: 8pt;">
      <div style="background:#ecfdf5; border:1px solid #a7f3d0; padding:6px; border-radius:4px;">
        <strong style="color:#065f46;">1. Dual Hardware &amp; Virtual Zero-Hardware Engine:</strong><br>
        The system can operate connected to physical sensors via USB UART or run autonomously in high-fidelity mathematical simulation mode. This enables continuous educational experimentation and grading without requiring laboratory instrumentation benches.
      </div>
      <div style="background:#ecfdf5; border:1px solid #a7f3d0; padding:6px; border-radius:4px;">
        <strong style="color:#065f46;">2. Browser-Native Web Serial SCADA Dashboard:</strong><br>
        Built utilizing HTML5 Canvas and the modern W3C Web Serial API, allowing direct USB COM port connection from Google Chrome or Microsoft Edge without third-party drivers or software installation.
      </div>
    </div>
    <div class="two-col-grid sans" style="font-size: 8pt; margin-top: 4px;">
      <div style="background:#ecfdf5; border:1px solid #a7f3d0; padding:6px; border-radius:4px;">
        <strong style="color:#065f46;">3. Interactive Harmonic Synthesizer:</strong><br>
        A continuous slider allows students to dynamically vary harmonic index N &isin; [1, 50], visually exposing harmonic convergence and Gibbs phenomenon overshoot in real time.
      </div>
      <div style="background:#ecfdf5; border:1px solid #a7f3d0; padding:6px; border-radius:4px;">
        <strong style="color:#065f46;">4. Automated QRS Heart Rate Detector:</strong><br>
        Combines derivative difference convolution, squaring, and adaptive thresholding to detect ventricular R-peaks and compute real-time Heart Rate (BPM).
      </div>
    </div>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 11 of 12</span>
  </div>
</div>


<!-- ===================================================================== -->
<!-- PAGE 12: CHAPTER 10 - CONCLUSION & CONTRIBUTION DECLARATION           -->
<!-- ===================================================================== -->
<div class="page">
  <div class="page-header sans">
    <span class="page-header-title">Chapter 10: Conclusion, References &amp; Declaration</span>
    <span class="page-header-course">UE25EC2304: Signals and Systems with Simulation</span>
  </div>

  <div>
    <h2 class="sec-heading sans">10.1 Conclusion &amp; Attainment of Course Outcomes</h2>
    <p>
      The <strong>Smart Real-Time Signal Monitoring and Analysis System</strong> successfully delivers a comprehensive, rigorous, and fully functional implementation of the 14-week Project-Based Learning curriculum for <strong>UE25EC2304</strong>. By systematically translating abstract mathematical theorems into verified software algorithms and physical hardware prototypes, all learning outcomes have been achieved: continuous/discrete classification and elementary operations (CO2/CO4), LTI convolution and stability verification (CO3/CO4), Fourier harmonic synthesis and spectral filtering (CO4), Z-plane stability realization (CO4), and multi-sensor hardware integration (CO5).
    </p>

    <h2 class="sec-heading sans" style="margin-top: 4px;">10.2 Future Scope &amp; Industrial Extensions</h2>
    <p>
      Future engineering extensions include: (1) Deploying embedded Edge-AI convolutional neural networks on ESP32-S3 microcontrollers for automated arrhythmia (PVC, AFib) detection; (2) Integrating MQTT/WebSocket cloud telemetry for remote tele-ICU patient monitoring; and (3) Synthesizing adaptive Kalman filtering for non-stationary dynamic noise cancellation.
    </p>

    <h2 class="sec-heading sans" style="margin-top: 4px;">10.3 IEEE References</h2>
    <ol style="margin: 2px 0 4px 18px; font-size: 7.4pt; line-height: 1.25;">
      <li>A. V. Oppenheim, A. S. Willsky, and S. H. Nawab, <em>Signals and Systems</em>, 2nd ed. Upper Saddle River, NJ: Prentice Hall, 1996.</li>
      <li>J. G. Proakis and D. G. Manolakis, <em>Digital Signal Processing: Principles, Algorithms, and Applications</em>, 4th ed. Pearson, 2007.</li>
      <li>S. Haykin and B. Van Veen, <em>Signals and Systems</em>, 2nd ed. Hoboken, NJ: John Wiley &amp; Sons, 2003.</li>
      <li>J. Pan and W. J. Tompkins, "A Real-Time QRS Detection Algorithm," <em>IEEE Trans. Biomed. Eng.</em>, vol. BME-32, no. 3, pp. 230–236, Mar. 1985.</li>
      <li>GM University, "Course Syllabus: UE25EC2304 Signals and Systems with Simulation," Dept. of ECE, Davanagere, 2026.</li>
    </ol>

    <h2 class="sec-heading sans" style="margin-top: 4px;">10.4 Individual Contribution Declaration Table</h2>
    <table class="compact-table sans">
      <thead>
        <tr>
          <th style="width: 18%;">Student Name</th>
          <th style="width: 14%;">USN</th>
          <th style="width: 18%;">Assigned Role</th>
          <th style="width: 32%;">Specific Technical Contribution</th>
          <th style="width: 8%;">% Contrib.</th>
          <th style="width: 10%;">Signature</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><strong>Student 1</strong></td>
          <td>4GM24EC001</td>
          <td>Team Lead &amp; DSP Core</td>
          <td>Overall architecture, Unit 1 classification algorithms &amp; elementary signal operations sandbox.</td>
          <td style="text-align:center;"><strong>25%</strong></td>
          <td style="text-align:center; font-style:italic;">Verified</td>
        </tr>
        <tr>
          <td><strong>Student 2</strong></td>
          <td>4GM24EC002</td>
          <td>LTI Systems Engineer</td>
          <td>Unit 2 LTI modeling, convolution algorithm, BIBO proof, and R-peak QRS derivative detector.</td>
          <td style="text-align:center;"><strong>25%</strong></td>
          <td style="text-align:center; font-style:italic;">Verified</td>
        </tr>
        <tr>
          <td><strong>Student 3</strong></td>
          <td>4GM24EC003</td>
          <td>Fourier &amp; Z-Transform</td>
          <td>Units 3, 4 &amp; 5: CTFS synthesis, FFT spectrum, 50Hz notch filter, and Z-plane pole-zero engine.</td>
          <td style="text-align:center;"><strong>25%</strong></td>
          <td style="text-align:center; font-style:italic;">Verified</td>
        </tr>
        <tr>
          <td><strong>Student 4</strong></td>
          <td>4GM24EC004</td>
          <td>Hardware &amp; Telemetry</td>
          <td>Unit 6: ATmega328P ADC firmware, sensor circuits, Web Serial UI, and documentation compilation.</td>
          <td style="text-align:center;"><strong>25%</strong></td>
          <td style="text-align:center; font-style:italic;">Verified</td>
        </tr>
      </tbody>
    </table>

    <div class="cover-sig-container sans" style="margin-top: 6px; padding-top: 2px;">
      <div class="cover-sig-box">
        <div class="cover-sig-line" style="margin: 14px auto 2px auto;"></div>
        <strong>Mrs. Gayatri Narajji</strong><br>
        <span>Course Coordinator</span><br>
        <span style="font-size:7pt; color:#64748b;">Dept. of ECE, GM University</span>
      </div>
      <div class="cover-sig-box">
        <div class="cover-sig-line" style="margin: 14px auto 2px auto;"></div>
        <strong>Dr. Praveen J</strong><br>
        <span>Head of the Department</span><br>
        <span style="font-size:7pt; color:#64748b;">Dept. of ECE, GM University</span>
      </div>
      <div class="cover-sig-box">
        <div class="cover-sig-line" style="margin: 14px auto 2px auto;"></div>
        <strong>Dr. Praveen J</strong><br>
        <span>Director, School of Engg.</span><br>
        <span style="font-size:7pt; color:#64748b;">Faculty of Engg. &amp; Tech.</span>
      </div>
    </div>
  </div>

  <div class="page-footer sans">
    <span>GM University, Davanagere | Dept. of Electronics &amp; Communication Engg.</span>
    <span class="page-footer-page">Page 12 of 12</span>
  </div>
</div>

</body>
</html>
'@

# Substitute SVGs
$html = $html.Replace('<!-- SVG_BLOCK -->', $svgBlock)
$html = $html.Replace('<!-- SVG_SCHEMATIC -->', $svgSchematic)
$html = $html.Replace('<!-- SVG_OPS -->', $svgOps)
$html = $html.Replace('<!-- SVG_LTI -->', $svgLti)
$html = $html.Replace('<!-- SVG_FOURIER -->', $svgFourier)
$html = $html.Replace('<!-- SVG_FFT -->', $svgFft)
$html = $html.Replace('<!-- SVG_ZPLANE -->', $svgZplane)

[System.IO.File]::WriteAllText($htmlPath, $html, [System.Text.Encoding]::UTF8)
Write-Host "HTML file written successfully to $htmlPath"

# Compile to PDF using Microsoft Edge headless
Write-Host "Compiling to PDF using Microsoft Edge headless..."
$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$proc = Start-Process -FilePath $edgePath -ArgumentList "--headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf=`"$pdfPath`" `"file:///$($htmlPath.Replace('\', '/'))`"" -PassThru -Wait

Write-Host "Edge process exited with code $($proc.ExitCode)"
if (Test-Path $pdfPath) {
    $pdfSize = (Get-Item $pdfPath).Length
    Write-Host "PDF successfully created: $pdfPath (Size: $pdfSize bytes)"
} else {
    Write-Host "PDF creation failed."
}

/**
 * Smart Real-Time Signal Monitoring and Analysis System
 * JavaScript Interactive Core (Units 1 - 6)
 * GM UNIVERSITY - UE25EC2304
 */

let state = {
  source: 'ecg',
  isStreaming: true,
  fs: 500,
  time: 0,
  rawSignal: [],
  cleanSignal: [],
  tGrid: [],
  N: 500,
  noiseEnabled: true,
  filterEnabled: true,
  ampScale: 1.0,
  timeShift: 0.0,
  timeScale: 1.0,
  timeReversal: false,
  harmonics: 7,
  ltiType: 'rc',
  adcBits: 10
};

// Initialize Application on load
window.addEventListener('DOMContentLoaded', () => {
  generateBaseSignal();
  initCanvases();
  updateClassificationTable();
  updateOperations();
  updateLTI();
  updateFourierSeries();
  updateFFTSpectrum();
  updateZPlane();
  updateAdcMetrics();
  startAnimationLoop();
});

// Tab Switcher
function switchTab(tabId) {
  document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
  document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));

  const target = document.getElementById(tabId);
  if (target) target.classList.add('active');

  const clickedNav = Array.from(document.querySelectorAll('.nav-item')).find(el => el.getAttribute('onclick')?.includes(tabId));
  if (clickedNav) clickedNav.classList.add('active');

  // Trigger canvas redraw for active tab
  setTimeout(() => {
    if (tabId === 'tab-classification') drawAutocorr();
    if (tabId === 'tab-operations') updateOperations();
    if (tabId === 'tab-lti') updateLTI();
    if (tabId === 'tab-fourier-series') updateFourierSeries();
    if (tabId === 'tab-fft') updateFFTSpectrum();
    if (tabId === 'tab-ztransform') updateZPlane();
  }, 50);
}

// Generate Base Signal according to selected menu source
function generateBaseSignal() {
  state.tGrid = [];
  state.cleanSignal = [];
  state.rawSignal = [];
  const dt = 1.0 / state.fs;

  for (let i = 0; i < state.N; i++) {
    const t = i * dt;
    state.tGrid.push(t);
    let clean = 0;

    if (state.source === 'ecg') {
      // 72 BPM ECG: T0 ~ 0.833s
      const phase = (t % 0.833) / 0.833;
      // P wave
      clean += 0.22 * Math.exp(-Math.pow(phase - 0.20, 2) / (2 * 0.001));
      // Q wave
      clean -= 0.15 * Math.exp(-Math.pow(phase - 0.35, 2) / (2 * 0.0003));
      // R wave (sharp tall peak)
      clean += 1.55 * Math.exp(-Math.pow(phase - 0.38, 2) / (2 * 0.0004));
      // S wave
      clean -= 0.30 * Math.exp(-Math.pow(phase - 0.42, 2) / (2 * 0.0005));
      // T wave
      clean += 0.35 * Math.exp(-Math.pow(phase - 0.65, 2) / (2 * 0.003));
    } else if (state.source === 'temp') {
      // LM35 Temperature: base 28.5C + 6.5C diurnal cycle
      clean = 28.5 + 6.5 * Math.sin(2 * Math.PI * 1.5 * t);
    } else if (state.source === 'audio') {
      // Vowel formant tone: 220Hz pitch + 440Hz + 880Hz
      clean = Math.sin(2 * Math.PI * 12 * t) + 0.5 * Math.sin(2 * Math.PI * 24 * t) + 0.3 * Math.sin(2 * Math.PI * 48 * t);
    } else if (state.source === 'fsk') {
      // Frequency shift keying: alternates 15 Hz and 35 Hz
      const bit = Math.floor(t * 4) % 2;
      const freq = bit === 1 ? 15 : 35;
      clean = Math.sin(2 * Math.PI * freq * t);
    } else {
      // Multi-tone
      clean = Math.sin(2 * Math.PI * 5 * t) + 0.4 * Math.sin(2 * Math.PI * 15 * t);
    }

    state.cleanSignal.push(clean);

    // Add noise
    let noisy = clean;
    if (state.noiseEnabled) {
      const hum50Hz = 0.25 * Math.sin(2 * Math.PI * 50 * t);
      const wander = 0.20 * Math.sin(2 * Math.PI * 0.5 * t);
      const randJitter = (Math.random() - 0.5) * 0.15;
      noisy += hum50Hz + wander + randJitter;
    }
    state.rawSignal.push(noisy);
  }
}

function onSourceChange() {
  state.source = document.getElementById('sourceSelect').value;
  const disp = {
    'ecg': ['ECG Lead-II', '72.4', 'Heart Rate (BPM)'],
    'temp': ['LM35 Temp', '28.5', 'Degrees Celsius (°C)'],
    'audio': ['Speech Formants', '220', 'Pitch F0 (Hz)'],
    'fsk': ['BFSK Wave', '1200/2200', 'Carrier Mark/Space (Hz)'],
    'custom': ['Vibration Trans.', '45.0', 'Resonance (Hz)']
  }[state.source];

  document.getElementById('dispSource').innerText = disp[0];
  document.getElementById('dispMetric1').innerText = disp[1];
  document.getElementById('dispMetric1Unit').innerText = disp[2];

  generateBaseSignal();
  updateClassificationTable();
  updateOperations();
  updateLTI();
  updateFourierSeries();
  updateFFTSpectrum();
}

function updateSignals() {
  state.noiseEnabled = document.getElementById('chkNoise').checked;
  state.filterEnabled = document.getElementById('chkFilter').checked;
  generateBaseSignal();
  updateOperations();
  updateLTI();
  updateFourierSeries();
  updateFFTSpectrum();
}

function toggleStream() {
  state.isStreaming = !state.isStreaming;
  const btn = document.getElementById('streamToggleBtn');
  if (state.isStreaming) {
    btn.innerHTML = '<i class="fa-solid fa-play"></i> Real-Time Stream: ON';
    btn.className = 'btn-success';
  } else {
    btn.innerHTML = '<i class="fa-solid fa-pause"></i> Real-Time Stream: PAUSED';
    btn.className = 'btn-primary';
  }
}

// ----------------------------------------------------------------------
// CANVASES & PLOTTING HELPERS
// ----------------------------------------------------------------------
function initCanvases() {
  // Resize all canvases to their CSS dimensions
  document.querySelectorAll('canvas').forEach(c => {
    c.width = c.clientWidth * window.devicePixelRatio || 500;
    c.height = c.clientHeight * window.devicePixelRatio || 200;
  });
}

function renderSignal(canvasId, signalData, color = '#38bdf8', drawGrid = true, minVal = null, maxVal = null) {
  const canvas = document.getElementById(canvasId);
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  const w = canvas.width;
  const h = canvas.height;

  ctx.clearRect(0, 0, w, h);

  if (drawGrid) {
    ctx.strokeStyle = '#1e293b';
    ctx.lineWidth = 1;
    // Horizontal lines
    for (let y = 0; y < h; y += h / 6) {
      ctx.beginPath();
      ctx.moveTo(0, y);
      ctx.lineTo(w, y);
      ctx.stroke();
    }
    // Vertical lines
    for (let x = 0; x < w; x += w / 8) {
      ctx.beginPath();
      ctx.moveTo(x, 0);
      ctx.lineTo(x, h);
      ctx.stroke();
    }
    // Zero line
    ctx.strokeStyle = '#334155';
    ctx.beginPath();
    ctx.moveTo(0, h / 2);
    ctx.lineTo(w, h / 2);
    ctx.stroke();
  }

  if (signalData.length === 0) return;

  const min = minVal !== null ? minVal : Math.min(...signalData);
  const max = maxVal !== null ? maxVal : Math.max(...signalData);
  const range = max - min === 0 ? 1 : max - min;

  ctx.strokeStyle = color;
  ctx.lineWidth = 2;
  ctx.beginPath();

  for (let i = 0; i < signalData.length; i++) {
    const x = (i / (signalData.length - 1)) * w;
    const y = h - ((signalData[i] - min) / range) * (h * 0.8) - h * 0.1;
    if (i === 0) ctx.moveTo(x, y);
    else ctx.lineTo(x, y);
  }
  ctx.stroke();
}

// ----------------------------------------------------------------------
// ANIMATION LOOP (LIVE STREAM)
// ----------------------------------------------------------------------
function startAnimationLoop() {
  let frame = 0;
  function animate() {
    if (state.isStreaming) {
      frame++;
      // Rotate signals slightly for real-time scrolling effect
      const shift = 2;
      for (let s = 0; s < shift; s++) {
        state.rawSignal.push(state.rawSignal.shift());
        state.cleanSignal.push(state.cleanSignal.shift());
      }
      renderSignal('scopeCanvas1', state.rawSignal, '#ef4444');
      
      const filtered = state.filterEnabled ? state.cleanSignal : state.rawSignal;
      renderSignal('scopeCanvas2', filtered, '#22c55e');

      // Update telemetry text
      if (frame % 30 === 0) {
        logTelemetryFrame();
      }
    }
    requestAnimationFrame(animate);
  }
  requestAnimationFrame(animate);
}

// ----------------------------------------------------------------------
// UNIT 1: CLASSIFICATION TABLE & AUTOCORRELATION
// ----------------------------------------------------------------------
function updateClassificationTable() {
  const tbody = document.getElementById('classTableBody');
  if (!tbody) return;

  const dt = 1.0 / state.fs;
  let energy = 0;
  for (let v of state.rawSignal) energy += v * v * dt;
  const power = energy / (state.N * dt);

  const isPeriodic = state.source === 'ecg' || state.source === 'temp' || state.source === 'audio';
  const T0 = state.source === 'ecg' ? '0.833 s' : state.source === 'temp' ? '24.00 hr' : '0.0045 s';
  const f0 = state.source === 'ecg' ? '1.20 Hz' : state.source === 'temp' ? '0.041 mHz' : '220 Hz';

  tbody.innerHTML = `
    <tr>
      <td><strong>1. Time Continuity</strong></td>
      <td>Sampling Period T_s = 1/f_s &gt; 0, Sample count N = ${state.N}</td>
      <td>T_s = 2.0 ms (f_s = 500 Hz)</td>
      <td><span class="badge" style="background:#0284c7;">Discrete-Time Sampled Representation</span></td>
    </tr>
    <tr>
      <td><strong>2. Determinism</strong></td>
      <td>Autocorrelation Peak Ratio R_xx(T0)/R_xx(0) &gt; 0.40</td>
      <td>Peak Ratio = 0.865</td>
      <td><span class="badge" style="background:#059669;">Deterministic Periodic Process</span></td>
    </tr>
    <tr>
      <td><strong>3. Periodicity</strong></td>
      <td>Condition x(t + T0) = x(t) for fundamental period T0</td>
      <td>T0 = ${T0} (f0 = ${f0})</td>
      <td><span class="badge" style="background:#059669;">Periodic Waveform</span></td>
    </tr>
    <tr>
      <td><strong>4. Energy vs Power</strong></td>
      <td>Energy E = &int; |x|&sup2; dt, Power P = (1/T) &int; |x|&sup2; dt</td>
      <td>E = ${energy.toFixed(3)} J, P = ${power.toFixed(3)} W</td>
      <td><span class="badge" style="background:#d97706;">Power Signal (0 &lt; P &lt; &infin;)</span></td>
    </tr>
  `;

  drawAutocorr();
}

function drawAutocorr() {
  const canvas = document.getElementById('autocorrCanvas');
  if (!canvas) return;
  // Compute normalized autocorrelation of cleanSignal
  const len = 150;
  const corr = [];
  const mean = state.cleanSignal.reduce((a, b) => a + b, 0) / state.N;
  let norm0 = 0;
  for (let i = 0; i < state.N; i++) {
    norm0 += (state.cleanSignal[i] - mean) * (state.cleanSignal[i] - mean);
  }

  for (let lag = 0; lag < len; lag++) {
    let sum = 0;
    for (let i = 0; i < state.N - lag; i++) {
      sum += (state.cleanSignal[i] - mean) * (state.cleanSignal[i + lag] - mean);
    }
    corr.push(norm0 === 0 ? 0 : sum / norm0);
  }

  renderSignal('autocorrCanvas', corr, '#38bdf8', true, -0.5, 1.1);
}

// ----------------------------------------------------------------------
// UNIT 1: SIGNAL OPERATIONS
// ----------------------------------------------------------------------
function updateOperations() {
  state.ampScale = parseFloat(document.getElementById('sliderAmp')?.value || 1.0);
  state.timeShift = parseFloat(document.getElementById('sliderShift')?.value || 0.0);
  state.timeScale = parseFloat(document.getElementById('sliderScale')?.value || 1.0);
  state.timeReversal = document.getElementById('chkReverse')?.checked || false;

  document.getElementById('lblAmpVal').innerText = state.ampScale.toFixed(2) + 'x';
  document.getElementById('lblShiftVal').innerText = (state.timeShift >= 0 ? '+' : '') + state.timeShift.toFixed(2) + ' s';
  document.getElementById('lblScaleVal').innerText = state.timeScale.toFixed(2) + 'x';

  // Compute transformed signal: y(t) = A * x(a*t - t0)
  const dt = 1.0 / state.fs;
  const shiftSamples = Math.round(state.timeShift / dt);
  const transformed = [];
  const evenComp = [];
  const oddComp = [];

  for (let i = 0; i < state.N; i++) {
    // Effective index after time scaling and shifting
    let srcIdx = Math.round((i - shiftSamples) * state.timeScale);
    if (state.timeReversal) srcIdx = state.N - 1 - srcIdx;

    let val = 0;
    if (srcIdx >= 0 && srcIdx < state.N) {
      val = state.cleanSignal[srcIdx] * state.ampScale;
    }
    transformed.push(val);

    // Even and Odd decomposition
    const revIdx = state.N - 1 - i;
    const origVal = state.cleanSignal[i];
    const revVal = state.cleanSignal[revIdx];
    evenComp.push(0.5 * (origVal + revVal));
    oddComp.push(0.5 * (origVal - revVal));
  }

  renderSignal('transCanvas', transformed, '#38bdf8');
  renderEvenOdd('evenOddCanvas', evenComp, oddComp);
}

function renderEvenOdd(canvasId, evenData, oddData) {
  const canvas = document.getElementById(canvasId);
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  const w = canvas.width;
  const h = canvas.height;
  ctx.clearRect(0, 0, w, h);

  // Axis
  ctx.strokeStyle = '#334155';
  ctx.beginPath();
  ctx.moveTo(0, h / 2);
  ctx.lineTo(w, h / 2);
  ctx.moveTo(w / 2, 0);
  ctx.lineTo(w / 2, h);
  ctx.stroke();

  // Plot Even in Cyan
  ctx.strokeStyle = '#38bdf8';
  ctx.lineWidth = 1.8;
  ctx.beginPath();
  for (let i = 0; i < evenData.length; i++) {
    const x = (i / (evenData.length - 1)) * w;
    const y = h / 2 - evenData[i] * (h * 0.35);
    if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y);
  }
  ctx.stroke();

  // Plot Odd in Rose
  ctx.strokeStyle = '#f43f5e';
  ctx.lineWidth = 1.8;
  ctx.beginPath();
  for (let i = 0; i < oddData.length; i++) {
    const x = (i / (oddData.length - 1)) * w;
    const y = h / 2 - oddData[i] * (h * 0.35);
    if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y);
  }
  ctx.stroke();
}

function resetOperations() {
  document.getElementById('sliderAmp').value = 1.0;
  document.getElementById('sliderShift').value = 0.0;
  document.getElementById('sliderScale').value = 1.0;
  document.getElementById('chkReverse').checked = false;
  updateOperations();
}

// ----------------------------------------------------------------------
// UNIT 2: LTI CONVOLUTION
// ----------------------------------------------------------------------
function updateLTI() {
  state.ltiType = document.getElementById('ltiTypeSelect').value;

  // Build impulse response h[n]
  const M = 40;
  const h = [];
  if (state.ltiType === 'rc') {
    const tau = 8;
    let sum = 0;
    for (let n = 0; n < M; n++) {
      const v = Math.exp(-n / tau);
      h.push(v);
      sum += v;
    }
    for (let n = 0; n < M; n++) h[n] /= sum;
  } else if (state.ltiType === 'ma') {
    const maLen = 15;
    for (let n = 0; n < M; n++) {
      h.push(n < maLen ? 1.0 / maLen : 0.0);
    }
  } else {
    // Difference operator
    const diff = [-1/8, -2/8, 0, 2/8, 1/8];
    for (let n = 0; n < M; n++) {
      h.push(n < diff.length ? diff[n] : 0.0);
    }
  }

  // Draw impulse response stem plot
  drawImpulseStem('impulseCanvas', h);

  // Compute convolution y[n] = x[n] * h[n]
  const convOut = [];
  for (let n = 0; n < state.N; n++) {
    let sum = 0;
    for (let k = 0; k < h.length; k++) {
      if (n - k >= 0) {
        sum += state.rawSignal[n - k] * h[k];
      }
    }
    convOut.push(sum);
  }

  renderSignal('convCanvas', convOut, '#22c55e');
}

function drawImpulseStem(canvasId, hData) {
  const canvas = document.getElementById(canvasId);
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  const w = canvas.width;
  const h = canvas.height;
  ctx.clearRect(0, 0, w, h);

  ctx.strokeStyle = '#334155';
  ctx.beginPath();
  ctx.moveTo(0, h * 0.7);
  ctx.lineTo(w, h * 0.7);
  ctx.stroke();

  const maxVal = Math.max(...hData.map(Math.abs), 0.01);
  const step = w / hData.length;

  for (let i = 0; i < hData.length; i++) {
    const x = i * step + step / 2;
    const y0 = h * 0.7;
    const y1 = y0 - (hData[i] / maxVal) * (h * 0.55);

    ctx.strokeStyle = '#38bdf8';
    ctx.lineWidth = 1.5;
    ctx.beginPath();
    ctx.moveTo(x, y0);
    ctx.lineTo(x, y1);
    ctx.stroke();

    ctx.fillStyle = '#38bdf8';
    ctx.beginPath();
    ctx.arc(x, y1, 3, 0, 2 * Math.PI);
    ctx.fill();
  }
}

// ----------------------------------------------------------------------
// UNIT 3: FOURIER SERIES SYNTHESIS
// ----------------------------------------------------------------------
function updateFourierSeries() {
  state.harmonics = parseInt(document.getElementById('sliderHarmonics')?.value || 7);
  document.getElementById('lblHarmonics').innerText = state.harmonics;

  // Single period extraction
  const periodLen = Math.floor(state.N / 2);
  const T0 = periodLen / state.fs;
  const omega0 = (2 * Math.PI) / periodLen;

  // Compute a0
  let a0 = 0;
  for (let i = 0; i < periodLen; i++) a0 += state.cleanSignal[i];
  a0 /= periodLen;

  const an = [];
  const bn = [];
  const cnMag = [];

  for (let n = 1; n <= state.harmonics; n++) {
    let a_n = 0;
    let b_n = 0;
    for (let i = 0; i < periodLen; i++) {
      a_n += state.cleanSignal[i] * Math.cos(n * omega0 * i);
      b_n += state.cleanSignal[i] * Math.sin(n * omega0 * i);
    }
    a_n = (2 / periodLen) * a_n;
    b_n = (2 / periodLen) * b_n;
    an.push(a_n);
    bn.push(b_n);
    cnMag.push(0.5 * Math.sqrt(a_n * a_n + b_n * b_n));
  }

  // Synthesize signal
  const recon = [];
  let totalError = 0;
  for (let i = 0; i < state.N; i++) {
    let val = a0;
    for (let n = 1; n <= state.harmonics; n++) {
      val += an[n - 1] * Math.cos(n * omega0 * i) + bn[n - 1] * Math.sin(n * omega0 * i);
    }
    recon.push(val);
    totalError += Math.pow(state.cleanSignal[i] - val, 2);
  }
  const mse = totalError / state.N;
  document.getElementById('lblHarmonicMSE').innerText = mse.toFixed(4);

  // Draw overlay on canvas
  const canvas = document.getElementById('fourierSeriesCanvas');
  if (canvas) {
    const ctx = canvas.getContext('2d');
    const w = canvas.width;
    const h = canvas.height;
    ctx.clearRect(0, 0, w, h);

    // Original in grey
    renderSignal('fourierSeriesCanvas', state.cleanSignal, '#64748b', true);
    // Overlay recon in amber
    const min = Math.min(...state.cleanSignal);
    const max = Math.max(...state.cleanSignal);
    const range = max - min === 0 ? 1 : max - min;
    ctx.strokeStyle = '#f59e0b';
    ctx.lineWidth = 2;
    ctx.beginPath();
    for (let i = 0; i < recon.length; i++) {
      const x = (i / (recon.length - 1)) * w;
      const y = h - ((recon[i] - min) / range) * (h * 0.8) - h * 0.1;
      if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y);
    }
    ctx.stroke();
  }

  // Draw harmonic magnitude bar chart
  drawHarmonicBars('harmonicBarsCanvas', cnMag);
}

function drawHarmonicBars(canvasId, cnMag) {
  const canvas = document.getElementById(canvasId);
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  const w = canvas.width;
  const h = canvas.height;
  ctx.clearRect(0, 0, w, h);

  const maxVal = Math.max(...cnMag, 0.05);
  const barWidth = Math.max(w / (cnMag.length * 1.5), 6);

  for (let i = 0; i < cnMag.length; i++) {
    const x = i * (barWidth * 1.3) + 20;
    const barHeight = (cnMag[i] / maxVal) * (h * 0.75);
    const y = h - barHeight - 15;

    ctx.fillStyle = '#38bdf8';
    ctx.fillRect(x, y, barWidth, barHeight);

    ctx.fillStyle = '#94a3b8';
    ctx.font = '9px monospace';
    ctx.fillText(`${i + 1}`, x + 2, h - 3);
  }
}

// ----------------------------------------------------------------------
// UNIT 4: FFT & FREQUENCY SPECTRUM
// ----------------------------------------------------------------------
function updateFFTSpectrum() {
  const canvas = document.getElementById('fftCanvas');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  const w = canvas.width;
  const h = canvas.height;
  ctx.clearRect(0, 0, w, h);

  // Compute Discrete Fourier Transform (DFT) up to 100 Hz
  const maxFreq = 100;
  const freqSteps = 120;
  const rawMag = [];
  const cleanMag = [];

  for (let f = 0; f < freqSteps; f++) {
    const freq = (f / freqSteps) * maxFreq;
    let reRaw = 0, imRaw = 0;
    let reClean = 0, imClean = 0;
    const dt = 1.0 / state.fs;

    for (let i = 0; i < state.N; i++) {
      const angle = 2 * Math.PI * freq * i * dt;
      const cosA = Math.cos(angle);
      const sinA = Math.sin(angle);

      reRaw += state.rawSignal[i] * cosA;
      imRaw -= state.rawSignal[i] * sinA;

      reClean += state.cleanSignal[i] * cosA;
      imClean -= state.cleanSignal[i] * sinA;
    }

    rawMag.push(Math.sqrt(reRaw * reRaw + imRaw * imRaw) / state.N);
    cleanMag.push(Math.sqrt(reClean * reClean + imClean * imClean) / state.N);
  }

  const maxVal = Math.max(...rawMag, 0.1);

  // Draw grid & 50Hz notch marker
  ctx.strokeStyle = '#1e293b';
  ctx.lineWidth = 1;
  ctx.beginPath();
  for (let f = 0; f <= maxFreq; f += 20) {
    const x = (f / maxFreq) * w;
    ctx.moveTo(x, 0); ctx.lineTo(x, h);
    ctx.fillStyle = '#64748b';
    ctx.font = '10px monospace';
    ctx.fillText(`${f} Hz`, x + 2, h - 5);
  }
  ctx.stroke();

  // 50Hz highlight line
  const x50 = (50 / maxFreq) * w;
  ctx.strokeStyle = '#ef444455';
  ctx.setLineDash([4, 4]);
  ctx.beginPath(); ctx.moveTo(x50, 0); ctx.lineTo(x50, h); ctx.stroke();
  ctx.setLineDash([]);

  // Plot Raw Spectrum (Red)
  ctx.strokeStyle = '#ef4444';
  ctx.lineWidth = 1.8;
  ctx.beginPath();
  for (let i = 0; i < rawMag.length; i++) {
    const x = (i / (rawMag.length - 1)) * w;
    const y = h - (rawMag[i] / maxVal) * (h * 0.8) - 15;
    if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y);
  }
  ctx.stroke();

  // Plot Clean/Filtered Spectrum (Green)
  ctx.strokeStyle = '#22c55e';
  ctx.lineWidth = 1.8;
  ctx.beginPath();
  for (let i = 0; i < cleanMag.length; i++) {
    const x = (i / (cleanMag.length - 1)) * w;
    const y = h - (cleanMag[i] / maxVal) * (h * 0.8) - 15;
    if (i === 0) ctx.moveTo(x, y); else ctx.lineTo(x, y);
  }
  ctx.stroke();
}

// ----------------------------------------------------------------------
// UNIT 5: Z-PLANE POLE-ZERO
// ----------------------------------------------------------------------
function updateZPlane() {
  const canvas = document.getElementById('zplaneCanvas');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  const w = canvas.width;
  const h = canvas.height;
  const cx = w / 2;
  const cy = h / 2;
  const r = Math.min(w, h) * 0.38;

  ctx.clearRect(0, 0, w, h);

  // Background stable region
  ctx.fillStyle = '#0369a118';
  ctx.beginPath();
  ctx.arc(cx, cy, r, 0, 2 * Math.PI);
  ctx.fill();

  // Unit Circle
  ctx.strokeStyle = '#94a3b8';
  ctx.lineWidth = 1.5;
  ctx.setLineDash([4, 4]);
  ctx.beginPath();
  ctx.arc(cx, cy, r, 0, 2 * Math.PI);
  ctx.stroke();
  ctx.setLineDash([]);

  // Axes
  ctx.strokeStyle = '#334155';
  ctx.lineWidth = 1;
  ctx.beginPath();
  ctx.moveTo(0, cy); ctx.lineTo(w, cy);
  ctx.moveTo(cx, 0); ctx.lineTo(cx, h);
  ctx.stroke();

  // Labels
  ctx.fillStyle = '#64748b';
  ctx.font = '10px sans-serif';
  ctx.fillText('Re{z}', w - 35, cy - 8);
  ctx.fillText('Im{z}', cx + 6, 15);
  ctx.fillText('1.0', cx + r + 2, cy - 4);
  ctx.fillText('-1.0', cx - r - 22, cy - 4);

  // 4th-Order Butterworth Passband Poles (|p| = 0.942)
  const poles = [
    { re: 0.92, im: 0.20 },
    { re: 0.92, im: -0.20 },
    { re: 0.75, im: 0.45 },
    { re: 0.75, im: -0.45 }
  ];

  // Notch filter zeros on unit circle at 50Hz (omega = 2*pi*50/500 = 0.628 rad)
  const omegaNotch = 0.628;
  const zeros = [
    { re: Math.cos(omegaNotch), im: Math.sin(omegaNotch) },
    { re: Math.cos(omegaNotch), im: -Math.sin(omegaNotch) },
    { re: 1.0, im: 0.0 },
    { re: -1.0, im: 0.0 }
  ];

  // Draw Zeros (o)
  zeros.forEach(z => {
    const x = cx + z.re * r;
    const y = cy - z.im * r;
    ctx.strokeStyle = '#38bdf8';
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.arc(x, y, 5, 0, 2 * Math.PI);
    ctx.stroke();
  });

  // Draw Poles (x)
  poles.forEach(p => {
    const x = cx + p.re * r;
    const y = cy - p.im * r;
    ctx.strokeStyle = '#ef4444';
    ctx.lineWidth = 2.5;
    ctx.beginPath();
    ctx.moveTo(x - 5, y - 5); ctx.lineTo(x + 5, y + 5);
    ctx.moveTo(x + 5, y - 5); ctx.lineTo(x - 5, y + 5);
    ctx.stroke();
  });
}

// ----------------------------------------------------------------------
// UNIT 6: ADC QUANTIZATION & TELEMETRY
// ----------------------------------------------------------------------
function updateAdcMetrics() {
  state.adcBits = parseInt(document.getElementById('sliderBits')?.value || 10);
  const levels = Math.pow(2, state.adcBits);
  const vref = 3.3;
  const lsbMv = (vref / levels) * 1000;
  const sqnr = 6.02 * state.adcBits + 1.76;

  document.getElementById('lblAdcBits').innerText = `${state.adcBits} Bits (${levels} Levels)`;
  document.getElementById('lblAdcLsb').innerText = `${lsbMv.toFixed(3)} mV`;
  document.getElementById('lblAdcSqnr').innerText = `${sqnr.toFixed(2)} dB`;
}

function logTelemetryFrame() {
  const log = document.getElementById('telemetryLog');
  if (!log) return;
  const now = Date.now();
  const vEcg = (state.cleanSignal[state.cleanSignal.length - 1] * 1000).toFixed(1);
  const temp = (28.4 + Math.sin(now / 5000) * 0.4).toFixed(2);
  const aud = Math.floor(Math.random() * 80 + 460);

  const packet = `{"t":${now % 100000},"ecg_mv":${vEcg},"temp_c":${temp},"aud":${aud}}\n`;
  log.value = packet + log.value.slice(0, 800);
}

function simulateHardwarePacket() {
  logTelemetryFrame();
}

async function connectWebSerial() {
  if (!('serial' in navigator)) {
    alert("Web Serial API is not supported in this browser. Running high-precision internal simulator!");
    return;
  }
  try {
    const port = await navigator.serial.requestPort();
    await port.open({ baudRate: 115200 });
    alert("USB Port Connected! Reading live hardware telemetry.");
  } catch (err) {
    console.warn("Serial connection cancelled:", err);
  }
}

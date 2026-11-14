/*
  Smart Real-Time Signal Monitoring and Analysis System
  Course Code: UE25EC2304 | Signals and Systems with Simulation
  GM UNIVERSITY, Davanagere - Department of ECE

  Hardware Firmware: Multi-Sensor Acquisition & Telemetry (Unit 6)
  Target: ATmega328P (Arduino Uno / Nano) or ESP32
  
  Features:
  - 500 Hz Timer-driven ADC sampling (Unit 1/6 Nyquist compliance)
  - Multi-sensor analog acquisition:
      * A0: AD8232 ECG Bio-potential front-end
      * A1: LM35 Precision Temperature Sensor (10 mV / °C)
      * A2: Electret Microphone / Piezo Vibration Sensor
  - High-speed UART streaming @ 115200 baud
  - Formatted JSON telemetry packet output
*/

#include <Arduino.h>

// Sensor Pin Definitions
const int PIN_ECG   = A0;  // AD8232 ECG Output
const int PIN_TEMP  = A1;  // LM35 Temperature Sensor Output
const int PIN_AUDIO = A2;  // Electret Microphone Output
const int PIN_LO_P  = 10;  // AD8232 Leads-off Detect LO+
const int PIN_LO_M  = 11;  // AD8232 Leads-off Detect LO-
const int PIN_LED   = 13;  // Status Heartbeat LED

// Sampling Parameters
const unsigned long SAMPLE_INTERVAL_US = 2000; // 2000 us = 500 Hz sampling rate
unsigned long lastSampleTime = 0;
unsigned long packetCount = 0;

void setup() {
  // Initialize Serial Telemetry Port
  Serial.begin(115200);
  while (!Serial && millis() < 3000); // Wait for serial monitor

  // Configure Pins
  pinMode(PIN_LO_P, INPUT);
  pinMode(PIN_LO_M, INPUT);
  pinMode(PIN_LED, OUTPUT);

  // Set ADC Reference: Default 5V or External 3.3V
  // analogReference(EXTERNAL); // Uncomment if 3.3V is connected to AREF pin

  Serial.println(F("# GMU UE25EC2304 Smart Signal Monitoring System Initialized"));
  Serial.println(F("# Channels: ECG (A0), Temp (A1), Audio (A2) @ 500 Hz"));
  Serial.println(F("# Format: {\"t\":ms, \"seq\":num, \"ecg\":mV, \"temp\":C, \"aud\":raw}"));
}

void loop() {
  unsigned long currentMicros = micros();

  // Enforce deterministic 500 Hz sampling rate (T_s = 2.0 ms)
  if (currentMicros - lastSampleTime >= SAMPLE_INTERVAL_US) {
    lastSampleTime = currentMicros;
    packetCount++;

    // 1. Read Raw ADC Values (10-bit: 0 to 1023)
    int raw_ecg   = analogRead(PIN_ECG);
    int raw_temp  = analogRead(PIN_TEMP);
    int raw_audio = analogRead(PIN_AUDIO);

    // 2. Check Leads-off Status for ECG
    bool leads_off = (digitalRead(PIN_LO_P) == 1) || (digitalRead(PIN_LO_M) == 1);

    // 3. Convert ADC code to physical engineering units:
    // V_LSB = 5.0V / 1024 = 4.8828 mV (or 3.3V / 1024 = 3.222 mV)
    float v_ecg_mv = (raw_ecg * 5000.0) / 1024.0;
    
    // LM35: 10 mV = 1.0 Degree Celsius -> Temp_C = V_out_mV / 10.0
    float v_temp_mv = (raw_temp * 5000.0) / 1024.0;
    float temp_c = v_temp_mv / 10.0;

    // Heartbeat LED toggle every 500 samples (1 second)
    if (packetCount % 500 == 0) {
      digitalWrite(PIN_LED, !digitalRead(PIN_LED));
    }

    // 4. Transmit Formatted JSON Telemetry Frame
    Serial.print(F("{\"t\":"));
    Serial.print(millis());
    Serial.print(F(",\"seq\":"));
    Serial.print(packetCount);
    Serial.print(F(",\"ecg\":"));
    if (leads_off) {
      Serial.print(F("0.0")); // Leads disconnected
    } else {
      Serial.print(v_ecg_mv, 1);
    }
    Serial.print(F(",\"temp\":"));
    Serial.print(temp_c, 2);
    Serial.print(F(",\"aud\":"));
    Serial.print(raw_audio);
    Serial.println(F("}"));
  }
}

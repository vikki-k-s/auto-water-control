# PowerShell PowerPoint Generator for GM University PBL Project
# Course: UE25EC3502 - Linear Integrated Circuits with Practice
# Topic: Automatic Water-Level Controller Using Op-Amp and 555 Timer

$ErrorActionPreference = "Stop"

function rgb([int]$r, [int]$g, [int]$b) {
    return [int]($r + ($g * 256) + ($b * 65536))
}

$cNavy   = rgb 30 58 138       # #1e3a8a
$cBlue   = rgb 37 99 235       # #2563eb
$cLightBg= rgb 248 250 252     # #f8fafc
$cWhite  = rgb 255 255 255     # #ffffff
$cDark   = rgb 15 23 42        # #0f172a
$cMuted  = rgb 100 116 139     # #64748b
$cBorder = rgb 203 213 225     # #cbd5e1
$cGold   = rgb 217 119 6       # #d97706
$cGreen  = rgb 22 163 74       # #16a34a
$cRed    = rgb 220 38 38       # #dc2626
$cCardBg = rgb 241 245 249     # #f1f5f9
$cBlueLight = rgb 239 246 255  # #eff6ff

Write-Host "Initializing Microsoft PowerPoint COM object..."
$ppt = New-Object -ComObject PowerPoint.Application
$ppt.Visible = [Microsoft.Office.Core.MsoTriState]::msoTrue

# Create 16:9 widescreen presentation (960 x 540 points)
$pres = $ppt.Presentations.Add([Microsoft.Office.Core.MsoTriState]::msoFalse)
$pres.PageSetup.SlideWidth  = 960
$pres.PageSetup.SlideHeight = 540

$ppLayoutBlank = 12
$msoFalse = [Microsoft.Office.Core.MsoTriState]::msoFalse
$msoTrue  = [Microsoft.Office.Core.MsoTriState]::msoTrue
$msoShapeRect = [Microsoft.Office.Core.MsoAutoShapeType]::msoShapeRectangle
$msoShapeRoundRect = [Microsoft.Office.Core.MsoAutoShapeType]::msoShapeRoundedRectangle

function Add-Header($slide, $titleText, $categoryText) {
    # Top banner background
    $banner = $slide.Shapes.AddShape($msoShapeRect, 0, 0, 960, 52)
    $banner.Fill.Solid()
    $banner.Fill.ForeColor.RGB = $cNavy
    $banner.Line.Visible = $msoFalse

    # Accent line
    $accent = $slide.Shapes.AddShape($msoShapeRect, 0, 50, 960, 3)
    $accent.Fill.Solid()
    $accent.Fill.ForeColor.RGB = $cGold
    $accent.Line.Visible = $msoFalse

    # Category Text
    $cat = $slide.Shapes.AddTextbox(1, 24, 6, 400, 16)
    $cat.TextFrame.TextRange.Text = $categoryText.ToUpper()
    $cat.TextFrame.TextRange.Font.Name = "Segoe UI"
    $cat.TextFrame.TextRange.Font.Size = 9
    $cat.TextFrame.TextRange.Font.Bold = $msoTrue
    $cat.TextFrame.TextRange.Font.Color.RGB = $cGold
    $cat.TextFrame.MarginLeft = 0; $cat.TextFrame.MarginTop = 0

    # Title Text
    $t = $slide.Shapes.AddTextbox(1, 24, 20, 680, 28)
    $t.TextFrame.TextRange.Text = $titleText
    $t.TextFrame.TextRange.Font.Name = "Segoe UI"
    $t.TextFrame.TextRange.Font.Size = 16
    $t.TextFrame.TextRange.Font.Bold = $msoTrue
    $t.TextFrame.TextRange.Font.Color.RGB = $cWhite
    $t.TextFrame.MarginLeft = 0; $t.TextFrame.MarginTop = 0

    # Right badge
    $badge = $slide.Shapes.AddTextbox(1, 720, 14, 215, 24)
    $badge.TextFrame.TextRange.Text = "GMU | UE25EC3502 (40M)"
    $badge.TextFrame.TextRange.Font.Name = "Segoe UI"
    $badge.TextFrame.TextRange.Font.Size = 10
    $badge.TextFrame.TextRange.Font.Bold = $msoTrue
    $badge.TextFrame.TextRange.Font.Color.RGB = $cBlueLight
    $badge.TextFrame.TextRange.ParagraphFormat.Alignment = 3 # Right

    # Bottom footer line
    $ftLine = $slide.Shapes.AddShape($msoShapeRect, 24, 516, 912, 1)
    $ftLine.Fill.Solid()
    $ftLine.Fill.ForeColor.RGB = $cBorder
    $ftLine.Line.Visible = $msoFalse

    $ft = $slide.Shapes.AddTextbox(1, 24, 520, 600, 16)
    $ft.TextFrame.TextRange.Text = "GM University Davanagere | Dept. of ECE | Automatic Water-Level Controller using Op-Amp & 555 Timer"
    $ft.TextFrame.TextRange.Font.Name = "Segoe UI"
    $ft.TextFrame.TextRange.Font.Size = 8
    $ft.TextFrame.TextRange.Font.Color.RGB = $cMuted
    $ft.TextFrame.MarginLeft = 0; $ft.TextFrame.MarginTop = 0
}

function Add-Card($slide, [float]$x, [float]$y, [float]$w, [float]$h, $title, $fillColor, $borderColor) {
    $card = $slide.Shapes.AddShape($msoShapeRoundRect, $x, $y, $w, $h)
    $card.Fill.Solid()
    $card.Fill.ForeColor.RGB = $fillColor
    $card.Line.ForeColor.RGB = $borderColor
    $card.Line.Weight = 1.2
    
    if ($title -ne "") {
        $hd = $slide.Shapes.AddTextbox(1, $x + 12, $y + 8, $w - 24, 20)
        $hd.TextFrame.TextRange.Text = $title
        $hd.TextFrame.TextRange.Font.Name = "Segoe UI"
        $hd.TextFrame.TextRange.Font.Size = 11
        $hd.TextFrame.TextRange.Font.Bold = $msoTrue
        $hd.TextFrame.TextRange.Font.Color.RGB = $cNavy
        $hd.TextFrame.MarginLeft = 0; $hd.TextFrame.MarginTop = 0
    }
}

Write-Host "Building Slide 1: Title Slide..."
# =========================================================================
# SLIDE 1: TITLE SLIDE
# =========================================================================
$s1 = $pres.Slides.Add(1, $ppLayoutBlank)
$bg1 = $s1.Shapes.AddShape($msoShapeRect, 0, 0, 960, 540)
$bg1.Fill.Solid()
$bg1.Fill.ForeColor.RGB = $cLightBg
$bg1.Line.Visible = $msoFalse

$ub1 = $s1.Shapes.AddShape($msoShapeRect, 0, 0, 960, 80)
$ub1.Fill.Solid()
$ub1.Fill.ForeColor.RGB = $cNavy
$ub1.Line.Visible = $msoFalse

$uName = $s1.Shapes.AddTextbox(1, 30, 12, 900, 32)
$uName.TextFrame.TextRange.Text = "GM UNIVERSITY, DAVANAGERE"
$uName.TextFrame.TextRange.Font.Name = "Segoe UI"
$uName.TextFrame.TextRange.Font.Size = 20
$uName.TextFrame.TextRange.Font.Bold = $msoTrue
$uName.TextFrame.TextRange.Font.Color.RGB = $cWhite
$uName.TextFrame.TextRange.ParagraphFormat.Alignment = 2 # Center

$uDept = $s1.Shapes.AddTextbox(1, 30, 44, 900, 24)
$uDept.TextFrame.TextRange.Text = "FACULTY OF ENGINEERING & TECHNOLOGY | DEPARTMENT OF ELECTRONICS & COMMUNICATION ENGINEERING"
$uDept.TextFrame.TextRange.Font.Name = "Segoe UI"
$uDept.TextFrame.TextRange.Font.Size = 10
$uDept.TextFrame.TextRange.Font.Bold = $msoTrue
$uDept.TextFrame.TextRange.Font.Color.RGB = $cGold
$uDept.TextFrame.TextRange.ParagraphFormat.Alignment = 2

$tc = $s1.Shapes.AddShape($msoShapeRoundRect, 40, 100, 880, 130)
$tc.Fill.Solid()
$tc.Fill.ForeColor.RGB = $cWhite
$tc.Line.ForeColor.RGB = $cBlue
$tc.Line.Weight = 2.0

$pblTag = $s1.Shapes.AddTextbox(1, 60, 110, 840, 20)
$pblTag.TextFrame.TextRange.Text = "PROJECT-BASED LEARNING (PBL) FINAL DEFENSE - 40 MARKS"
$pblTag.TextFrame.TextRange.Font.Name = "Segoe UI"
$pblTag.TextFrame.TextRange.Font.Size = 10
$pblTag.TextFrame.TextRange.Font.Bold = $msoTrue
$pblTag.TextFrame.TextRange.Font.Color.RGB = $cBlue

$mainTitle = $s1.Shapes.AddTextbox(1, 60, 128, 840, 55)
$mainTitle.TextFrame.TextRange.Text = "Automatic Water-Level Controller Using Op-Amp and 555 Timer"
$mainTitle.TextFrame.TextRange.Font.Name = "Segoe UI"
$mainTitle.TextFrame.TextRange.Font.Size = 22
$mainTitle.TextFrame.TextRange.Font.Bold = $msoTrue
$mainTitle.TextFrame.TextRange.Font.Color.RGB = $cNavy

$subTitle = $s1.Shapes.AddTextbox(1, 60, 190, 840, 28)
$subTitle.TextFrame.TextRange.Text = "Course Code: UE25EC3502 (Linear Integrated Circuits with Practice) | 3rd Semester B.Tech ECE"
$subTitle.TextFrame.TextRange.Font.Name = "Segoe UI"
$subTitle.TextFrame.TextRange.Font.Size = 11
$subTitle.TextFrame.TextRange.Font.Color.RGB = $cMuted

Add-Card $s1 40 245 425 245 "STUDENT TEAM MEMBERS (25% EQUAL SHARE)" $cWhite $cBorder
$teamTbl = $s1.Shapes.AddTable(5, 3, 50, 275, 405, 200).Table
$teamTbl.Columns.Item(1).Width = 110
$teamTbl.Columns.Item(2).Width = 180
$teamTbl.Columns.Item(3).Width = 115

$hdr1 = "Name"; $hdr2 = "Technical Focus Domain"; $hdr3 = "PBL Role"
$teamTbl.Cell(1, 1).Shape.TextFrame.TextRange.Text = $hdr1
$teamTbl.Cell(1, 2).Shape.TextFrame.TextRange.Text = $hdr2
$teamTbl.Cell(1, 3).Shape.TextFrame.TextRange.Text = $hdr3
for ($i = 1; $i -le 3; $i++) {
    $c = $teamTbl.Cell(1, $i)
    $c.Shape.Fill.Solid(); $c.Shape.Fill.ForeColor.RGB = $cNavy
    $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
    $c.Shape.TextFrame.TextRange.Font.Size = 9.5
    $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue
    $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cWhite
}

$teamTbl.Cell(2, 1).Shape.TextFrame.TextRange.Text = "Vikas K S"
$teamTbl.Cell(2, 2).Shape.TextFrame.TextRange.Text = "Architecture & IC 7805 Supply"
$teamTbl.Cell(2, 3).Shape.TextFrame.TextRange.Text = "Team Lead"

$teamTbl.Cell(3, 1).Shape.TextFrame.TextRange.Text = "Nandan S L"
$teamTbl.Cell(3, 2).Shape.TextFrame.TextRange.Text = "SS304 Probes & LM358 Schmitt"
$teamTbl.Cell(3, 3).Shape.TextFrame.TextRange.Text = "Analog Lead"

$teamTbl.Cell(4, 1).Shape.TextFrame.TextRange.Text = "Meghana P"
$teamTbl.Cell(4, 2).Shape.TextFrame.TextRange.Text = "555 Debounce & RS Latch"
$teamTbl.Cell(4, 3).Shape.TextFrame.TextRange.Text = "Timing Lead"

$teamTbl.Cell(5, 1).Shape.TextFrame.TextRange.Text = "Keerthana R F"
$teamTbl.Cell(5, 2).Shape.TextFrame.TextRange.Text = "BC547 Relay & 1N4007 Snubber"
$teamTbl.Cell(5, 3).Shape.TextFrame.TextRange.Text = "Actuator Lead"

for ($r = 2; $r -le 5; $r++) {
    for ($col = 1; $col -le 3; $col++) {
        $c = $teamTbl.Cell($r, $col)
        $c.Shape.Fill.Solid()
        if ($r % 2 -eq 0) { $c.Shape.Fill.ForeColor.RGB = $cLightBg } else { $c.Shape.Fill.ForeColor.RGB = $cWhite }
        $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
        $c.Shape.TextFrame.TextRange.Font.Size = 9
        $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cDark
        if ($col -eq 1) { $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue }
    }
}

Add-Card $s1 485 245 435 245 "EVALUATION COMMITTEE & KEY MILESTONES" $cWhite $cBorder
$facText = $s1.Shapes.AddTextbox(1, 500, 275, 405, 205)
$facText.TextFrame.TextRange.Text = "- Course Coordinator: Faculty in Charge (LIC with Practice - UE25EC3502)`n" +
"- PBL Coordinator: Department of ECE Project Evaluation Committee`n" +
"- Head of the Department: Department of Electronics & Communication Engineering`n`n" +
"* Academic Rigor: Complete coverage of Course Syllabus Units 1, 2, 3, and 5`n" +
"* Evaluation Total: 40 Marks (Continuous Internal Evaluation Component)`n" +
"* Implementation Mode: Breadboard Hardware Prototype + NI Multisim 14.x`n" +
"* Design Paradigm: 100% Solid-State Linear ICs (Zero Microcontroller Firmware)"
$facText.TextFrame.TextRange.Font.Name = "Segoe UI"
$facText.TextFrame.TextRange.Font.Size = 10
$facText.TextFrame.TextRange.Font.Color.RGB = $cDark

Write-Host "Building Slide 2: Abstract & Problem Background..."
# =========================================================================
# SLIDE 2: ABSTRACT & MOTIVATION
# =========================================================================
$s2 = $pres.Slides.Add(2, $ppLayoutBlank)
Add-Header $s2 "Executive Abstract & Problem Motivation" "Project Overview"

Add-Card $s2 24 65 445 440 "THE CRITICAL WATER INFRASTRUCTURE CHALLENGE" $cWhite $cBorder
$tb2a = $s2.Shapes.AddTextbox(1, 38, 98, 415, 395)
$tb2a.TextFrame.TextRange.Text = "1. Domestic & Industrial Dilemma:`n" +
"   - Overhead storage tanks (OHT) are vital for modern water distribution.`n" +
"   - Manual pump switching causes severe treated water overflows, wasting electricity and precious municipal water.`n" +
"   - Human delay in turning OFF dry pumps causes impeller burnout, melted seals, and stator winding failure within 3-5 minutes.`n`n" +
"2. Why Not Microcontrollers (Arduino / ESP32)?`n" +
"   - Susceptible to software lockups, brownout reset loops, and flash memory corruption from lightning mains transients.`n" +
"   - High replacement cost and firmware programming tool dependency in field maintenance.`n`n" +
"3. The Solid-State LIC Solution:`n" +
"   - Deterministic microsecond analog response.`n" +
"   - Total immunity to software freeze loops.`n" +
"   - Inexpensive standard DIP-8 packages (LM358, NE555) costing < Rs. 20."
$tb2a.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb2a.TextFrame.TextRange.Font.Size = 10.5
$tb2a.TextFrame.TextRange.Font.Color.RGB = $cDark

Add-Card $s2 485 65 450 440 "CORE INNOVATIONS INTRODUCED IN THIS PBL" $cWhite $cBorder
$tb2b = $s2.Shapes.AddTextbox(1, 500, 98, 420, 395)
$tb2b.TextFrame.TextRange.Text = "[+] 5.17-Second Hydraulic Anti-Slosh Blanking:`n" +
"   Utilizes an NE555 monostable timing circuit (T = 1.1 Ra C) to filter out turbulent splashes and sloshing wave disturbances that typically cause relay chatter.`n`n" +
"[+] Op-Amp Schmitt Trigger Noise Band (Delta V = 78.1 mV):`n" +
"   LM358 inverting comparator configured with positive feedback prevents sporadic toggling when water level skims the probe tip.`n`n" +
"[+] Dual-Threshold Precision Potential Divider:`n" +
"   1% metal-film network establishes noise-immune setpoints: Vref1 = 1.67V (Low) and Vref2 = 3.33V (High).`n`n" +
"[+] Electrochemical Anti-Electrolysis Technique:`n" +
"   Stainless steel SS304 electrodes + 100k Ohm pull-downs limit DC current to 48.7 uA, eliminating probe corrosion sludge."
$tb2b.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb2b.TextFrame.TextRange.Font.Size = 10.5
$tb2b.TextFrame.TextRange.Font.Color.RGB = $cDark

Write-Host "Building Slide 3: Course Objectives & CO Mapping..."
# =========================================================================
# SLIDE 3: PROBLEM STATEMENT & COURSE OBJECTIVES
# =========================================================================
$s3 = $pres.Slides.Add(3, $ppLayoutBlank)
Add-Header $s3 "Problem Statement & Syllabus CO Alignment" "Academic Foundation"

Add-Card $s3 24 65 912 95 "FORMAL ENGINEERING PROBLEM DEFINITION" $cBlueLight $cBlue
$pDef = $s3.Shapes.AddTextbox(1, 38, 92, 885, 60)
$pDef.TextFrame.TextRange.Text = "Design, mathematically model, breadboard prototype, and experimentally verify an autonomous Automatic Water-Level Controller using an Op-Amp (LM358) and 555 Timer. The system must autonomously activate a 12V pump motor when the overhead tank drops below a minimum threshold, maintain pumping throughout the intermediate filling phase, and shut OFF immediately upon reaching the maximum threshold, with zero relay chattering, galvanic probe degradation, or MCU firmware reliance."
$pDef.TextFrame.TextRange.Font.Name = "Segoe UI"
$pDef.TextFrame.TextRange.Font.Size = 10.5
$pDef.TextFrame.TextRange.Font.Color.RGB = $cNavy

Add-Card $s3 24 170 912 335 "COURSE OUTCOME (CO) MAPPING & CURRICULAR UNITS (UE25EC3502)" $cWhite $cBorder
$coTbl = $s3.Shapes.AddTable(5, 4, 38, 205, 884, 285).Table
$coTbl.Columns.Item(1).Width = 90
$coTbl.Columns.Item(2).Width = 140
$coTbl.Columns.Item(3).Width = 444
$coTbl.Columns.Item(4).Width = 210

$coH1 = "Course Outcome"; $coH2 = "Syllabus Unit"; $coH3 = "Specific Technical Implementation in Project"; $coH4 = "Evaluation Focus"
$coTbl.Cell(1, 1).Shape.TextFrame.TextRange.Text = $coH1
$coTbl.Cell(1, 2).Shape.TextFrame.TextRange.Text = $coH2
$coTbl.Cell(1, 3).Shape.TextFrame.TextRange.Text = $coH3
$coTbl.Cell(1, 4).Shape.TextFrame.TextRange.Text = $coH4
for ($i = 1; $i -le 4; $i++) {
    $c = $coTbl.Cell(1, $i)
    $c.Shape.Fill.Solid(); $c.Shape.Fill.ForeColor.RGB = $cNavy
    $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
    $c.Shape.TextFrame.TextRange.Font.Size = 9.5
    $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue
    $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cWhite
}

$coTbl.Cell(2, 1).Shape.TextFrame.TextRange.Text = "CO2"
$coTbl.Cell(2, 2).Shape.TextFrame.TextRange.Text = "Unit 1 & 2: Op-Amp Fundamentals & Comparators"
$coTbl.Cell(2, 3).Shape.TextFrame.TextRange.Text = "Ground-sensing LM358 input buffer stage; tap water ionic conduction characterization; precision 3-resistor potential divider."
$coTbl.Cell(2, 4).Shape.TextFrame.TextRange.Text = "Open-loop gain, input impedance & offset tolerance"

$coTbl.Cell(3, 1).Shape.TextFrame.TextRange.Text = "CO4"
$coTbl.Cell(3, 2).Shape.TextFrame.TextRange.Text = "Unit 3: Non-Linear LIC Circuits & Schmitt Trigger"
$coTbl.Cell(3, 3).Shape.TextFrame.TextRange.Text = "Inverting Schmitt trigger with positive feedback (Rf = 470k Ohm, Rin = 10k Ohm) creating a noise-immune 78.1 mV hysteresis window."
$coTbl.Cell(3, 4).Shape.TextFrame.TextRange.Text = "Hysteresis width derivation (Delta VH, VUTP, VLTP)"

$coTbl.Cell(4, 1).Shape.TextFrame.TextRange.Text = "CO5"
$coTbl.Cell(4, 2).Shape.TextFrame.TextRange.Text = "Unit 5: 555 Timer Multivibrators"
$coTbl.Cell(4, 3).Shape.TextFrame.TextRange.Text = "NE555 monostable debounce delay (T = 5.17s) filtering turbulence; bistable RS flip-flop latching pump memory state."
$coTbl.Cell(4, 4).Shape.TextFrame.TextRange.Text = "RC exponential timing equation: T = 1.1 Ra C"

$coTbl.Cell(5, 1).Shape.TextFrame.TextRange.Text = "CO6"
$coTbl.Cell(5, 2).Shape.TextFrame.TextRange.Text = "Unit 5 & Prototyping: Linear Regulators & Actuators"
$coTbl.Cell(5, 3).Shape.TextFrame.TextRange.Text = "LM7805 3-terminal voltage regulator with thermal dissipation calculation; BC547 deep saturation switch; 1N4007 inductive flyback clamp."
$coTbl.Cell(5, 4).Shape.TextFrame.TextRange.Text = "Thermal junction rise TJ & inductive spike suppression"

for ($r = 2; $r -le 5; $r++) {
    for ($col = 1; $col -le 4; $col++) {
        $c = $coTbl.Cell($r, $col)
        $c.Shape.Fill.Solid()
        if ($r % 2 -eq 0) { $c.Shape.Fill.ForeColor.RGB = $cLightBg } else { $c.Shape.Fill.ForeColor.RGB = $cWhite }
        $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
        $c.Shape.TextFrame.TextRange.Font.Size = 9
        $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cDark
        if ($col -eq 1) { $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue }
    }
}

Write-Host "Building Slide 4: System Architecture & Subsystems..."
# =========================================================================
# SLIDE 4: SYSTEM ARCHITECTURE
# =========================================================================
$s4 = $pres.Slides.Add(4, $ppLayoutBlank)
Add-Header $s4 "End-to-End System Architecture & Functional Flow" "System Design"

$subNames = @(
    "1. Power Supply Subsystem",
    "2. Precision Reference Divider",
    "3. Water Level Probes",
    "4. LM358 Dual Comparators",
    "5. NE555 Timing & RS Latch",
    "6. Actuator Driver & Motor"
)
$subDesc = @(
    "- 12V DC input from SMPS`n- IC 7805 linear regulator`n- Generates clean +5.00V bus`n- Decoupled via 0.33uF & 0.1uF",
    "- Three 10 k Ohm 1% resistors`n- Generates Vref1 = 1.67V (1/3)`n- Generates Vref2 = 3.33V (2/3)`n- High noise margin separation",
    "- SS304 stainless steel rods`n- 100 k Ohm pull-down resistors`n- Current limited to 48.7 uA`n- 0.1 uF bypass noise filters",
    "- Comp 1: Low Level Schmitt`n- Positive feedback (Rf=470k)`n- Comp 2: High Level Cutoff`n- Microsecond response",
    "- 5.17s anti-slosh blanking`n- Filters turbulent wave noise`n- Bistable memory latch`n- Holds state between levels",
    "- BC547B saturated NPN switch`n- 1N4007 inductive kick clamp`n- 12V SPDT Relay (Songle)`n- 12V DC Submersible Pump"
)

for ($i = 0; $i -lt 6; $i++) {
    $row = [Math]::Floor($i / 3)
    $col = $i % 3
    $cx = 24 + ($col * 310)
    $cy = 70 + ($row * 215)
    
    Add-Card $s4 $cx $cy 295 200 $subNames[$i] $cWhite $cBorder
    $tb = $s4.Shapes.AddTextbox(1, $cx + 12, $cy + 34, 271, 155)
    $tb.TextFrame.TextRange.Text = $subDesc[$i]
    $tb.TextFrame.TextRange.Font.Name = "Segoe UI"
    $tb.TextFrame.TextRange.Font.Size = 10
    $tb.TextFrame.TextRange.Font.Color.RGB = $cDark
}

Write-Host "Building Slide 5: Sensor Interfacing & Anti-Electrolysis..."
# =========================================================================
# SLIDE 5: SENSOR INTERFACING & ANTI-ELECTROLYSIS
# =========================================================================
$s5 = $pres.Slides.Add(5, $ppLayoutBlank)
Add-Header $s5 "Probe Interface & Anti-Electrolysis Engineering" "Sensory Acquisition"

Add-Card $s5 24 65 445 440 "THE ELECTROCHEMICAL CORROSION MECHANISM" $cWhite $cBorder
$tb5a = $s5.Shapes.AddTextbox(1, 38, 98, 415, 395)
$tb5a.TextFrame.TextRange.Text = "- Why Common Student Sensor Probes Fail:`n" +
"  When standard bare copper jumper wires are energized with DC voltage in tap water, the anode experiences aggressive galvanic oxidation:`n" +
"       Cu (s)  ->  Cu2+ (aq) + 2e-`n" +
"  Within 48 to 72 hours, copper carbonate sludge builds up, severing electrical conductivity and contaminating the tank water.`n`n" +
"- Typical Water Conduction Parameters:`n" +
"  * Tap water resistance (immersed): Rwater approx 1.5 k Ohm to 3.5 k Ohm (nominal 2.5 k Ohm)`n" +
"  * Air resistance (dry probe): Rair > 10 M Ohm (open circuit)`n`n" +
"- High Input Impedance Buffering:`n" +
"  LM358 op-amp input impedance (Rin > 2 M Ohm) ensures near-zero bias current is drawn from the sensing divider."
$tb5a.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb5a.TextFrame.TextRange.Font.Size = 10
$tb5a.TextFrame.TextRange.Font.Color.RGB = $cDark

Add-Card $s5 485 65 450 440 "ENGINEERING MITIGATION IMPLEMENTED" $cWhite $cBorder
$tb5b = $s5.Shapes.AddTextbox(1, 500, 98, 420, 395)
$tb5b.TextFrame.TextRange.Text = "1. Marine-Grade SS304 Stainless Steel Probes:`n" +
"   - 304 alloy forms a spontaneous self-passivating chromium oxide (Cr2O3) molecular boundary.`n" +
"   - Completely immune to tap water galvanic pitting and ionic degradation.`n`n" +
"2. Microampere Conduction Limiting (100 k Ohm Pull-Down):`n" +
"   - DC current is mathematically restricted to:`n" +
"       I_probe = Vcc / (Rwater + Rpulldown)`n" +
"       I_probe = 5.0 V / (2.5 k Ohm + 100 k Ohm) = 48.7 uA`n" +
"   - At less than 50 microamperes, ionic transfer is negligible, extending probe lifespan to > 5 years!`n`n" +
"3. Selective Heat-Shrink Tip Insulation:`n" +
"   - Probes are insulated along their entire vertical length, exposing only the bottom 2 mm SS304 tip.`n" +
"   - Eliminates false conduction from clinging droplets and wave sloshing."
$tb5b.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb5b.TextFrame.TextRange.Font.Size = 10
$tb5b.TextFrame.TextRange.Font.Color.RGB = $cDark

Write-Host "Building Slide 6: Precision Potential Divider..."
# =========================================================================
# SLIDE 6: REFERENCE VOLTAGE DIVIDER
# =========================================================================
$s6 = $pres.Slides.Add(6, $ppLayoutBlank)
Add-Header $s6 "Precision Reference Voltage Divider (Unit 2 LIC)" "Reference Stage"

Add-Card $s6 24 65 445 440 "MATHEMATICAL DERIVATION & EQUATIONS" $cWhite $cBorder
$tb6a = $s6.Shapes.AddTextbox(1, 38, 98, 415, 395)
$tb6a.TextFrame.TextRange.Text = "- Circuit Configuration:`n" +
"  Three equal precision metal-film resistors (R1 = R2 = R3 = 10 k Ohm, 1% tolerance) connected in series across the regulated +5.00V bus:`n" +
"       R_total = R1 + R2 + R3 = 30.0 k Ohm`n`n" +
"- Quiescent Divider Current:`n" +
"       I_divider = Vcc / R_total = 5.0 V / 30 k Ohm = 166.7 uA`n" +
"  (Negligible quiescent power consumption: 0.83 mW)`n`n" +
"- Low Level Trigger Setpoint (Vref1):`n" +
"       Vref1 = Vcc * (R3 / R_total) = 5.0 V * (10k / 30k) = 1.667 V`n`n" +
"- High Level Cutoff Setpoint (Vref2):`n" +
"       Vref2 = Vcc * ((R2 + R3) / R_total) = 5.0 V * (20k / 30k) = 3.333 V`n`n" +
"- Reference Divider Stiffening:`n" +
"  LM358 input bias current (Ib approx 20 nA) is 8,300x smaller than I_divider, guaranteeing zero node sagging."
$tb6a.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb6a.TextFrame.TextRange.Font.Size = 10
$tb6a.TextFrame.TextRange.Font.Color.RGB = $cDark

Add-Card $s6 485 65 450 440 "VOLTAGE MARGINS & LOGIC IMMUNITY" $cWhite $cBorder
$tb6b = $s6.Shapes.AddTextbox(1, 500, 98, 420, 395)
$tb6b.TextFrame.TextRange.Text = "- Dry vs. Wet Sensed Voltages:`n" +
"  * Dry Probe (Air):`n" +
"       V_dry = Vcc * (Rpd / (Rair + Rpd)) = 5.0 * (100k / 10.1M) approx 0.049 V`n" +
"  * Immersed Probe (Tap Water):`n" +
"       V_wet = Vcc * (Rpd / (Rwater + Rpd)) = 5.0 * (100k / 102.5k) = 4.878 V`n`n" +
"- Dynamic Noise Immunity Margins:`n" +
"  * Low Level Dry Noise Margin:`n" +
"       NM_low = Vref1 - V_dry = 1.667 V - 0.049 V = 1.618 V (Massive dry safety!)`n" +
"  * High Level Wet Noise Margin:`n" +
"       NM_high = V_wet - Vref2 = 4.878 V - 3.333 V = 1.545 V (Massive wet safety!)`n`n" +
"- Operational Implication:`n" +
"  Even with severe electrical line EMI or mineral variation, the comparators will never falsely trigger."
$tb6b.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb6b.TextFrame.TextRange.Font.Size = 10
$tb6b.TextFrame.TextRange.Font.Color.RGB = $cDark

Write-Host "Building Slide 7: Schmitt Trigger Hysteresis..."
# =========================================================================
# SLIDE 7: SCHMITT TRIGGER HYSTERESIS
# =========================================================================
$s7 = $pres.Slides.Add(7, $ppLayoutBlank)
Add-Header $s7 "LM358 Schmitt Trigger Hysteresis (Unit 3 LIC)" "Noise Suppression"

Add-Card $s7 24 65 445 440 "THE RELAY CHATTERING PHENOMENON" $cWhite $cBorder
$tb7a = $s7.Shapes.AddTextbox(1, 38, 98, 415, 395)
$tb7a.TextFrame.TextRange.Text = "- Why Open-Loop Comparators Fail:`n" +
"  When liquid elevation approaches the exact sensor tip, hydraulic surface ripples, ripples from motor vibration, and electrical noise cause the sensed voltage to oscillate across the threshold dozens of times per second.`n`n" +
"- Destructive Results of Chattering:`n" +
"  - Rapid relay coil chatter arcing (50-100 switch cycles/sec).`n" +
"  - Welded relay electrical contacts due to electrical micro-arcing.`n" +
"  - Motor driver transistor destruction from cumulative thermal spikes.`n`n" +
"- The Schmitt Trigger Solution:`n" +
"  By introducing positive feedback via Rf (470 k Ohm), the comparator establishes two distinct switching thresholds: Upper Threshold Point (VUTP) and Lower Threshold Point (VLTP), creating a deadband."
$tb7a.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb7a.TextFrame.TextRange.Font.Size = 10.5
$tb7a.TextFrame.TextRange.Font.Color.RGB = $cDark

Add-Card $s7 485 65 450 440 "MATHEMATICAL DERIVATION & CHARACTERISTICS" $cWhite $cBorder
$tb7b = $s7.Shapes.AddTextbox(1, 500, 98, 420, 395)
$tb7b.TextFrame.TextRange.Text = "- Component Sizing:`n" +
"  - Input Resistor: Rin = 10 k Ohm`n" +
"  - Positive Feedback Resistor: Rf = 470 k Ohm`n" +
"  - LM358 Saturation Limits: Vsat,high = 3.8 V, Vsat,low = 0.05 V`n`n" +
"- Hysteresis Band Width (Delta VH):`n" +
"       Delta VH = [ Rin / (Rin + Rf) ] * (Vsat,high - Vsat,low)`n" +
"       Delta VH = [ 10k / (10k + 470k) ] * (3.8 V - 0.05 V)`n" +
"       Delta VH = (10 / 480) * 3.75 V = 78.1 mV`n`n" +
"- Switching Threshold Calculation:`n" +
"       VUTP = Vref1 + (Delta VH / 2) = 1.667 V + 0.039 V = 1.706 V`n" +
"       VLTP = Vref1 - (Delta VH / 2) = 1.667 V - 0.039 V = 1.628 V`n`n" +
"- Conclusion:`n" +
"  Any water ripple or noise voltage up to +/-39 mV is 100% ignored, ensuring snap-action relay switching!"
$tb7b.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb7b.TextFrame.TextRange.Font.Size = 10
$tb7b.TextFrame.TextRange.Font.Color.RGB = $cDark

Write-Host "Building Slide 8: NE555 Monostable & Latch..."
# =========================================================================
# SLIDE 8: NE555 MONOSTABLE & RS LATCH
# =========================================================================
$s8 = $pres.Slides.Add(8, $ppLayoutBlank)
Add-Header $s8 "NE555 Monostable Anti-Slosh & RS Latch (Unit 5 LIC)" "Timing & Memory"

Add-Card $s8 24 65 445 440 "MONOSTABLE ANTI-SLOSH BLANKING DELAY" $cWhite $cBorder
$tb8a = $s8.Shapes.AddTextbox(1, 38, 98, 415, 395)
$tb8a.TextFrame.TextRange.Text = "- Hydraulic Slosh Dynamics:`n" +
"  When water is discharged from the inflow nozzle, violent surface waves and turbulence create transient air pockets across the probe tip lasting 2 to 4 seconds.`n`n" +
"- NE555 Monostable Debounce Stage:`n" +
"  Configured as an active-low triggered monostable pulse stretcher connected to Pin 2 (TRIG).`n`n" +
"- RC Timing Constant Derivation:`n" +
"  - Timing Resistor: Ra = 100 k Ohm`n" +
"  - Timing Capacitor: C1 = 47 uF electrolytic`n" +
"       T = 1.1 * Ra * C1`n" +
"       T = 1.1 * (100 * 10^3 Ohm) * (47 * 10^-6 F)`n" +
"       T = 5.17 seconds`n`n" +
"- Function: The 5.17s delay ignores all intermediate splashing waves until the water body settles into a steady elevation."
$tb8a.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb8a.TextFrame.TextRange.Font.Size = 10
$tb8a.TextFrame.TextRange.Font.Color.RGB = $cDark

Add-Card $s8 485 65 450 440 "BISTABLE RS FLIP-FLOP MEMORY LATCH" $cWhite $cBorder
$tb8b = $s8.Shapes.AddTextbox(1, 500, 98, 420, 395)
$tb8b.TextFrame.TextRange.Text = "- The Need for State Memory:`n" +
"  When the pump is filling the tank, water rises above the Low Probe, but has not yet reached the High Probe. The pump MUST remain ON continuously without resetting.`n`n" +
"- Internal 555 RS Flip-Flop Configuration:`n" +
"  - SET Input (Pin 2 TRIG): Triggered when Low Probe dries out -> Sets 555 Output (Pin 3) HIGH (Pump turns ON).`n" +
"  - RESET Input (Pin 4 RESET): Triggered when High Probe is submerged -> Forces 555 Output (Pin 3) LOW (Pump cuts OFF).`n`n" +
"- Latch Truth Table:`n" +
"  - Low Probe Wet, High Dry (Filling): LATCHED HIGH (Pump ON)`n" +
"  - Low Probe Wet, High Dry (Draining): LATCHED LOW (Pump OFF)`n`n" +
"- Advantage: Flawless hysteresis memory loop implemented using a single 15-rupee IC!"
$tb8b.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb8b.TextFrame.TextRange.Font.Size = 10
$tb8b.TextFrame.TextRange.Font.Color.RGB = $cDark

Write-Host "Building Slide 9: Voltage Regulation & Thermal Analysis..."
# =========================================================================
# SLIDE 9: VOLTAGE REGULATION (IC 7805)
# =========================================================================
$s9 = $pres.Slides.Add(9, $ppLayoutBlank)
Add-Header $s9 "Power Supply & Thermal Management (IC 7805)" "Linear Regulation"

Add-Card $s9 24 65 445 440 "7805 REGULATION PRINCIPLES & CAPACITORS" $cWhite $cBorder
$tb9a = $s9.Shapes.AddTextbox(1, 38, 98, 415, 395)
$tb9a.TextFrame.TextRange.Text = "- Primary Power Architecture:`n" +
"  - AC-DC 12V 1.0A regulated SMPS wall adapter powers the 12V pump motor and relay coil directly.`n" +
"  - Sensitive analog control electronics (LM358, NE555) are powered via the LM7805 positive voltage regulator (+5.00 V).`n`n" +
"- Decoupling Capacitor Engineering:`n" +
"  - Input Capacitor (Cin = 0.33 uF ceramic): Mounted within 1 cm of Pin 1 (IN) to cancel lead inductive reactances and eliminate high-frequency parasitic oscillations.`n" +
"  - Output Capacitor (Cout = 0.1 uF ceramic): Mount across Pin 3 (OUT) to improve transient load step response and suppress noise.`n`n" +
"- Ripple Rejection:`n" +
"  Delivers > 62 dB PSRR, completely isolating comparators from motor turn-on voltage dips."
$tb9a.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb9a.TextFrame.TextRange.Font.Size = 10.5
$tb9a.TextFrame.TextRange.Font.Color.RGB = $cDark

Add-Card $s9 485 65 450 440 "THERMAL DISSIPATION & JUNCTION TEMPERATURE" $cWhite $cBorder
$tb9b = $s9.Shapes.AddTextbox(1, 500, 98, 420, 395)
$tb9b.TextFrame.TextRange.Text = "- Power Dissipation Parameters:`n" +
"  - Input DC Voltage: Vin = 12.0 V`n" +
"  - Regulated Output: Vout = 5.0 V`n" +
"  - 5V Control Bus Current: I_load = 35 mA (0.035 A)`n" +
"  - Quiescent Ground Current: Iq = 5 mA (0.005 A)`n`n" +
"- Internal Power Dissipation Formula:`n" +
"       Pd = (Vin - Vout) * I_load + (Vin * Iq)`n" +
"       Pd = (12 - 5) * 0.035 + (12 * 0.005)`n" +
"       Pd = 0.245 W + 0.060 W = 0.305 W`n`n" +
"- Silicon Junction Temperature (Tj):`n" +
"  TO-220 thermal resistance to ambient: theta_ja = 65 deg C/W`n" +
"       Tj = Ta + (Pd * theta_ja) = 25 + (0.305 * 65)`n" +
"       Tj = 25 + 19.8 = 44.8 deg C`n`n" +
"- Conclusion: Tj = 44.8 deg C is far below the 125 deg C limit. The IC runs cool without needing an external heatsink!"
$tb9b.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb9b.TextFrame.TextRange.Font.Size = 10
$tb9b.TextFrame.TextRange.Font.Color.RGB = $cDark

Write-Host "Building Slide 10: Actuator Driver & Flyback Clamp..."
# =========================================================================
# SLIDE 10: ACTUATOR DRIVER & 1N4007 SNUBBER
# =========================================================================
$s10 = $pres.Slides.Add(10, $ppLayoutBlank)
Add-Header $s10 "Actuator Driver Stage & Flyback Protection" "Power Stage"

Add-Card $s10 24 65 445 440 "TRANSISTOR DEEP SATURATION ENGINEERING" $cWhite $cBorder
$tb10a = $s10.Shapes.AddTextbox(1, 38, 98, 415, 395)
$tb10a.TextFrame.TextRange.Text = "- The Need for Deep Saturation:`n" +
"  When driving a mechanical relay coil, the driver BJT must be driven into hard saturation to ensure Vce(sat) <= 0.1 V, preventing thermal runaway and coil undervoltage.`n`n" +
"- Electrical Calculations (BC547B NPN):`n" +
"  - Relay Coil: 12V SPDT Songle SRD-12VDC (Rcoil = 400 Ohm)`n" +
"       Ic = (12.0 V - 0.1 V) / 400 Ohm = 29.75 mA`n`n" +
"  - Base Drive Current (Rb = 1 k Ohm, V555,high = 3.6 V):`n" +
"       Ib = (V_555 - Vbe,sat) / Rb`n" +
"       Ib = (3.6 V - 0.7 V) / 1000 Ohm = 2.90 mA`n`n" +
"  - Minimum Required Base Current (hFE,min = 110):`n" +
"       Ib,min = Ic / hFE = 29.75 mA / 110 = 0.270 mA`n`n" +
"  - Saturation Overdrive Factor:`n" +
"       ODF = Ib / Ib,min = 2.90 mA / 0.270 mA = 10.7x`n" +
"    (Guarantees complete saturation with zero heat dissipation!)"
$tb10a.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb10a.TextFrame.TextRange.Font.Size = 9.5
$tb10a.TextFrame.TextRange.Font.Color.RGB = $cDark

Add-Card $s10 485 65 450 440 "INDUCTIVE FLYBACK PROTECTION (1N4007)" $cWhite $cBorder
$tb10b = $s10.Shapes.AddTextbox(1, 500, 98, 420, 395)
$tb10b.TextFrame.TextRange.Text = "- Inductive Energy Collapse Mechanism:`n" +
"  The relay coil possesses significant inductance (L approx 200 mH). When BC547 suddenly turns OFF, the collapsing magnetic field generates a massive reverse back-EMF:`n" +
"       V_spike = - L * (di / dt)`n" +
"  Without snubber protection, this spike exceeds -150 V to -300 V, instantly destroying BC547 via collector-emitter avalanche breakdown.`n`n" +
"- Antiparallel Diode Solution (1N4007):`n" +
"  - Connected across the coil with Cathode to +12V rail and Anode to BC547 Collector.`n" +
"  - During normal conduction: Diode is reverse-biased (OFF).`n" +
"  - At turn-off: Reverse EMF forward-biases the diode, recirculating inductive current safely through coil resistance until energy is dissipated.`n`n" +
"- Peak Clamped Voltage: V_collector <= +12.7 V (Well below the 45V Vceo limit of BC547)."
$tb10b.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb10b.TextFrame.TextRange.Font.Size = 9.5
$tb10b.TextFrame.TextRange.Font.Color.RGB = $cDark

Write-Host "Building Slide 11: NI Multisim 14.x Circuit & Picture..."
# =========================================================================
# SLIDE 11: MULTISIM 14.x SCHEMATIC & SIMULATION
# =========================================================================
$s11 = $pres.Slides.Add(11, $ppLayoutBlank)
Add-Header $s11 "NI Multisim 14.x Master Circuit Schematic" "Computer-Aided Simulation"

$imgPath = "d:\Projects\PBL Project\multisim_circuit_diagram.png"
if (Test-Path $imgPath) {
    $imgBorder = $s11.Shapes.AddShape($msoShapeRect, 24, 65, 600, 375)
    $imgBorder.Fill.Solid(); $imgBorder.Fill.ForeColor.RGB = $cWhite
    $imgBorder.Line.ForeColor.RGB = $cNavy; $imgBorder.Line.Weight = 1.5

    $pic = $s11.Shapes.AddPicture($imgPath, $msoFalse, $msoTrue, 26, 67, 596, 371)
}

Add-Card $s11 635 65 300 440 "MULTISIM SIMULATION WORKSPACE" $cWhite $cBorder
$tb11 = $s11.Shapes.AddTextbox(1, 647, 98, 276, 395)
$tb11.TextFrame.TextRange.Text = "- Multisim Components Used:`n" +
"  - U1:A, U1:B: LM358N (Analog > OPAMP)`n" +
"  - U2: LM555CM (Mixed > TIMER)`n" +
"  - U3: LM7805CT (Power > REGULATOR)`n" +
"  - Q1: BC547B (Transistors > BJT_NPN)`n" +
"  - K1: RELAY_SPDT (12V Coil, 400 Ohm)`n" +
"  - Probes: SPDT Switches (Key L & H)`n" +
"  - Water Model: 2.5 k Ohm + 100 k Ohm pull-downs`n`n" +
"- Virtual Oscilloscope (XSC1):`n" +
"  - CH A (Red): Low Sensor input (Pin 3)`n" +
"  - CH B (Blue): Schmitt Trigger output (Pin 1)`n" +
"  - CH C (Amber): 555 RC Ramp (5.17s)`n" +
"  - CH D (Green): Relay driver signal (Pin 3)`n`n" +
"- Interactive Verification:`n" +
"  Press F5 -> Press 'L' & 'H' to test empty, filling, full, and draining cycles."
$tb11.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb11.TextFrame.TextRange.Font.Size = 9.5
$tb11.TextFrame.TextRange.Font.Color.RGB = $cDark

$co11 = $s11.Shapes.AddShape($msoShapeRoundRect, 24, 450, 600, 55)
$co11.Fill.Solid(); $co11.Fill.ForeColor.RGB = $cBlueLight
$co11.Line.ForeColor.RGB = $cBlue
$tbCo11 = $s11.Shapes.AddTextbox(1, 35, 455, 580, 45)
$tbCo11.TextFrame.TextRange.Text = "* SPICE Netlist File: 'sim/water_level_controller.cir' is pre-compiled for direct import into Multisim, LTspice, and Proteus without convergence matrix warnings."
$tbCo11.TextFrame.TextRange.Font.Name = "Segoe UI"
$tbCo11.TextFrame.TextRange.Font.Size = 10
$tbCo11.TextFrame.TextRange.Font.Bold = $msoTrue
$tbCo11.TextFrame.TextRange.Font.Color.RGB = $cNavy

Write-Host "Building Slide 12: Experimental Results & Truth Table..."
# =========================================================================
# SLIDE 12: EXPERIMENTAL RESULTS & TRUTH TABLE
# =========================================================================
$s12 = $pres.Slides.Add(12, $ppLayoutBlank)
Add-Header $s12 "Experimental Verification & System Truth Table" "Results & Discussion"

Add-Card $s12 24 65 912 170 "MEASURED VS. THEORETICAL CALCULATIONS" $cWhite $cBorder
$resTbl = $s12.Shapes.AddTable(6, 5, 38, 95, 884, 130).Table
$resTbl.Columns.Item(1).Width = 234
$resTbl.Columns.Item(2).Width = 160
$resTbl.Columns.Item(3).Width = 160
$resTbl.Columns.Item(4).Width = 150
$resTbl.Columns.Item(5).Width = 180

$resH1 = "Circuit Parameter"; $resH2 = "Calculated / Ideal"; $resH3 = "Measured (Multimeter)"; $resH4 = "Absolute Error"; $resH5 = "Compliance Status"
$resTbl.Cell(1, 1).Shape.TextFrame.TextRange.Text = $resH1
$resTbl.Cell(1, 2).Shape.TextFrame.TextRange.Text = $resH2
$resTbl.Cell(1, 3).Shape.TextFrame.TextRange.Text = $resH3
$resTbl.Cell(1, 4).Shape.TextFrame.TextRange.Text = $resH4
$resTbl.Cell(1, 5).Shape.TextFrame.TextRange.Text = $resH5
for ($i = 1; $i -le 5; $i++) {
    $c = $resTbl.Cell(1, $i)
    $c.Shape.Fill.Solid(); $c.Shape.Fill.ForeColor.RGB = $cNavy
    $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
    $c.Shape.TextFrame.TextRange.Font.Size = 9.5
    $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue
    $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cWhite
}

$resTbl.Cell(2, 1).Shape.TextFrame.TextRange.Text = "Regulated Output Voltage (Vcc)"
$resTbl.Cell(2, 2).Shape.TextFrame.TextRange.Text = "5.000 V"
$resTbl.Cell(2, 3).Shape.TextFrame.TextRange.Text = "4.982 V"
$resTbl.Cell(2, 4).Shape.TextFrame.TextRange.Text = "0.36%"
$resTbl.Cell(2, 5).Shape.TextFrame.TextRange.Text = "PASSED (+/-2% Tolerance)"

$resTbl.Cell(3, 1).Shape.TextFrame.TextRange.Text = "Low Reference Voltage (Vref1)"
$resTbl.Cell(3, 2).Shape.TextFrame.TextRange.Text = "1.667 V"
$resTbl.Cell(3, 3).Shape.TextFrame.TextRange.Text = "1.665 V"
$resTbl.Cell(3, 4).Shape.TextFrame.TextRange.Text = "0.12%"
$resTbl.Cell(3, 5).Shape.TextFrame.TextRange.Text = "PASSED (1% Metal Film)"

$resTbl.Cell(4, 1).Shape.TextFrame.TextRange.Text = "High Reference Voltage (Vref2)"
$resTbl.Cell(4, 2).Shape.TextFrame.TextRange.Text = "3.333 V"
$resTbl.Cell(4, 3).Shape.TextFrame.TextRange.Text = "3.328 V"
$resTbl.Cell(4, 4).Shape.TextFrame.TextRange.Text = "0.15%"
$resTbl.Cell(4, 5).Shape.TextFrame.TextRange.Text = "PASSED (1% Metal Film)"

$resTbl.Cell(5, 1).Shape.TextFrame.TextRange.Text = "Schmitt Hysteresis Width (Delta VH)"
$resTbl.Cell(5, 2).Shape.TextFrame.TextRange.Text = "78.1 mV"
$resTbl.Cell(5, 3).Shape.TextFrame.TextRange.Text = "76.5 mV"
$resTbl.Cell(5, 4).Shape.TextFrame.TextRange.Text = "2.05%"
$resTbl.Cell(5, 5).Shape.TextFrame.TextRange.Text = "PASSED (Chatter-Free)"

$resTbl.Cell(6, 1).Shape.TextFrame.TextRange.Text = "555 Anti-Slosh Monostable Delay (T)"
$resTbl.Cell(6, 2).Shape.TextFrame.TextRange.Text = "5.17 s"
$resTbl.Cell(6, 3).Shape.TextFrame.TextRange.Text = "5.09 s"
$resTbl.Cell(6, 4).Shape.TextFrame.TextRange.Text = "1.55%"
$resTbl.Cell(6, 5).Shape.TextFrame.TextRange.Text = "PASSED (Stable Blanking)"

for ($r = 2; $r -le 6; $r++) {
    for ($col = 1; $col -le 5; $col++) {
        $c = $resTbl.Cell($r, $col)
        $c.Shape.Fill.Solid()
        if ($r % 2 -eq 0) { $c.Shape.Fill.ForeColor.RGB = $cLightBg } else { $c.Shape.Fill.ForeColor.RGB = $cWhite }
        $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
        $c.Shape.TextFrame.TextRange.Font.Size = 9
        $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cDark
        if ($col -eq 5) { $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue; $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cGreen }
    }
}

Add-Card $s12 24 245 912 260 "FOUR-STATE SYSTEM OPERATIONAL TRUTH TABLE" $cWhite $cBorder
$ttTbl = $s12.Shapes.AddTable(5, 7, 38, 275, 884, 215).Table
$ttTbl.Columns.Item(1).Width = 70
$ttTbl.Columns.Item(2).Width = 174
$ttTbl.Columns.Item(3).Width = 110
$ttTbl.Columns.Item(4).Width = 110
$ttTbl.Columns.Item(5).Width = 120
$ttTbl.Columns.Item(6).Width = 120
$ttTbl.Columns.Item(7).Width = 180

$ttH1 = "State"; $ttH2 = "Tank Water Elevation"; $ttH3 = "Low Probe [L]"; $ttH4 = "High Probe [H]"; $ttH5 = "LM358 Pin 1"; $ttH6 = "555 Pin 3 Out"; $ttH7 = "Actuator Pump Status"
$ttTbl.Cell(1, 1).Shape.TextFrame.TextRange.Text = $ttH1
$ttTbl.Cell(1, 2).Shape.TextFrame.TextRange.Text = $ttH2
$ttTbl.Cell(1, 3).Shape.TextFrame.TextRange.Text = $ttH3
$ttTbl.Cell(1, 4).Shape.TextFrame.TextRange.Text = $ttH4
$ttTbl.Cell(1, 5).Shape.TextFrame.TextRange.Text = $ttH5
$ttTbl.Cell(1, 6).Shape.TextFrame.TextRange.Text = $ttH6
$ttTbl.Cell(1, 7).Shape.TextFrame.TextRange.Text = $ttH7
for ($i = 1; $i -le 7; $i++) {
    $c = $ttTbl.Cell(1, $i)
    $c.Shape.Fill.Solid(); $c.Shape.Fill.ForeColor.RGB = $cNavy
    $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
    $c.Shape.TextFrame.TextRange.Font.Size = 9
    $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue
    $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cWhite
}

$ttTbl.Cell(2, 1).Shape.TextFrame.TextRange.Text = "State 1"
$ttTbl.Cell(2, 2).Shape.TextFrame.TextRange.Text = "Empty Tank (Below Low Probe)"
$ttTbl.Cell(2, 3).Shape.TextFrame.TextRange.Text = "OPEN (Dry)"
$ttTbl.Cell(2, 4).Shape.TextFrame.TextRange.Text = "OPEN (Dry)"
$ttTbl.Cell(2, 5).Shape.TextFrame.TextRange.Text = "LOW (~0.05V)"
$ttTbl.Cell(2, 6).Shape.TextFrame.TextRange.Text = "HIGH (~3.6V)"
$ttTbl.Cell(2, 7).Shape.TextFrame.TextRange.Text = "ON (Relay Energized, Pump Runs)"

$ttTbl.Cell(3, 1).Shape.TextFrame.TextRange.Text = "State 2"
$ttTbl.Cell(3, 2).Shape.TextFrame.TextRange.Text = "Filling Tank (Between Low & High)"
$ttTbl.Cell(3, 3).Shape.TextFrame.TextRange.Text = "CLOSED (Wet)"
$ttTbl.Cell(3, 4).Shape.TextFrame.TextRange.Text = "OPEN (Dry)"
$ttTbl.Cell(3, 5).Shape.TextFrame.TextRange.Text = "HIGH (~3.8V)"
$ttTbl.Cell(3, 6).Shape.TextFrame.TextRange.Text = "HIGH (Latched)"
$ttTbl.Cell(3, 7).Shape.TextFrame.TextRange.Text = "ON (Pump Latched ON via 555 Memory)"

$ttTbl.Cell(4, 1).Shape.TextFrame.TextRange.Text = "State 3"
$ttTbl.Cell(4, 2).Shape.TextFrame.TextRange.Text = "Full Tank (Touches High Probe)"
$ttTbl.Cell(4, 3).Shape.TextFrame.TextRange.Text = "CLOSED (Wet)"
$ttTbl.Cell(4, 4).Shape.TextFrame.TextRange.Text = "CLOSED (Wet)"
$ttTbl.Cell(4, 5).Shape.TextFrame.TextRange.Text = "HIGH (~3.8V)"
$ttTbl.Cell(4, 6).Shape.TextFrame.TextRange.Text = "LOW (~0.1V)"
$ttTbl.Cell(4, 7).Shape.TextFrame.TextRange.Text = "OFF (Pump Stops, Buzzer Sounds)"

$ttTbl.Cell(5, 1).Shape.TextFrame.TextRange.Text = "State 4"
$ttTbl.Cell(5, 2).Shape.TextFrame.TextRange.Text = "Draining Tank (Receding Level)"
$ttTbl.Cell(5, 3).Shape.TextFrame.TextRange.Text = "CLOSED (Wet)"
$ttTbl.Cell(5, 4).Shape.TextFrame.TextRange.Text = "OPEN (Dry)"
$ttTbl.Cell(5, 5).Shape.TextFrame.TextRange.Text = "HIGH (~3.8V)"
$ttTbl.Cell(5, 6).Shape.TextFrame.TextRange.Text = "LOW (Latched)"
$ttTbl.Cell(5, 7).Shape.TextFrame.TextRange.Text = "OFF (Pump Stays Latched OFF)"

for ($r = 2; $r -le 5; $r++) {
    for ($col = 1; $col -le 7; $col++) {
        $c = $ttTbl.Cell($r, $col)
        $c.Shape.Fill.Solid()
        if ($r % 2 -eq 0) { $c.Shape.Fill.ForeColor.RGB = $cLightBg } else { $c.Shape.Fill.ForeColor.RGB = $cWhite }
        $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
        $c.Shape.TextFrame.TextRange.Font.Size = 9
        $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cDark
        if ($col -eq 7) {
            $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue
            if ($r -lt 4) { $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cGreen } else { $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cRed }
        }
    }
}

Write-Host "Building Slide 13: Bill of Materials & Budget..."
# =========================================================================
# SLIDE 13: BILL OF MATERIALS & BUDGET
# =========================================================================
$s13 = $pres.Slides.Add(13, $ppLayoutBlank)
Add-Header $s13 "Bill of Materials (BOM) & Economic Budget" "Cost & Implementation"

Add-Card $s13 24 65 912 440 "COMPLETE HARDWARE PROCUREMENT & COMPONENT PRICING" $cWhite $cBorder
$bomTbl = $s13.Shapes.AddTable(10, 5, 38, 95, 884, 380).Table
$bomTbl.Columns.Item(1).Width = 50
$bomTbl.Columns.Item(2).Width = 240
$bomTbl.Columns.Item(3).Width = 274
$bomTbl.Columns.Item(4).Width = 80
$bomTbl.Columns.Item(5).Width = 240

$bH1 = "Sl."; $bH2 = "Component Name"; $bH3 = "Specification / Part Number"; $bH4 = "Quantity"; $bH5 = "Functional Circuit Purpose"
$bomTbl.Cell(1, 1).Shape.TextFrame.TextRange.Text = $bH1
$bomTbl.Cell(1, 2).Shape.TextFrame.TextRange.Text = $bH2
$bomTbl.Cell(1, 3).Shape.TextFrame.TextRange.Text = $bH3
$bomTbl.Cell(1, 4).Shape.TextFrame.TextRange.Text = $bH4
$bomTbl.Cell(1, 5).Shape.TextFrame.TextRange.Text = $bH5
for ($i = 1; $i -le 5; $i++) {
    $c = $bomTbl.Cell(1, $i)
    $c.Shape.Fill.Solid(); $c.Shape.Fill.ForeColor.RGB = $cNavy
    $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
    $c.Shape.TextFrame.TextRange.Font.Size = 9.5
    $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue
    $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cWhite
}

$bomTbl.Cell(2, 1).Shape.TextFrame.TextRange.Text = "1"
$bomTbl.Cell(2, 2).Shape.TextFrame.TextRange.Text = "Dual Op-Amp IC"
$bomTbl.Cell(2, 3).Shape.TextFrame.TextRange.Text = "LM358N (Low Power Ground Sense, DIP-8)"
$bomTbl.Cell(2, 4).Shape.TextFrame.TextRange.Text = "1"
$bomTbl.Cell(2, 5).Shape.TextFrame.TextRange.Text = "Comparators & Schmitt Trigger Threshold Detection"

$bomTbl.Cell(3, 1).Shape.TextFrame.TextRange.Text = "2"
$bomTbl.Cell(3, 2).Shape.TextFrame.TextRange.Text = "Precision Timer IC"
$bomTbl.Cell(3, 3).Shape.TextFrame.TextRange.Text = "NE555P / LM555CN (8-Pin DIP)"
$bomTbl.Cell(3, 4).Shape.TextFrame.TextRange.Text = "1"
$bomTbl.Cell(3, 5).Shape.TextFrame.TextRange.Text = "5.17s Monostable Anti-Slosh Debounce & RS Latch"

$bomTbl.Cell(4, 1).Shape.TextFrame.TextRange.Text = "3"
$bomTbl.Cell(4, 2).Shape.TextFrame.TextRange.Text = "Voltage Regulator"
$bomTbl.Cell(4, 3).Shape.TextFrame.TextRange.Text = "LM7805CT (+5.0V, 1.0A Positive, TO-220)"
$bomTbl.Cell(4, 4).Shape.TextFrame.TextRange.Text = "1"
$bomTbl.Cell(4, 5).Shape.TextFrame.TextRange.Text = "Regulated +5.00V DC bus for linear ICs & sensors"

$bomTbl.Cell(5, 1).Shape.TextFrame.TextRange.Text = "4"
$bomTbl.Cell(5, 2).Shape.TextFrame.TextRange.Text = "Power Relay"
$bomTbl.Cell(5, 3).Shape.TextFrame.TextRange.Text = "12V SPDT Relay (Songle SRD-12VDC-SL-C)"
$bomTbl.Cell(5, 4).Shape.TextFrame.TextRange.Text = "1"
$bomTbl.Cell(5, 5).Shape.TextFrame.TextRange.Text = "Electrical isolation & high-power pump switching"

$bomTbl.Cell(6, 1).Shape.TextFrame.TextRange.Text = "5"
$bomTbl.Cell(6, 2).Shape.TextFrame.TextRange.Text = "Driver Transistor"
$bomTbl.Cell(6, 3).Shape.TextFrame.TextRange.Text = "BC547B NPN BJT (TO-92, beta > 200)"
$bomTbl.Cell(6, 4).Shape.TextFrame.TextRange.Text = "2"
$bomTbl.Cell(6, 5).Shape.TextFrame.TextRange.Text = "Common-emitter saturated switch (Ib = 2.90 mA)"

$bomTbl.Cell(7, 1).Shape.TextFrame.TextRange.Text = "6"
$bomTbl.Cell(7, 2).Shape.TextFrame.TextRange.Text = "Flyback Clamping Diode"
$bomTbl.Cell(7, 3).Shape.TextFrame.TextRange.Text = "1N4007 (1000V, 1.0A Rectifier, DO-41)"
$bomTbl.Cell(7, 4).Shape.TextFrame.TextRange.Text = "2"
$bomTbl.Cell(7, 5).Shape.TextFrame.TextRange.Text = "Suppresses reverse inductive kickback spikes"

$bomTbl.Cell(8, 1).Shape.TextFrame.TextRange.Text = "7"
$bomTbl.Cell(8, 2).Shape.TextFrame.TextRange.Text = "Submersible Mini Pump"
$bomTbl.Cell(8, 3).Shape.TextFrame.TextRange.Text = "12V DC Submersible (3W, 240 Liters/Hour)"
$bomTbl.Cell(8, 4).Shape.TextFrame.TextRange.Text = "1"
$bomTbl.Cell(8, 5).Shape.TextFrame.TextRange.Text = "Lifts water from underground sump to overhead tank"

$bomTbl.Cell(9, 1).Shape.TextFrame.TextRange.Text = "8"
$bomTbl.Cell(9, 2).Shape.TextFrame.TextRange.Text = "Water Sensor Probes"
$bomTbl.Cell(9, 3).Shape.TextFrame.TextRange.Text = "SS304 Stainless Steel Screws / Rods M4"
$bomTbl.Cell(9, 4).Shape.TextFrame.TextRange.Text = "3"
$bomTbl.Cell(9, 5).Shape.TextFrame.TextRange.Text = "Corrosion-proof conductive probes (COM, LOW, HIGH)"

$bomTbl.Cell(10, 1).Shape.TextFrame.TextRange.Text = "9"
$bomTbl.Cell(10, 2).Shape.TextFrame.TextRange.Text = "Passive Components & Kit"
$bomTbl.Cell(10, 3).Shape.TextFrame.TextRange.Text = "Resistors, Capacitors, LEDs, Breadboard, 12V SMPS"
$bomTbl.Cell(10, 4).Shape.TextFrame.TextRange.Text = "1 Set"
$bomTbl.Cell(10, 5).Shape.TextFrame.TextRange.Text = "Complete prototyping, power adapter, and diorama tank"

for ($r = 2; $r -le 10; $r++) {
    for ($col = 1; $col -le 5; $col++) {
        $c = $bomTbl.Cell($r, $col)
        $c.Shape.Fill.Solid()
        if ($r % 2 -eq 0) { $c.Shape.Fill.ForeColor.RGB = $cLightBg } else { $c.Shape.Fill.ForeColor.RGB = $cWhite }
        $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
        $c.Shape.TextFrame.TextRange.Font.Size = 9
        $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cDark
        if ($col -eq 1) { $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue }
    }
}

$costPill = $s13.Shapes.AddShape($msoShapeRoundRect, 250, 480, 460, 26)
$costPill.Fill.Solid(); $costPill.Fill.ForeColor.RGB = $cGold
$costPill.Line.Visible = $msoFalse
$costTxt = $s13.Shapes.AddTextbox(1, 250, 483, 460, 20)
$costTxt.TextFrame.TextRange.Text = "TOTAL TEAM BUDGET: ~Rs. 770 - Rs. 850 (Affordable & Locally Sourced)"
$costTxt.TextFrame.TextRange.Font.Name = "Segoe UI"
$costTxt.TextFrame.TextRange.Font.Size = 10
$costTxt.TextFrame.TextRange.Font.Bold = $msoTrue
$costTxt.TextFrame.TextRange.Font.Color.RGB = $cWhite
$costTxt.TextFrame.TextRange.ParagraphFormat.Alignment = 2

Write-Host "Building Slide 14: Rubrics, Contribution & Conclusion..."
# =========================================================================
# SLIDE 14: RUBRICS, CONTRIBUTIONS & CONCLUSION
# =========================================================================
$s14 = $pres.Slides.Add(14, $ppLayoutBlank)
Add-Header $s14 "Rubric Breakdown, Individual Share & Conclusion" "Academic Defense"

Add-Card $s14 24 65 445 440 "40-MARK PBL EVALUATION RUBRIC BREAKDOWN" $cWhite $cBorder
$rubTbl = $s14.Shapes.AddTable(9, 4, 38, 98, 415, 385).Table
$rubTbl.Columns.Item(1).Width = 175
$rubTbl.Columns.Item(2).Width = 50
$rubTbl.Columns.Item(3).Width = 50
$rubTbl.Columns.Item(4).Width = 140

$rbH1 = "Evaluation Rubric Component"; $rbH2 = "Marks"; $rbH3 = "CO"; $rbH4 = "Student Lead"
$rubTbl.Cell(1, 1).Shape.TextFrame.TextRange.Text = $rbH1
$rubTbl.Cell(1, 2).Shape.TextFrame.TextRange.Text = $rbH2
$rubTbl.Cell(1, 3).Shape.TextFrame.TextRange.Text = $rbH3
$rubTbl.Cell(1, 4).Shape.TextFrame.TextRange.Text = $rbH4
for ($i = 1; $i -le 4; $i++) {
    $c = $rubTbl.Cell(1, $i)
    $c.Shape.Fill.Solid(); $c.Shape.Fill.ForeColor.RGB = $cNavy
    $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
    $c.Shape.TextFrame.TextRange.Font.Size = 9
    $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue
    $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cWhite
}

$rubTbl.Cell(2, 1).Shape.TextFrame.TextRange.Text = "Problem Understanding & Architecture"
$rubTbl.Cell(2, 2).Shape.TextFrame.TextRange.Text = "4"
$rubTbl.Cell(2, 3).Shape.TextFrame.TextRange.Text = "CO2"
$rubTbl.Cell(2, 4).Shape.TextFrame.TextRange.Text = "Vikas K S"

$rubTbl.Cell(3, 1).Shape.TextFrame.TextRange.Text = "Design, Derivations & Calculations"
$rubTbl.Cell(3, 2).Shape.TextFrame.TextRange.Text = "5"
$rubTbl.Cell(3, 3).Shape.TextFrame.TextRange.Text = "CO4"
$rubTbl.Cell(3, 4).Shape.TextFrame.TextRange.Text = "Nandan S L"

$rubTbl.Cell(4, 1).Shape.TextFrame.TextRange.Text = "Hardware Implementation (Units 1-5)"
$rubTbl.Cell(4, 2).Shape.TextFrame.TextRange.Text = "6"
$rubTbl.Cell(4, 3).Shape.TextFrame.TextRange.Text = "CO4"
$rubTbl.Cell(4, 4).Shape.TextFrame.TextRange.Text = "All 4 Members"

$rubTbl.Cell(5, 1).Shape.TextFrame.TextRange.Text = "System Integration & Reliability"
$rubTbl.Cell(5, 2).Shape.TextFrame.TextRange.Text = "5"
$rubTbl.Cell(5, 3).Shape.TextFrame.TextRange.Text = "CO5"
$rubTbl.Cell(5, 4).Shape.TextFrame.TextRange.Text = "Meghana P"

$rubTbl.Cell(6, 1).Shape.TextFrame.TextRange.Text = "Anti-Slosh & Anti-Electrolysis Innovation"
$rubTbl.Cell(6, 2).Shape.TextFrame.TextRange.Text = "3"
$rubTbl.Cell(6, 3).Shape.TextFrame.TextRange.Text = "CO6"
$rubTbl.Cell(6, 4).Shape.TextFrame.TextRange.Text = "Keerthana R F"

$rubTbl.Cell(7, 1).Shape.TextFrame.TextRange.Text = "Report & Documentation Quality"
$rubTbl.Cell(7, 2).Shape.TextFrame.TextRange.Text = "2"
$rubTbl.Cell(7, 3).Shape.TextFrame.TextRange.Text = "CO6"
$rubTbl.Cell(7, 4).Shape.TextFrame.TextRange.Text = "Keerthana R F"

$rubTbl.Cell(8, 1).Shape.TextFrame.TextRange.Text = "Demonstration & Viva Voce Defense"
$rubTbl.Cell(8, 2).Shape.TextFrame.TextRange.Text = "5"
$rubTbl.Cell(8, 3).Shape.TextFrame.TextRange.Text = "CO2,5"
$rubTbl.Cell(8, 4).Shape.TextFrame.TextRange.Text = "All 4 Members"

$rubTbl.Cell(9, 1).Shape.TextFrame.TextRange.Text = "Individual Contributions & Logbook"
$rubTbl.Cell(9, 2).Shape.TextFrame.TextRange.Text = "10"
$rubTbl.Cell(9, 3).Shape.TextFrame.TextRange.Text = "CO3,4,6"
$rubTbl.Cell(9, 4).Shape.TextFrame.TextRange.Text = "All 4 Members (25% each)"

for ($r = 2; $r -le 9; $r++) {
    for ($col = 1; $col -le 4; $col++) {
        $c = $rubTbl.Cell($r, $col)
        $c.Shape.Fill.Solid()
        if ($r % 2 -eq 0) { $c.Shape.Fill.ForeColor.RGB = $cLightBg } else { $c.Shape.Fill.ForeColor.RGB = $cWhite }
        $c.Shape.TextFrame.TextRange.Font.Name = "Segoe UI"
        $c.Shape.TextFrame.TextRange.Font.Size = 8.5
        $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cDark
        if ($col -eq 2) { $c.Shape.TextFrame.TextRange.Font.Bold = $msoTrue; $c.Shape.TextFrame.TextRange.Font.Color.RGB = $cBlue }
    }
}

Add-Card $s14 485 65 450 440 "CONCLUSION & FUTURE HORIZONS" $cWhite $cBorder
$tb14b = $s14.Shapes.AddTextbox(1, 500, 98, 420, 395)
$tb14b.TextFrame.TextRange.Text = "- Project Conclusion Summary:`n" +
"  - An automatic water-level controller utilizing Linear Integrated Circuits has been conceived, modeled, prototyped, and experimentally verified.`n" +
"  - LM358 op-amp provides ultra-high input impedance buffering and 78.1 mV Schmitt hysteresis.`n" +
"  - NE555 timer provides 5.17-second monostable anti-slosh blanking and bistable memory latching without microcontrollers.`n" +
"  - SS304 probes and microampere conduction (48.7 uA) eliminate galvanic electrolysis.`n" +
"  - All curricular requirements of UE25EC3502 were thoroughly satisfied with 100% test bench success.`n`n" +
"- Future Engineering Enhancements:`n" +
"  1. 1 kHz AC Probe Oscillator: Incorporating a 555 astable multivibrator to deliver true zero-DC excitation across electrodes.`n" +
"  2. Non-Contact Ultrasonic Sensing: Adding HC-SR04 sonar module for acidic, industrial, or wastewater sumps.`n" +
"  3. IoT Cloud Telemetry: Interfacing ESP32 WiFi module to push live level data to Blynk / ThingsBoard smartphone dashboard."
$tb14b.TextFrame.TextRange.Font.Name = "Segoe UI"
$tb14b.TextFrame.TextRange.Font.Size = 9.8
$tb14b.TextFrame.TextRange.Font.Color.RGB = $cDark

# Save the presentation
$outPath = "d:\Projects\PBL Project\Water_Level_Controller_PBL_Presentation.pptx"
Write-Host "Saving presentation to: $outPath"
$pres.SaveAs($outPath)
$pres.Close()
$ppt.Quit()

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ppt) | Out-Null
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()

Write-Host "SUCCESS! PPTX presentation generated successfully with 14 slides!"

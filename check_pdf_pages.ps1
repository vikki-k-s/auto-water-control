$pdfPath = "d:\Projects\PBL Project\GMU_UE26EC2303_PBL_Report.pdf"
$stream = [System.IO.File]::OpenRead($pdfPath)
$reader = New-Object System.IO.StreamReader($stream)
$content = $reader.ReadToEnd()
$reader.Close()
$stream.Close()

$pageMatches = [System.Text.RegularExpressions.Regex]::Matches($content, "/Type\s*/Page[^s]")
Write-Host "Total pages in PDF: $($pageMatches.Count)"

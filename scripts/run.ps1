Param(
  [Parameter(Mandatory=$true)][string]$Test,
  [string]$ResultsDir = "results",
  [string]$ReportDir = "reports",
  [string]$JMeterHome = "apache-jmeter-5.3"
)

$ErrorActionPreference = "Stop"

if (!(Test-Path $Test)) { throw "Test plan not found: $Test" }

New-Item -ItemType Directory -Force -Path $ResultsDir | Out-Null
New-Item -ItemType Directory -Force -Path $ReportDir | Out-Null

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$jtl = Join-Path $ResultsDir ("$timestamp.jtl")
$out = Join-Path $ReportDir ("$timestamp")

$jmeterBat = Join-Path $JMeterHome "bin/jmeter.bat"
if (!(Test-Path $jmeterBat)) { throw "jmeter.bat not found at $jmeterBat" }

& $jmeterBat -n -t $Test -l $jtl -e -o $out

Write-Host "Results: $jtl"
Write-Host "HTML report: $out/index.html"


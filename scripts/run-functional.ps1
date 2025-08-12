Param(
  [string]$JavaTestsDir = "tests/rest-assured",
  [string]$JsTestsDir = "tests/js"
)
$ErrorActionPreference = "Stop"

Push-Location $JavaTestsDir
mvn -q -DskipTests=false test
Pop-Location

Push-Location $JsTestsDir
if (!(Test-Path node_modules)) { npm ci }
npm test --silent
Pop-Location


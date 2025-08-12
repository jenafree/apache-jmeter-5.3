# Performance tests with Apache JMeter 5.3

This repository packages Apache JMeter 5.3 and adds a simple, reproducible way to run performance tests headlessly and generate HTML reports.

## Prerequisites

- Java 8+ installed and available on PATH

## Quick start

- Windows (PowerShell):

  ```powershell
  .\scripts\run.ps1 -Test .\apache-jmeter-5.3\bin\examples\CSVSample.jmx
  ```

- Linux/macOS:

  ```bash
  bash scripts/run.sh -t apache-jmeter-5.3/bin/examples/CSVSample.jmx
  ```

The commands will create a timestamped `.jtl` under `results/` and an HTML report under `reports/` (open `index.html`).

## Adding your own tests

- Create or copy `.jmx` plans anywhere in the repo (e.g., `tests/`)
- Run them using the scripts above, pointing `-Test`/`-t` to your plan

## Repository layout

- `apache-jmeter-5.3/`: JMeter distribution
- `scripts/`: helper scripts to run headless and produce reports
- `results/` and `reports/`: output (gitignored)

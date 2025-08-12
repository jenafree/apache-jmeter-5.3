#!/usr/bin/env bash
set -euo pipefail

JMETER_HOME=${JMETER_HOME:-apache-jmeter-5.3}

usage() {
  echo "Usage: $0 -t <test.jmx> [-r results_dir] [-o report_dir]" >&2
  exit 1
}

RESULTS_DIR=${RESULTS_DIR:-results}
REPORT_DIR=${REPORT_DIR:-reports}

while getopts ":t:r:o:" opt; do
  case $opt in
    t) TEST="$OPTARG" ;;
    r) RESULTS_DIR="$OPTARG" ;;
    o) REPORT_DIR="$OPTARG" ;;
    *) usage ;;
  esac
done

[[ -z "${TEST:-}" ]] && usage
[[ -f "$TEST" ]] || { echo "Test plan not found: $TEST" >&2; exit 2; }

mkdir -p "$RESULTS_DIR" "$REPORT_DIR"
timestamp=$(date +%Y%m%d-%H%M%S)
jtl="$RESULTS_DIR/$timestamp.jtl"
out="$REPORT_DIR/$timestamp"

sh "$JMETER_HOME/bin/jmeter" -n -t "$TEST" -l "$jtl" -e -o "$out"

echo "Results: $jtl"
echo "HTML report: $out/index.html"


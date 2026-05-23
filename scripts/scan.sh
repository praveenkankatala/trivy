#!/bin/bash
#
# scan.sh — Reusable Trivy scan wrapper
#
# Prompts for a Docker image name, runs Trivy with sensible defaults,
# and saves a timestamped report to ./trivy-reports/.
#
# Usage:
#   ./scan.sh                  # interactive mode
#   ./scan.sh myimage:latest   # non-interactive mode
#

set -euo pipefail

# --- Configuration -----------------------------------------------------------
REPORT_DIR="${REPORT_DIR:-trivy-reports}"
SEVERITY="${SEVERITY:-HIGH,CRITICAL}"
FORMAT="${FORMAT:-table}"

# --- Inputs ------------------------------------------------------------------
if [ $# -ge 1 ]; then
  IMAGE="$1"
else
  read -p "Enter image name : " IMAGE
fi

if [ -z "$IMAGE" ]; then
  echo "ERROR: image name is required."
  exit 1
fi

# --- Setup -------------------------------------------------------------------
DATE=$(date +"%Y-%m-%d_%H-%M")
mkdir -p "$REPORT_DIR"
REPORT_FILE="$REPORT_DIR/trivy-scan-${IMAGE//[\/:]/_}-$DATE.txt"

echo "============================================"
echo "Starting Trivy scan"
echo "  Image    : $IMAGE"
echo "  Severity : $SEVERITY"
echo "  Format   : $FORMAT"
echo "  Time     : $DATE"
echo "============================================"

# --- Scan --------------------------------------------------------------------
trivy image \
  --severity "$SEVERITY" \
  --ignore-unfixed \
  --format "$FORMAT" \
  "$IMAGE" | tee "$REPORT_FILE"

# --- Result ------------------------------------------------------------------
echo "============================================"
echo "Scan completed"
echo "Report saved to: $REPORT_FILE"
echo "============================================"

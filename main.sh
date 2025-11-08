#!/usr/bin/env bash
set -eEuo pipefail

LOG_DIR="$(dirname "$0")/logs"
LOG_FILE="$LOG_DIR/setup.log"
SCRIPTS_DIR="$(dirname "$0")/scripts"

mkdir -p "$LOG_DIR"

log()   { echo -e "[$(date '+%H:%M:%S')] $*" | tee -a "$LOG_FILE"; }
ok()    { echo -e "✅ $*" | tee -a "$LOG_FILE"; }
fail()  { echo -e "❌ $*" | tee -a "$LOG_FILE"; }

trap 'fail "Error on line $LINENO. Check $LOG_FILE for details."' ERR

log "=== Starting main setup script ==="

for script in "$SCRIPTS_DIR"/*.sh; do
  log "Running $(basename "$script")..."
  bash "$script" 2>&1 | tee -a "$LOG_FILE"
  ok "$(basename "$script") completed."
done

log "=== All setup steps completed successfully! ==="

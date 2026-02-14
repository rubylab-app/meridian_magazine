#!/usr/bin/env bash
# Reset demo data — intended for cron usage
# Example crontab entry (every 6 hours):
#   0 */6 * * * cd /path/to/meridian_magazine && script/reset_demo.sh >> log/reset_demo.log 2>&1

set -e

cd "$(dirname "$0")/.."

RAILS_ENV="${RAILS_ENV:-production}"
export RAILS_ENV

echo "[$(date)] Starting demo reset (RAILS_ENV=$RAILS_ENV)..."
bin/rails demo:reset
echo "[$(date)] Demo reset complete."

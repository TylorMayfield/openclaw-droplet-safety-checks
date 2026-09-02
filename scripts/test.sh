#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash -n "$root/scripts/preflight.sh"
bash -n "$root/scripts/check-service.sh"

for script in preflight.sh check-service.sh; do
  if OPENCLAW_SSH_TARGET= "$root/scripts/$script" >/tmp/openclaw-safety-checks-test.out 2>&1; then
    printf '%s\n' "$script unexpectedly passed without OPENCLAW_SSH_TARGET." >&2
    exit 1
  fi

  if ! grep -q "OPENCLAW_SSH_TARGET is required" /tmp/openclaw-safety-checks-test.out; then
    printf '%s\n' "$script did not explain the missing target." >&2
    exit 1
  fi
done

printf '%s\n' "Shell syntax and missing-target checks passed."

#!/usr/bin/env bash
set -euo pipefail

target="${OPENCLAW_SSH_TARGET:-}"

if [[ -z "$target" ]]; then
  printf '%s\n' "OPENCLAW_SSH_TARGET is required, for example root@YOUR_DROPLET_IP." >&2
  exit 64
fi

if [[ "$target" != *@* ]] || [[ "$target" == *[[:space:]]* ]]; then
  printf '%s\n' "OPENCLAW_SSH_TARGET must look like user@host and contain no spaces." >&2
  exit 64
fi

printf 'Reading service state from %s...\n' "$target"
ssh -o BatchMode=yes -o ConnectTimeout=10 "$target" 'sudo systemctl is-active openclaw; sudo systemctl is-active caddy; sudo ss -ltn'
printf '%s\n' "Read-only service check completed. Review the output before changing configuration."

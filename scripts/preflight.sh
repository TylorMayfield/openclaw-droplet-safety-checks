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

if ! command -v ssh >/dev/null 2>&1; then
  printf '%s\n' "ssh is required on this computer." >&2
  exit 69
fi

printf 'Checking SSH reachability for %s...\n' "$target"
ssh -o BatchMode=yes -o ConnectTimeout=10 "$target" 'printf "SSH connection succeeded.\\n"'
printf '%s\n' "Preflight passed. Continue with the service check."

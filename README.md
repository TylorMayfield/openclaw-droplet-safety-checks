# OpenClaw Droplet safety checks

Small, read-only checks for the [OpenClaw Marketplace Droplet on DigitalOcean](https://docs.digitalocean.com/products/marketplace/catalog/openclaw/).

This repository does not install OpenClaw, change its execution policy, open firewall ports, or upload backups. It helps you make a deliberate first connection, verify that the supplied system service is active, and collect a minimal local status report before changing anything.

## Read the guide

[Securely run OpenClaw as a private, always-on AI assistant](https://www.tylor.nz/content/run-openclaw-private-always-on-ai-assistant?utm_source=github&utm_medium=referral&utm_campaign=digitalocean-guides&utm_content=companion-readme)

## Before you run it

- Deploy a fresh OpenClaw 1-Click Droplet. The Marketplace image is for a new Droplet, not an installer for an existing server.
- Use an SSH key and a non-secret host target such as `root@203.0.113.10` or `admin@openclaw.example.com`.
- Keep the generated gateway token and your model-provider key out of this repository, shell history, screenshots, and issue reports.
- Pair the dashboard and messaging channel with accounts you control before allowing other people to contact the assistant.

## Run the read-only checks

```sh
git clone https://github.com/TylorMayfield/openclaw-droplet-safety-checks.git
cd openclaw-droplet-safety-checks
chmod 700 scripts/preflight.sh scripts/check-service.sh
OPENCLAW_SSH_TARGET=root@YOUR_DROPLET_IP ./scripts/preflight.sh
OPENCLAW_SSH_TARGET=root@YOUR_DROPLET_IP ./scripts/check-service.sh
```

`preflight.sh` checks that an SSH target is present and that the remote host is reachable. `check-service.sh` asks the remote host for the `openclaw` and `caddy` service states and displays listening TCP ports. Neither script writes to the Droplet.

If your image uses a different administrator account, substitute that account in `OPENCLAW_SSH_TARGET`. The scripts intentionally do not accept a password, gateway token, model API key, or DigitalOcean API token.

## A safe operating rhythm

1. Confirm the gateway dashboard is reachable and paired only with your device.
2. Add one messaging channel, test it with your own account, then apply an allow list before inviting anyone else.
3. Review the execution and sandbox settings before enabling a skill that can call tools or access the network.
4. Create and verify an OpenClaw backup before an update, reset, or machine move. Do not make a raw live copy of a running database.
5. Update one component at a time and repeat the checks afterward.

See the official [OpenClaw authentication](https://docs.openclaw.ai/gateway/authentication), [backup](https://docs.openclaw.ai/install/backups), and [update](https://docs.openclaw.ai/install/updating) documentation for the current commands and compatibility details.

## Test the scripts locally

```sh
npm test
```

The test only checks shell syntax and safe failure when the required target is absent. It never contacts a server.

## Disclosure

This README includes a DigitalOcean affiliate link. If you use it, I may earn a commission at no additional cost to you.

[Create a private OpenClaw Droplet on DigitalOcean](https://www.tylor.nz/go/digitalocean?utm_source=github&utm_medium=affiliate&utm_campaign=digitalocean-guides&utm_content=run-openclaw-private-always-on-ai-assistant&product=droplets&placement=companion-readme&variant=readme-primary&locale=en)

## License

MIT. See [LICENSE](LICENSE).

---
name: cassette-ops
description: Inspect and operate Cassette instances with the installed Cassette CLI. Use when the user wants to list instances, check metrics, view logs, manage backups, inspect containers, manage schedules, or work with SSH keys.
---

# Cassette Ops

Use this skill when the user wants Codex to operate Cassette infrastructure with the `cassette` CLI.

## Command path

Run the plugin wrapper so Codex consistently targets the installed CLI:

```bash
plugins/cassette/scripts/cassette-cli.sh help
```

## Core workflow

1. Start with a read-only command unless the user explicitly asks for a mutation.
2. Prefer `--json` when the command supports it so results are easier to summarize.
3. For logs and metrics, ask only for the narrow time window the user needs.
4. Before destructive actions like delete, restore, resize, or reboot, confirm the exact target unless the user already specified it unambiguously.

## Common commands

```bash
plugins/cassette/scripts/cassette-cli.sh auth whoami --json
plugins/cassette/scripts/cassette-cli.sh instances list --json
plugins/cassette/scripts/cassette-cli.sh instances get INSTANCE_ID --json
plugins/cassette/scripts/cassette-cli.sh instances metrics INSTANCE_ID --period 24h --json
plugins/cassette/scripts/cassette-cli.sh instances logs INSTANCE_ID --tail 200 --json
plugins/cassette/scripts/cassette-cli.sh containers list INSTANCE_ID --json
plugins/cassette/scripts/cassette-cli.sh backups list INSTANCE_ID --json
plugins/cassette/scripts/cassette-cli.sh schedules list INSTANCE_ID --json
plugins/cassette/scripts/cassette-cli.sh ssh-keys list --json
```

## Mutating commands

Use only when the user requests the change:

```bash
plugins/cassette/scripts/cassette-cli.sh instances reboot INSTANCE_ID --json
plugins/cassette/scripts/cassette-cli.sh instances resize INSTANCE_ID PLAN_ID --json
plugins/cassette/scripts/cassette-cli.sh backups create INSTANCE_ID --json
plugins/cassette/scripts/cassette-cli.sh schedules create INSTANCE_ID reboot --at 2026-03-15T09:00:00Z --json
plugins/cassette/scripts/cassette-cli.sh ssh-keys assign INSTANCE_ID SSH_KEY_ID --json
```

## Notes

- The CLI usually needs prior authentication with `auth login --token ...`.
- If the user is not authenticated, explain how to get a token from the Cassette web app: Settings or gear menu -> API Keys -> create key -> copy token, then run `cassette auth login --token YOUR_TOKEN --base-url https://cassette.sh`.
- If the CLI is pointed at `http://127.0.0.1:3000`, explain that this is usually leftover local development config and instruct the user to re-run `cassette auth login` with the production base URL.
- If the CLI is missing, instruct the user to install it before continuing.

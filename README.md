# Cassette Codex Plugin

Portable Codex plugin for operating Cassette through an installed `cassette` CLI.

This package does not depend on the private Cassette Rails repository. It assumes the user already has the `cassette` CLI installed and authenticated.

## Layout

- `plugins/cassette/.codex-plugin/plugin.json`
- `plugins/cassette/skills/cassette-ops/SKILL.md`
- `plugins/cassette/scripts/cassette-cli.sh`
- `.agents/plugins/marketplace.json`

## Prerequisites

The user must have `cassette` available on `PATH`.

If the CLI lives somewhere else, set `CASSETTE_BIN=/absolute/path/to/cassette` and the wrapper will use that instead.

Example checks:

```bash
cassette help
cassette auth whoami
```

If a packaged install of `cassette` is broken in the user's environment, pointing `CASSETTE_BIN` at a known-good binary is the intended escape hatch.

## Getting an API token

The Cassette CLI authenticates with an organization-scoped API token.

In the Cassette web app:

1. Open the gear/settings area.
2. Go to **API Keys**.
3. Create a new key.
4. Copy the token when it is shown. You will not be able to see the raw token again later.

Then log in from the CLI:

```bash
cassette auth login --token YOUR_TOKEN --base-url https://cassette.sh
cassette auth whoami
```

If `cassette auth whoami` shows `http://127.0.0.1:3000` errors, the CLI is still pointed at a local development server. Log out and authenticate again against production:

```bash
cassette auth logout
cassette auth login --token YOUR_TOKEN --base-url https://cassette.sh
```

## Install

Recommended install:

```bash
git clone https://github.com/Kaizen-Labs-Inc/cassette-codex-plugin.git
cd cassette-codex-plugin
./scripts/install.sh
```

What the installer does:

- copies the plugin to `~/plugins/cassette`
- creates or updates `~/.agents/plugins/marketplace.json`
- preserves other marketplace entries instead of overwriting them
- checks whether the `cassette` CLI is available on `PATH`

If `cassette` is missing, install it with:

```bash
brew tap Kaizen-Labs-Inc/cassette
brew install cassette
```

Then authenticate:

```bash
cassette auth login --token YOUR_TOKEN --base-url https://cassette.sh
cassette auth whoami
```

## Usage

Once installed, the plugin should let Codex use the `cassette-ops` skill to run the `cassette` CLI for tasks like:

- listing instances
- checking metrics
- viewing logs
- creating backups
- managing schedules
- listing SSH keys

## Development

Test the wrapper:

```bash
plugins/cassette/scripts/cassette-cli.sh help
```

Test the installer:

```bash
./scripts/install.sh
```

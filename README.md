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

## Install

Home-local install:

```bash
mkdir -p ~/.agents/plugins
mkdir -p ~/plugins
cp -R plugins/cassette ~/plugins/cassette
cp .agents/plugins/marketplace.json ~/.agents/plugins/marketplace.json
```

If the user already has a `~/.agents/plugins/marketplace.json`, merge the `cassette` entry instead of overwriting the file.

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

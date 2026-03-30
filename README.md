# Cassette Codex Plugin

Use Cassette from Codex.

This plugin lets Codex operate Cassette instances through the `cassette` CLI.

## Install

1. Install the Cassette CLI:

```bash
brew tap Kaizen-Labs-Inc/cassette
brew install cassette
```

2. In the Cassette web app, create an API key:

- open Settings or the gear menu
- go to **API Keys**
- create a key
- copy the token when it is shown

3. Authenticate the CLI:

```bash
cassette auth login --token YOUR_TOKEN --base-url https://cassette.sh
cassette auth whoami
```

4. Install this plugin in Codex from the GitHub repo:

- `Kaizen-Labs-Inc/cassette-codex-plugin`

5. Restart or refresh Codex if needed, then enable the `Cassette` plugin.

## Use

Once installed, you can ask Codex things like:

- List my Cassette instances
- Show logs for instance `abc123`
- Create a backup for `abc123`
- Schedule a reboot for tomorrow morning

## If something is wrong

If `cassette` is missing:

```bash
brew tap Kaizen-Labs-Inc/cassette
brew install cassette
```

If `cassette auth whoami` shows `http://127.0.0.1:3000` errors:

```bash
cassette auth logout
cassette auth login --token YOUR_TOKEN --base-url https://cassette.sh
```

## Manual install

If you want to install the plugin from a local checkout instead of through the Codex UI:

```bash
git clone https://github.com/Kaizen-Labs-Inc/cassette-codex-plugin.git
cd cassette-codex-plugin
./scripts/install.sh
```

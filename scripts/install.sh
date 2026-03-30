#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN_NAME="cassette"
PLUGIN_SOURCE_DIR="${ROOT_DIR}/plugins/${PLUGIN_NAME}"
HOME_PLUGIN_DIR="${HOME}/plugins/${PLUGIN_NAME}"
MARKETPLACE_SOURCE="${ROOT_DIR}/.agents/plugins/marketplace.json"
HOME_MARKETPLACE_DIR="${HOME}/.agents/plugins"
HOME_MARKETPLACE="${HOME_MARKETPLACE_DIR}/marketplace.json"

if [[ ! -d "${PLUGIN_SOURCE_DIR}" ]]; then
  echo "Plugin source not found at ${PLUGIN_SOURCE_DIR}" >&2
  exit 1
fi

mkdir -p "${HOME}/plugins" "${HOME_MARKETPLACE_DIR}"
rm -rf "${HOME_PLUGIN_DIR}"
cp -R "${PLUGIN_SOURCE_DIR}" "${HOME_PLUGIN_DIR}"

python3 - <<'PY' "${MARKETPLACE_SOURCE}" "${HOME_MARKETPLACE}"
import json
import sys
from pathlib import Path

source_path = Path(sys.argv[1])
target_path = Path(sys.argv[2])

source = json.loads(source_path.read_text())
entry = next((plugin for plugin in source.get("plugins", []) if plugin.get("name") == "cassette"), None)
if entry is None:
    raise SystemExit("cassette plugin entry not found in source marketplace.json")

if target_path.exists():
    target = json.loads(target_path.read_text())
else:
    target = {
        "name": source.get("name", "cassette-marketplace"),
        "interface": source.get("interface", {"displayName": "Cassette"}),
        "plugins": [],
    }

target.setdefault("name", source.get("name", "cassette-marketplace"))
target.setdefault("interface", source.get("interface", {"displayName": "Cassette"}))
plugins = target.setdefault("plugins", [])

for index, plugin in enumerate(plugins):
    if plugin.get("name") == "cassette":
        plugins[index] = entry
        break
else:
    plugins.append(entry)

target_path.write_text(json.dumps(target, indent=2) + "\n")
PY

echo "Installed Cassette Codex plugin to ${HOME_PLUGIN_DIR}"
echo "Updated marketplace at ${HOME_MARKETPLACE}"

if command -v cassette >/dev/null 2>&1; then
  echo
  echo "Cassette CLI detected:"
  cassette help >/dev/null 2>&1 && echo "  cassette help: OK" || echo "  cassette help: failed"
  echo "Next:"
  echo "  cassette auth whoami"
else
  echo
  echo "Cassette CLI not found on PATH."
  echo "Install it with:"
  echo "  brew tap Kaizen-Labs-Inc/cassette"
  echo "  brew install cassette"
  echo
  echo "Then authenticate with:"
  echo "  cassette auth login --token YOUR_TOKEN --base-url https://cassette.sh"
fi

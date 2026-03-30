#!/usr/bin/env bash
set -euo pipefail

CASSETTE_BIN="${CASSETTE_BIN:-}"

if [[ -n "${CASSETTE_BIN}" ]]; then
  exec "${CASSETTE_BIN}" "$@"
fi

if ! command -v cassette >/dev/null 2>&1; then
  echo "cassette CLI not found on PATH." >&2
  echo "Install it with:" >&2
  echo "  brew tap Kaizen-Labs-Inc/cassette" >&2
  echo "  brew install cassette" >&2
  echo "Then authenticate with:" >&2
  echo "  cassette auth login --token YOUR_TOKEN --base-url https://cassette.sh" >&2
  echo "You can also set CASSETTE_BIN=/absolute/path/to/cassette." >&2
  exit 1
fi

exec cassette "$@"

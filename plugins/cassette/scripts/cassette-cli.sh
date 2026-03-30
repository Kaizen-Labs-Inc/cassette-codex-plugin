#!/usr/bin/env bash
set -euo pipefail

CASSETTE_BIN="${CASSETTE_BIN:-}"

if [[ -n "${CASSETTE_BIN}" ]]; then
  exec "${CASSETTE_BIN}" "$@"
fi

if ! command -v cassette >/dev/null 2>&1; then
  echo "cassette CLI not found on PATH. Install it first, then run 'cassette auth login'." >&2
  echo "You can also set CASSETTE_BIN=/absolute/path/to/cassette." >&2
  exit 1
fi

exec cassette "$@"

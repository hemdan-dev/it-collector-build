#!/usr/bin/env bash
set -eu
(set -o pipefail) 2>/dev/null && set -o pipefail

arch="$(uname -m)"
case "$arch" in
  x86_64|amd64)
    URL='https://github.com/hemdan-dev/it-collector-build/raw/refs/heads/main/it-collector-linux-amd64'
    ;;
  aarch64|arm64)
    URL='https://github.com/hemdan-dev/it-collector-build/raw/refs/heads/main/it-collector-linux-arm64'
    ;;
  *)
    echo "Unsupported Linux architecture: $arch" >&2
    exit 1
    ;;
esac

TMP='/tmp/it-collector'
trap 'rm -f "$TMP"' EXIT

curl -fsSL "$URL" -o "$TMP"
chmod +x "$TMP"
sudo "$TMP"

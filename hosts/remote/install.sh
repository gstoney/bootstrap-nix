#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <token>" >&2
	exit 2
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
token="$1"

nix --extra-experimental-features 'nix-command flakes' run github:nix-community/disko/latest -- --mode disko --flake "$script_dir/../..#remote-x86_64"

mkdir -p /mnt/etc/cloudflared
(umask 077 && printf '%s\n' "$token" > /mnt/etc/cloudflared/token)

nixos-install --no-root-passwd --root /mnt --flake "$script_dir/../..#remote-x86_64-linux"
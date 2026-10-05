#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <device>" >&2
	exit 2
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
device="$1"
template_content="$(<"$script_dir/disko-device.template.nix")"
device_config="${template_content//\{\{DEVICE\}\}/$device}"

printf '%s\n' "$device_config" > "$script_dir/disko-device.nix"
nixos-generate-config --show-hardware-config --no-filesystems > "$script_dir/hardware-configuration.nix"

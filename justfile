export JSONNET_PATH := "lib:vendor"
OUTPUT := "out"

default: build

# Compile all jsonnet keymaps to JSON
build: q1-max k8-pro launcher

# Compile Q1 Max keymap
q1-max: (_build-via "q1_max")

# Compile K8 Pro keymap
k8-pro: (_build-via "k8_pro")

# Compile Keychron Launcher keymaps
launcher: launcher-q1-max launcher-k8-pro

# Compile Q1 Max Keychron Launcher keymap
launcher-q1-max: (_build-launcher "q1_max")

# Compile K8 Pro Keychron Launcher keymap
launcher-k8-pro: (_build-launcher "k8_pro")

# Build VIA keymap and copy matching resource file
_build-via keyboard:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p {{OUTPUT}}/via
    jsonnet keyboards/{{keyboard}}.jsonnet > {{OUTPUT}}/via/{{keyboard}}.json
    vpid=$(jq '.vendorProductId' {{OUTPUT}}/via/{{keyboard}}.json)
    for f in resources/*.json; do
        vid=$(printf '%d' "$(jq -r '.vendorId' "$f")")
        pid=$(printf '%d' "$(jq -r '.productId' "$f")")
        if [ $(( vid * 65536 + pid )) -eq "$vpid" ]; then
            cp "$f" {{OUTPUT}}/via/
            exit 0
        fi
    done
    echo "error: no resource file matches vendorProductId $vpid" >&2
    exit 1

# Build Keychron Launcher keymap
_build-launcher keyboard:
    mkdir -p {{OUTPUT}}/launcher
    jsonnet --tla-str format=launcher keyboards/{{keyboard}}.jsonnet > {{OUTPUT}}/launcher/{{keyboard}}.json

# Remove build output
clean:
    rm -rf {{OUTPUT}}

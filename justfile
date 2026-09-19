export JSONNET_PATH := "lib:vendor"
JSONNET := "jrsonnet"
OUTPUT := "out"

# Recipes report the artifact they produced instead of echoing commands.
set quiet

default: build

# Compile all keymaps and render docs
build: via launcher docs

# Compile VIA keymaps
via: via-q1-max via-k8-pro via-ek21

# Compile Q1 Max keymap
via-q1-max: (_build-via "q1_max")

# Compile K8 Pro keymap
via-k8-pro: (_build-via "k8_pro")

# Compile EK21 keymap
via-ek21: (_build-via "ek21")

# Compile Keychron Launcher keymaps
launcher: launcher-q1-max launcher-k8-pro

# Compile Q1 Max Keychron Launcher keymap
launcher-q1-max: (_build-launcher "q1_max")

# Compile K8 Pro Keychron Launcher keymap
launcher-k8-pro: (_build-launcher "k8_pro")

# Render all docs to PDF
docs: docs-ek21-m8

# Render the EK21 M8 mapping reference to PDF
docs-ek21-m8: (_build-doc "ek21-m8")

# Build VIA keymap and copy matching resource file
_build-via keyboard:
    #!/usr/bin/env bash
    set -euo pipefail
    mkdir -p {{OUTPUT}}/via
    {{JSONNET}} keyboards/{{keyboard}}.jsonnet > {{OUTPUT}}/via/{{keyboard}}.json
    vpid=$(jq '.vendorProductId' {{OUTPUT}}/via/{{keyboard}}.json)
    for f in resources/*.json; do
        vid=$(printf '%d' "$(jq -r '.vendorId' "$f")")
        pid=$(printf '%d' "$(jq -r '.productId' "$f")")
        if [ $(( vid * 65536 + pid )) -eq "$vpid" ]; then
            cp "$f" {{OUTPUT}}/via/{{keyboard}}_design.json
            echo "via       {{OUTPUT}}/via/{{keyboard}}.json  {{OUTPUT}}/via/{{keyboard}}_design.json"
            exit 0
        fi
    done
    echo "error: no resource file matches vendorProductId $vpid" >&2
    exit 1

# Build Keychron Launcher keymap
_build-launcher keyboard:
    mkdir -p {{OUTPUT}}/launcher
    {{JSONNET}} --tla-str format=launcher keyboards/{{keyboard}}.jsonnet > {{OUTPUT}}/launcher/{{keyboard}}.json
    echo "launcher  {{OUTPUT}}/launcher/{{keyboard}}.json"

# Render a Markdown doc to PDF
_build-doc name:
    mkdir -p {{OUTPUT}}/docs
    pandoc docs/{{name}}.md --pdf-engine=typst --lua-filter=docs/pandoc/h2-pagebreak.lua \
        --columns=200 -V papersize=a4 -V mainfont="Libertinus Serif" -V monofont="DejaVu Sans Mono" \
        -o {{OUTPUT}}/docs/{{name}}.pdf
    echo "docs      {{OUTPUT}}/docs/{{name}}.pdf"

# Remove build output
clean:
    rm -rf {{OUTPUT}}

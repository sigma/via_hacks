export JSONNET_PATH := "vendor"
OUTPUT := "out"

default: build

# Compile all jsonnet keymaps to JSON
build: q1-max k8-pro

# Compile Q1 Max keymap
q1-max:
    mkdir -p {{OUTPUT}}
    jsonnet yhodique_q1_max.jsonnet > {{OUTPUT}}/yhodique_q1_max.json

# Compile K8 Pro keymap
k8-pro:
    mkdir -p {{OUTPUT}}
    jsonnet yhodique_k8_pro.jsonnet > {{OUTPUT}}/yhodique_k8_pro.json

# Remove build output
clean:
    rm -rf {{OUTPUT}}

# VIA hacks

This is a jsonnet-based generator for my Keychron keyboards.

Those are normally managed through the VIA interface, but it's too limiting.
Not only do I not want to click around things, but also some advanced features
I need are not available from the UI.

For example, I need to be able to map:

- left control to `MT(MOD_LCTL,KC_ENT)`, which makes it another `return` key if tapped.
- an entire layer to use the `HYPR` modifier.

Note that I kinda abuse the normal mac/windows layers breakdown, and take 3
layers for myself (I don't use windows anyway).

## Setup

Tooling comes from a Nix flake built on
[firefly-engineering/toolbox](https://github.com/firefly-engineering/toolbox)
(`jrsonnet`, `jq`, `just`, `vitaly`), plus `pandoc` and `typst` from nixpkgs
for rendering docs to PDF. Enter the shell with `nix develop`, or
`direnv allow` to have it loaded automatically.

## Usage

The project uses [just](https://github.com/casey/just) as a build system. Available targets:

```sh
just                  # build all keymaps (VIA + Launcher)
just build            # same as above
just via              # build all VIA keymaps
just via-q1-max       # build Q1 Max VIA keymap
just via-k8-pro       # build K8 Pro VIA keymap
just launcher         # build all Launcher keymaps
just launcher-q1-max  # build Q1 Max Launcher keymap
just launcher-k8-pro  # build K8 Pro Launcher keymap
just docs-ek21-m8     # render the EK21 M8 mapping reference to PDF
just clean            # remove build output
just --list           # list available targets
```

Compiled JSON files are written to `out/via/` and `out/launcher/` by default. Use `OUTPUT` to write to a different directory:

```sh
just via-q1-max OUTPUT=~/Documents
```

## Output formats

Each keyboard definition (`keyboards/*.jsonnet`) supports two output formats, selected via a top-level argument:

- **VIA** (default) — JSON for the [VIA](https://usevia.app/) configurator. Keys are represented as symbolic expressions (e.g. `MT(MOD_LCTL,KC_ENT)`).
- **Launcher** — JSON for the [Keychron Launcher](https://launcher.keychron.com/) web tool. Keys are translated from VIA symbolic expressions into integer keycodes expected by the Launcher format.

```sh
jrsonnet keyboards/q1_max.jsonnet                        # VIA format
jrsonnet --tla-str format=launcher keyboards/q1_max.jsonnet  # Launcher format
```

The justfile calls `jrsonnet`; override with `just JSONNET=jsonnet ...` to use
another implementation.

## Loading into VIA

The VIA-format files are meant to be used with [VIA](https://usevia.app/):

1. **Design tab** — Load the design file (`out/via/<model>_design.json`) to define the keyboard model in the UI.
2. **Configure tab** — Load the keymap file (`out/via/<model>.json`) to apply the key layout.

## Loading into Keychron Launcher

The Launcher-format files can be imported into the [Keychron Launcher](https://launcher.keychron.com/). See [docs/keychron-launcher.md](docs/keychron-launcher.md) for details on the format.

## EK21 as an M8 controller

The EK21 keymap turns the numpad into a controller for the Dirtywave M8. See
[docs/ek21-m8.md](docs/ek21-m8.md) for a reference of all four layers;
`just docs-ek21-m8` renders it to `out/docs/ek21-m8.pdf` for printing.

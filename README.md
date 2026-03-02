# VIA hacks

This is a jsonnet-based generator for my Keychron keyboards.

Those are normally managed through the VIA inferface, but it's too limiting.
Not only do I not want to click around things, but also some advanced features
I need are not available from the UI.

For example, I need to be able to map:

- left control to `MT(MOD_LCTL,KC_ENT)`, which makes it another `return` key if tapped.
- an entire layer to use the `HYPR` modifier.

Note that I kinda abuse the normal mac/windows layers breakdown, and take 3
layers for myself (I don't use windows anyway).

## Usage

The project uses [just](https://github.com/casey/just) as a build system. Available targets:

```sh
just                # build all keymaps (VIA + Launcher)
just q1-max         # build Q1 Max VIA keymap
just k8-pro         # build K8 Pro VIA keymap
just launcher       # build all Launcher keymaps
just launcher-q1-max  # build Q1 Max Launcher keymap
just launcher-k8-pro  # build K8 Pro Launcher keymap
just clean          # remove build output
just --list         # list available targets
```

Compiled JSON files are written to `out/via/` and `out/launcher/` by default. Use `OUTPUT` to write to a different directory:

```sh
just q1-max OUTPUT=~/Documents
```

## Output formats

Each keyboard definition (`keyboards/*.jsonnet`) supports two output formats, selected via a top-level argument:

- **VIA** (default) — JSON for the [VIA](https://usevia.app/) configurator.
- **Launcher** — JSON for the [Keychron Launcher](https://launcher.keychron.com/) web tool.

```sh
jsonnet keyboards/q1_max.jsonnet                        # VIA format
jsonnet --tla-str format=launcher keyboards/q1_max.jsonnet  # Launcher format
```

## Loading into VIA

The VIA-format files are meant to be used with [VIA](https://usevia.app/):

1. **Design tab** — Load the resource file (from `resources/`, also copied to `out/via/`) to define the keyboard model in the UI.
2. **Configure tab** — Load the generated keymap JSON from `out/via/` to apply the key layout.

## Loading into Keychron Launcher

The Launcher-format files can be imported into the [Keychron Launcher](https://launcher.keychron.com/). See [docs/keychron-launcher.md](docs/keychron-launcher.md) for details on the format.

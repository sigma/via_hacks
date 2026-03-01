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
just          # build all keymaps
just q1-max   # build Q1 Max keymap only
just k8-pro   # build K8 Pro keymap only
just clean    # remove build output
just --list   # list available targets
```

Compiled JSON files are written to `out/` by default and can be imported into VIA. Use `OUTPUT` to write to a different directory:

```sh
just q1-max OUTPUT=~/Documents
```

# Keychron Launcher Format

The [Keychron Launcher](https://launcher.keychron.com/) is a web-based tool for
configuring Keychron keyboards. It uses a JSON format that differs from VIA's
format by using raw 16-bit QMK keycode numbers with matrix coordinates instead
of flat string arrays.

## Output Format

```json
{
  "id": 875825168,
  "version": "1.0.0",
  "MD5": "<md5 of compact keymap JSON>",
  "keymap": [[{"col":0,"row":0,"val":41}, ...], ...],
  "knob": [{"left":"KC_VOLD","right":"KC_VOLU"}, ...]
}
```

### Fields

| Field | Description |
|-------|-------------|
| `id` | VIA `vendorProductId` (same value) |
| `version` | Always `"1.0.0"` |
| `MD5` | MD5 hash of the `keymap` array as compact JSON (no whitespace) |
| `keymap` | Array of layers; each layer is an array of `{col, row, val}` entries |
| `knob` | Encoder actions per layer (omitted if keyboard has no encoder) |

### MD5 Computation

The MD5 is computed over the `keymap` value serialized as compact JSON with no
whitespace (equivalent to Python's `json.dumps(keymap, separators=(',',':'))`).
In jsonnet: `std.md5(std.manifestJsonMinified(keymap))`.

## Matrix Mapping

VIA uses a flat array of keycodes per layer. The Launcher uses matrix
coordinates. The mapping is:

```
flat index i  ->  row = floor(i / cols),  col = i % cols
```

Where `cols` is the number of columns in the keyboard matrix (e.g. 15 for Q1
Max, 17 for K8 Pro).

Each layer also includes an extra row (row index = total physical rows) with
entries for encoder matrix padding. These are always `val: 0`.

## Keycode Encoding

The `val` field contains raw 16-bit QMK keycode numbers. The encoding depends
on the keycode type.

### Simple Keycodes (static lookup)

| Range | Description | Examples |
|-------|-------------|----------|
| 0x00-0x00 | No key | `KC_NO` = 0 |
| 0x01 | Transparent | `KC_TRNS` = 1 |
| 0x04-0x1D | Letters A-Z | `KC_A` = 4, `KC_Z` = 29 |
| 0x1E-0x27 | Numbers 1-0 | `KC_1` = 30, `KC_0` = 39 |
| 0x28-0x2C | Editing | `KC_ENT` = 40, `KC_SPC` = 44 |
| 0x2D-0x38 | Punctuation | `KC_MINS` = 45, `KC_SLSH` = 56 |
| 0x39 | Caps Lock | `KC_CAPS` = 57 |
| 0x3A-0x45 | Function keys | `KC_F1` = 58, `KC_F12` = 69 |
| 0x46-0x52 | Navigation | `KC_PSCR` = 70, `KC_UP` = 82 |
| 0xA8-0xAE | Media | `KC_MUTE` = 168, `KC_MPLY` = 174 |
| 0xBD-0xBE | Brightness | `KC_BRIU` = 189, `KC_BRID` = 190 |
| 0xE0-0xE7 | Modifiers | `KC_LCTL` = 224, `KC_RGUI` = 231 |

### Quantum Keycodes (static lookup)

| Range | Description | Examples |
|-------|-------------|----------|
| 0x7000+ | Magic | `MAGIC_TOGGLE_NKRO` = 28691 |
| 0x7800+ | RGB Lighting | `RGB_TOG` = 30752, `RGB_SPD` = 30762 |
| 0x7C00+ | Space Cadet | `KC_LSPO` = 31770, `KC_RSPC` = 31771 |

### Composite Keycodes (computed)

| Pattern | Formula | Description |
|---------|---------|-------------|
| `CUSTOM(n)` | `0x7E00 + n` | Keychron custom function (Q1 Max style) |
| `USERnn` | `0x7E00 + nn` | Keychron custom function (K8 Pro style) |
| `MO(n)` | `0x5220 + n` | Momentary layer activation |
| `MT(mod,key)` | `0x2000 + (mod_bits << 8) + key_code` | Mod-Tap |
| `LM(layer, mod\|...)` | `0x5000 + (layer << 5) + combined_mods` | Layer-Mod |

### Modifier Flags

Used in `MT()` and `LM()` composite keycodes:

| Flag | Value | Bits |
|------|-------|------|
| `MOD_LCTL` | 0x01 | Left Control |
| `MOD_LSFT` | 0x02 | Left Shift |
| `MOD_LALT` | 0x04 | Left Alt |
| `MOD_LGUI` | 0x08 | Left GUI |
| `MOD_RCTL` | 0x11 | Right Control |
| `MOD_RSFT` | 0x12 | Right Shift |
| `MOD_RALT` | 0x14 | Right Alt |
| `MOD_RGUI` | 0x18 | Right GUI |

Right modifiers have bit 4 (0x10) set plus the corresponding left modifier bit.

In `LM()`, multiple modifiers are combined with bitwise OR:
`MOD_LGUI | MOD_LCTL | MOD_LALT` = 0x08 + 0x01 + 0x04 = 0x0D

### MT (Mod-Tap) Bit Layout

```
Bit: 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
      0  0  1  0  |-- mod_bits --|  |--- key_code ---|
```

Example: `MT(MOD_LCTL, KC_ENT)` = 0x2000 + (0x01 << 8) + 0x28 = 0x2128 = 8488

### LM (Layer-Mod) Bit Layout

```
Bit: 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
      0  1  0  1  0  0  0  0  |- layer-|  |--mods--|
```

Example: `LM(0, MOD_LGUI | MOD_LCTL | MOD_LALT)` = 0x5000 + (0 << 5) + 0x0D = 0x500D = 20493

## Encoder / Knob Mapping

VIA encoders format:
```json
"encoders": [[ ["KC_VOLD","KC_VOLU"], ["RGB_VAD","RGB_VAI"], ... ]]
```

Launcher knob format (same data, reshaped):
```json
"knob": [{"left":"KC_VOLD","right":"KC_VOLU"}, {"left":"RGB_VAD","right":"RGB_VAI"}, ...]
```

The knob uses string keycodes (not numeric values). Each entry corresponds to
one layer. `left` = counter-clockwise, `right` = clockwise. Keyboards without
an encoder omit the `knob` field entirely.

## Usage

Build launcher keymaps:
```sh
just launcher           # both keyboards
just launcher-q1-max    # Q1 Max only
just launcher-k8-pro    # K8 Pro only
```

Import the generated JSON files from `out/` into the Keychron Launcher web app.

## Keycode Version Translation

The K8 Pro uses pre-refactor QMK firmware (~0.17.x, Keychron fork) whose numeric
keycode values differ from the post-refactor values (0.19+) used by the Q1 Max.
The `keycodes.libsonnet` library handles this via a table-driven translation step.

### How It Works

Each keyboard's matrix definition can include a `keycode_version` field:

```jsonnet
matrix:: { rows: 6, cols: 17, encoder_keys: 8, keycode_version: 'legacy' },
```

When `keycode_version` is `'legacy'`, `to_launcher()` wraps `encode()` with a
`translate()` function that converts current keycode values to their legacy
equivalents. When omitted or set to `'current'`, values pass through unchanged.

The translation uses three mechanisms:

1. **`legacy_ranges`** — a sorted array of `[current_start, current_end,
   legacy_start]` entries. For a value in `[start, end]`: `legacy_val =
   legacy_start + (val - current_start)`. A `null` legacy_start means the
   keycode is not available in legacy firmware.

2. **`legacy_keycodes`** — an object mapping `string(current_val)` to
   `legacy_val` for individual keycodes where the order changed between
   versions (e.g., backlight, auto-shift, magic keycodes).

3. **`translate_layer_mod(val)`** — a special-case function for QK_LAYER_MOD,
   which changed encoding format (4-bit mods in legacy vs 5-bit in current).

### Legacy Firmware Notes

Keychron's legacy firmware removed `BL_BRTG` from the flat enum, shifting all
keycodes after `BL_STEP` (23745) by -1 compared to standard QMK 0.18.0. The
legacy values in the translation tables account for this Keychron-specific shift.

## Keyboard Matrix Dimensions

| Keyboard | Rows | Cols | Encoder Keys | Keys/Layer | Keycode Version |
|----------|------|------|-------------|------------|-----------------|
| Q1 Max | 6 | 15 | 8 | 98 | current |
| K8 Pro | 6 | 17 | 8 | 110 | legacy |

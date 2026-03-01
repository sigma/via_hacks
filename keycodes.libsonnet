// Keycode converter for Keychron Launcher format.
// Converts VIA string keycodes to raw 16-bit QMK keycode numbers.

local simple = {
  // No key / transparent
  'KC_NO': 0,
  'KC_TRNS': 1,

  // Letters (USB HID usage codes)
  'KC_A': 4, 'KC_B': 5, 'KC_C': 6, 'KC_D': 7,
  'KC_E': 8, 'KC_F': 9, 'KC_G': 10, 'KC_H': 11,
  'KC_I': 12, 'KC_J': 13, 'KC_K': 14, 'KC_L': 15,
  'KC_M': 16, 'KC_N': 17, 'KC_O': 18, 'KC_P': 19,
  'KC_Q': 20, 'KC_R': 21, 'KC_S': 22, 'KC_T': 23,
  'KC_U': 24, 'KC_V': 25, 'KC_W': 26, 'KC_X': 27,
  'KC_Y': 28, 'KC_Z': 29,

  // Numbers
  'KC_1': 30, 'KC_2': 31, 'KC_3': 32, 'KC_4': 33,
  'KC_5': 34, 'KC_6': 35, 'KC_7': 36, 'KC_8': 37,
  'KC_9': 38, 'KC_0': 39,

  // Editing
  'KC_ENT': 40, 'KC_ESC': 41, 'KC_BSPC': 42,
  'KC_TAB': 43, 'KC_SPC': 44,

  // Punctuation
  'KC_MINS': 45, 'KC_EQL': 46,
  'KC_LBRC': 47, 'KC_RBRC': 48, 'KC_BSLS': 49,
  'KC_SCLN': 51, 'KC_QUOT': 52, 'KC_GRV': 53,
  'KC_COMM': 54, 'KC_DOT': 55, 'KC_SLSH': 56,

  // Locks
  'KC_CAPS': 57,

  // Function keys
  'KC_F1': 58, 'KC_F2': 59, 'KC_F3': 60, 'KC_F4': 61,
  'KC_F5': 62, 'KC_F6': 63, 'KC_F7': 64, 'KC_F8': 65,
  'KC_F9': 66, 'KC_F10': 67, 'KC_F11': 68, 'KC_F12': 69,

  // Navigation
  'KC_PSCR': 70, 'KC_SCRL': 71, 'KC_PAUS': 72,
  'KC_INS': 73, 'KC_HOME': 74, 'KC_PGUP': 75,
  'KC_DEL': 76, 'KC_END': 77, 'KC_PGDN': 78,
  'KC_RGHT': 79, 'KC_LEFT': 80, 'KC_DOWN': 81, 'KC_UP': 82,

  // Modifiers
  'KC_LCTL': 224, 'KC_LSFT': 225, 'KC_LALT': 226, 'KC_LGUI': 227,
  'KC_RCTL': 228, 'KC_RSFT': 229, 'KC_RALT': 230, 'KC_RGUI': 231,

  // Media / Consumer
  'KC_MUTE': 168, 'KC_VOLU': 169, 'KC_VOLD': 170,
  'KC_MNXT': 171, 'KC_MPRV': 172, 'KC_MSTP': 173, 'KC_MPLY': 174,

  // Brightness
  'KC_BRIU': 189, 'KC_BRID': 190,

  // RGB lighting (QK_LIGHTING range 0x7800)
  'RGB_TOG': 30752, 'RGB_MOD': 30753, 'RGB_RMOD': 30754,
  'RGB_HUI': 30755, 'RGB_HUD': 30756,
  'RGB_SAI': 30757, 'RGB_SAD': 30758,
  'RGB_VAI': 30759, 'RGB_VAD': 30760,
  'RGB_SPI': 30761, 'RGB_SPD': 30762,

  // Magic (QK_MAGIC range 0x7000)
  'MAGIC_TOGGLE_NKRO': 28691,

  // Space Cadet (QK_SPACE_CADET range 0x7C00)
  'KC_LSPO': 31770, 'KC_RSPC': 31771,
};

local mod_flags = {
  'MOD_LCTL': 1,   // 0x01
  'MOD_LSFT': 2,   // 0x02
  'MOD_LALT': 4,   // 0x04
  'MOD_LGUI': 8,   // 0x08
  'MOD_RCTL': 17,  // 0x11
  'MOD_RSFT': 18,  // 0x12
  'MOD_RALT': 20,  // 0x14
  'MOD_RGUI': 24,  // 0x18
};

// Parse combined modifier expression like "MOD_LGUI | MOD_LCTL | MOD_LALT"
local parse_mods(expr) =
  local parts = std.split(expr, '|');
  std.foldl(
    function(acc, part) acc + mod_flags[std.stripChars(part, ' ')],
    parts,
    0
  );

// Extract content between first '(' and last ')'
local extract_parens(str) =
  local open = std.findSubstr('(', str)[0];
  std.substr(str, open + 1, std.length(str) - open - 2);

// Encode a VIA string keycode to a raw 16-bit QMK keycode number
local encode(str) =
  if std.objectHas(simple, str) then
    simple[str]
  else if std.startsWith(str, 'CUSTOM(') then
    // CUSTOM(n) -> 0x7E00 + n
    local n = std.parseInt(extract_parens(str));
    32256 + n
  else if std.startsWith(str, 'USER') then
    // USERnn -> 0x7E00 + nn
    local nn = std.parseInt(std.substr(str, 4, std.length(str) - 4));
    32256 + nn
  else if std.startsWith(str, 'MO(') then
    // MO(n) -> 0x5220 + n
    local n = std.parseInt(extract_parens(str));
    21024 + n
  else if std.startsWith(str, 'MT(') then
    // MT(mod, key) -> 0x2000 + (mod_bits << 8) + key_code
    local inner = extract_parens(str);
    local parts = std.split(inner, ',');
    local mod_val = mod_flags[std.stripChars(parts[0], ' ')];
    local key_val = encode(std.stripChars(parts[1], ' '));
    8192 + mod_val * 256 + key_val
  else if std.startsWith(str, 'LM(') then
    // LM(layer, mods) -> 0x5000 + (layer << 5) + combined_mods
    local inner = extract_parens(str);
    local comma = std.findSubstr(',', inner)[0];
    local layer = std.parseInt(std.stripChars(std.substr(inner, 0, comma), ' '));
    local mods = parse_mods(std.substr(inner, comma + 1, std.length(inner) - comma - 1));
    20480 + layer * 32 + mods
  else
    error 'Unknown keycode: ' + str;

{
  encode:: encode,

  output(format, config, matrix)::
    if format == 'launcher' then
      self.to_launcher(config, matrix)
    else
      config,

  to_launcher(config, matrix)::
    local cols = matrix.cols;
    local rows = matrix.rows;
    local enc_keys = matrix.encoder_keys;

    local layer_to_entries(layer) = [
      { col: i % cols, row: std.floor(i / cols), val: encode(layer[i]) }
      for i in std.range(0, std.length(layer) - 1)
    ] + [
      { col: j, row: rows, val: 0 }
      for j in std.range(0, enc_keys - 1)
    ];

    local keymap = [layer_to_entries(l) for l in config.layers];

    local knob =
      if std.objectHas(config, 'encoders') && std.length(config.encoders) > 0 then
        [
          { left: config.encoders[0][i][0], right: config.encoders[0][i][1] }
          for i in std.range(0, std.length(config.encoders[0]) - 1)
        ]
      else
        null;

    {
      id: config.vendorProductId,
      version: '1.0.0',
      MD5: std.md5(std.manifestJsonMinified(keymap)),
      keymap: keymap,
      [if knob != null then 'knob']: knob,
    },
}

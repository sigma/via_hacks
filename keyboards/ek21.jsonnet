local keycodes = import 'keycodes.libsonnet';
local via = (import 'via.libsonnet')();
local kbd_module = (import 'ek21.libsonnet')();
local kbd = kbd_module.new(via);

// The EK21 as a Dirtywave M8 (iOS) controller.
//
// M8 keyboard mapping: Shift = LShift, Play = Space, Option = Z, Edit = X,
// directions = arrow keys. Combos with Shift are plain modifier keycodes;
// combos that need Z/X/Space held are VIA macros, since those are not
// modifiers. Shortcut reference: M8 operation manual v6.0.0.
//
// Layers:
//   0 edit  - tracker editing (copy/paste/clone, view navigation)
//   1 live  - live mode (mute/solo/cue)
//   2 notes - one chromatic octave on the 12 main keys (m8c "keyjazz" layout)
//   3 fn    - layer switching, connectivity, RGB
//
// Every layer keeps the same frame: the key next to the knob holds the fn
// layer, the tall key on the right is EDIT, and the bottom row is
// SHIFT / PLAY / OPTION.
local m8 = {
  local L = kbd.layer_idx,
  local C = kbd.custom_keys.get,
  local xxxxxx = 'KC_NO',

  layer_idx:: {
    edit: L.default_mac,
    live: L.default_win,
    notes: L.fn_mac,
    fn: L.fn_win,
  },

  macros_list:: [
    { name: 'CUT', seq: '{KC_X,KC_Z}' },  // Edit+Option: clear / cut value
    { name: 'NEW', seq: '{KC_X}{KC_X}' },  // double-tap Edit: next empty slot
    { name: 'CLONE', seq: '{+KC_LSFT}{KC_Z}{KC_X}{-KC_LSFT}' },  // Shift+[Option, Edit]
    { name: 'DCLONE', seq: '{+KC_LSFT}{KC_Z}{KC_X}{KC_X}{-KC_LSFT}' },  // Shift+[Option, Edit, Edit]: chain + phrases
    { name: 'PGUP', seq: '{KC_Z,KC_UP}' },  // Option+Up: 16 rows / previous phrase
    { name: 'PGDN', seq: '{KC_Z,KC_DOWN}' },  // Option+Down: 16 rows / next phrase
    { name: 'DEC', seq: '{KC_X,KC_LEFT}' },  // Edit+Left: value -1
    { name: 'INC', seq: '{KC_X,KC_RGHT}' },  // Edit+Right: value +1
    // Option released first so the mute / solo is held.
    { name: 'MUTE', seq: '{+KC_Z}{+KC_LSFT}{-KC_Z}{-KC_LSFT}' },  // Option+Shift
    { name: 'SOLO', seq: '{+KC_Z}{+KC_SPC}{-KC_Z}{-KC_SPC}' },  // Option+Play
    { name: 'CLRMS', seq: '{KC_Z,KC_LSFT,KC_SPC}' },  // Option+Shift+Play: clear mutes/solos
    { name: 'CUE', seq: '{KC_LEFT,KC_SPC}' },  // Left+Play: cue selected song row
    // Option+Left/Right: song: solo tracks left/right of cursor; phrase: prev/next
    // track; instrument: prev/next instrument; selection: fill / randomize.
    { name: 'OPTL', seq: '{KC_Z,KC_LEFT}' },
    { name: 'OPTR', seq: '{KC_Z,KC_RGHT}' },
    { name: 'BKMK', seq: '{KC_Z}{KC_Z}{KC_Z}' },  // Option x3: toggle chain bookmark (song view)
  ],

  M(name)::
    local idx = std.find(name, [m.name for m in self.macros_list]);
    'MACRO(%d)' % idx[0],

  macros:: [m.seq for m in self.macros_list] + via.block('', 16 - std.length(self.macros_list)),

  local ______ = 'KC_TRNS',
  local PLAY_SONG = 'LSFT(KC_SPC)',  // Shift+Play: play all tracks from the song cursor
  local TO(layer) = 'TO(%d)' % layer,
  local FN = 'MO(%d)' % self.layer_idx.fn,
  local bottom_row = ['KC_LSFT', 'KC_SPC', 'KC_Z'],

  edit_layer:: via.layer([
    [PLAY_SONG, FN, 'LSFT(KC_Z)', 'KC_Z'],
    [self.M('NEW'), self.M('CLONE'), 'LSFT(KC_X)', self.M('CUT')],
    [self.M('PGUP'), 'KC_UP', self.M('PGDN'), 'KC_X'],
    ['KC_LEFT', 'KC_DOWN', 'KC_RGHT'],
    [self.M('OPTL'), self.M('DCLONE'), self.M('OPTR')],
    bottom_row,
  ]),

  live_layer:: via.layer([
    [PLAY_SONG, FN, self.M('MUTE'), self.M('SOLO')],
    [self.M('CLRMS'), self.M('CUE'), self.M('OPTL'), self.M('OPTR')],
    [self.M('PGUP'), 'KC_UP', self.M('PGDN'), 'KC_X'],
    ['KC_LEFT', 'KC_DOWN', 'KC_RGHT'],
    [self.M('BKMK'), xxxxxx, xxxxxx],
    bottom_row,
  ]),

  // Chromatic octave, C at bottom-left, reading left to right then up.
  // The app maps the home row to white keys and the row above to black keys:
  // C C# D D# E F F# G G# A A# B = A W S E D F T G Y H U J, then K for C'.
  notes_layer:: via.layer([
    ['KC_ESC', FN, 'KC_PSLS', 'KC_PAST'],  // keyjazz on/off | octave down / up
    ['KC_H', 'KC_U', 'KC_J', 'KC_K'],  // A  A# B  C'
    ['KC_T', 'KC_G', 'KC_Y', 'KC_X'],  // F# G  G#
    ['KC_E', 'KC_D', 'KC_F'],  // D# E  F
    ['KC_A', 'KC_W', 'KC_S'],  // C  C# D
    bottom_row,
  ]),

  fn_layer:: via.layer([
    [PLAY_SONG, ______, 'RGB_TOG', 'RGB_MOD'],  // ______ is the MO(fn) key itself
    [C('BLE1'), C('BLE2'), C('BLE3'), C('2.4G')],
    [C('USB'), C('BAT'), self.M('CLRMS'), 'KC_X'],
    [xxxxxx, xxxxxx, xxxxxx],
    [TO(self.layer_idx.edit), TO(self.layer_idx.live), TO(self.layer_idx.notes)],
    bottom_row,
  ]),

  layers:: kbd.layers({
    default_mac: $.edit_layer,
    default_win: $.live_layer,
    fn_mac: $.notes_layer,
    fn_win: $.fn_layer,
  }),

  encoders:: [[
    [self.M('DEC'), self.M('INC')],  // edit: value -1 / +1
    ['KC_UP', 'KC_DOWN'],  // live: scroll rows
    ['KC_PSLS', 'KC_PAST'],  // notes: octave down / up
    ['RGB_VAD', 'RGB_VAI'],  // fn: brightness
  ]],
};

local cfg = {
  name: kbd.name,
  vendorProductId: kbd.id,
  macros: m8.macros,
  layers: m8.layers,
  encoders: m8.encoders,
};

function(format='via')
  keycodes.output(format, cfg, kbd.matrix)

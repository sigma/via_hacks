local keyboard = import 'keyboard.libsonnet';

function() {
  new:: function(via) keyboard(via) + {
    local ______ = 'KC_TRNS',
    local xxxxxx = 'KC_NO',

    name:: 'EPOMAKER EK21',
    id:: 14000 * 65536 + 12390,
    matrix:: { rows: 6, cols: 6, encoder_keys: 0 },

    // EK21 firmware layer order: mac, win, fn_mac, fn_win
    layer_idx:: {
      default_mac: 0,
      default_win: 1,
      fn_mac: 2,
      fn_win: 3,
    },

    layers:: function(overrides={})
      local names = ['default_mac', 'default_win', 'fn_mac', 'fn_win'];
      local defaults = [
        self.default_mac_layer(),
        self.default_win_layer(),
        self.default_mac_fn_layer(),
        self.default_win_fn_layer(),
      ];
      via.layers([
        if std.objectHas(overrides, names[i]) then overrides[names[i]]
        else defaults[i]
        for i in std.range(0, std.length(names) - 1)
      ], self.padder),

    default_macros:: function()
      via.block('', 16),

    default_mac_layer:: function()
      local L = self.layer_idx;

      via.layer([
        ['KC_MUTE', 'MO(%d)' % L.fn_mac, 'KC_TAB', 'KC_BSPC'],
        ['KC_NLCK', 'KC_PSLS', 'KC_PAST', 'KC_PMNS'],
        ['KC_P7', 'KC_P8', 'KC_P9', 'KC_PPLS'],
        ['KC_P4', 'KC_P5', 'KC_P6'],
        ['KC_P1', 'KC_P2', 'KC_P3'],
        ['KC_P0', 'KC_PDOT', 'KC_PENT'],
      ]),

    default_win_layer:: function()
      local L = self.layer_idx;

      via.layer([
        ['KC_MUTE', 'MO(%d)' % L.fn_win, 'KC_TAB', 'KC_BSPC'],
        ['KC_NLCK', 'KC_PSLS', 'KC_PAST', 'KC_PMNS'],
        ['KC_P7', 'KC_P8', 'KC_P9', 'KC_PPLS'],
        ['KC_P4', 'KC_P5', 'KC_P6'],
        ['KC_P1', 'KC_P2', 'KC_P3'],
        ['KC_P0', 'KC_PDOT', 'KC_PENT'],
      ]),

    default_mac_fn_layer:: function()
      local C = self.custom_keys.get;

      via.layer([
        ['RGB_TOG', xxxxxx, 'CUSTOM(11)', C('RTOG')],
        ['CUSTOM(13)', 'RGB_HUD', 'RGB_HUI', 'RGB_VAD'],
        ['RGB_SPD', 'RGB_SPI', 'TO(1)', 'RGB_VAI'],
        [C('2.4G'), 'RGB_SAI', 'RGB_SAD'],
        [C('BLE1'), C('BLE2'), C('BLE3')],
        [C('U_EE_CLR'), C('BAT'), 'RGB_MOD'],
      ]),

    default_win_fn_layer:: function()
      local C = self.custom_keys.get;

      via.layer([
        ['RGB_TOG', xxxxxx, 'CUSTOM(11)', C('RTOG')],
        ['CUSTOM(13)', 'RGB_HUD', 'RGB_HUI', 'RGB_VAD'],
        ['RGB_SPD', 'RGB_SPI', 'TO(0)', 'RGB_VAI'],
        [C('2.4G'), 'RGB_SAI', 'RGB_SAD'],
        [C('BLE1'), C('BLE2'), C('BLE3')],
        [C('U_EE_CLR'), C('BAT'), 'RGB_MOD'],
      ]),

    // pad each row to 6 columns to match the matrix
    padder:: function(keys) [
      // row 0: keys 0 and 3 are pushed to index 5 and 4 respectively.
      keys[0][0:4],
      keys[0][3:4], keys[0][0:1],
      // row 1: 4 keys + 2 padding
      keys[1][0:4],
      via.no(2),
      // row 2: 4 keys + 2 padding
      keys[2][0:4],
      via.no(2),
      // row 3: 3 keys + 3 padding
      keys[3][0:3],
      via.no(3),
      // row 4: key at pos 0, KC_NO at pos 1, keys at pos 2-3, 2 padding
      keys[4][0:1],
      via.no(1),
      keys[4][1:3],
      via.no(2),
      // row 5: 3 keys + 3 padding
      keys[5][0:3],
      via.no(3),
    ],

    default_encoders:: function() [
      [
        ['KC_VOLD', 'KC_VOLU'],
        ['KC_VOLD', 'KC_VOLU'],
        ['RGB_SAD', 'RGB_SAI'],
        ['RGB_SAD', 'RGB_SAI'],
      ],
    ],

    custom_keys:: {
      keys:: [
        '2.4G',
        'BLE1',
        'BLE2',
        'BLE3',
        'USB',
        'BAT',
        'WLO',
        'SIX_N',
        'RTOG',
        'U_EE_CLR',
        'QK_DEB',
      ],

      get:: function(label)
        local idx = std.find(label, self.keys);
        std.format('CUSTOM(%d)', idx[0]),
    },
  },
}

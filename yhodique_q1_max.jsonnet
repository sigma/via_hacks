local via = (import 'via.libsonnet')();
local q1_max = (import 'q1-max.libsonnet')();

local kbd = q1_max.new(via);
local xxxxxx = 'KC_NO';

local cfg = {
    default_layer:: function()
      local MC = kbd.custom_keys.get("Mission Control");
      local LP = kbd.custom_keys.get("Launch pad");
      local LO = kbd.custom_keys.get("Left Option");
      local LC = kbd.custom_keys.get("Left Cmd");
      local RC = kbd.custom_keys.get("Right Cmd");

      via.layer([
        ['KC_ESC', 'KC_BRID','KC_BRIU',MC,LP, 'RGB_VAD','RGB_VAI','KC_MPRV','KC_MPLY', 'KC_MNXT','KC_MUTE','KC_VOLD','KC_VOLU',     'KC_DEL',     'KC_MUTE'],
        ['KC_GRV','KC_1','KC_2','KC_3','KC_4','KC_5','KC_6','KC_7','KC_8','KC_9','KC_0','KC_MINS','KC_EQL',     'KC_BSPC',       'KC_PGUP'],
        ['KC_TAB',  'KC_Q','KC_W','KC_E','KC_R','KC_T','KC_Y','KC_U','KC_I','KC_O','KC_P', 'KC_LBRC', 'KC_RBRC', 'KC_BSLS',      'KC_PGDN'],
        ['MT(MOD_LCTL,KC_ENT)','KC_A','KC_S','KC_D','KC_F','KC_G','KC_H','KC_J','KC_K','KC_L','KC_SCLN','KC_QUOT','MT(MOD_RCTL,KC_ENT)', 'KC_HOME'                     ],
        ['KC_LSPO',     'KC_Z','KC_X','KC_C','KC_V','KC_B','KC_N','KC_M', 'KC_COMM', 'KC_DOT', 'KC_SLSH',       'KC_RSPC',                  'KC_UP'             ],
        ['MO(3)',LC,LO,                           'KC_SPC',                                       RC,'MO(1)','MO(3)',         'KC_LEFT', 'KC_DOWN', 'KC_RGHT'],
      ]),

    // same as kbd.default_mac_fn_layer but without transparent keys
    fn_layer:: function()
      local BT1 = kbd.custom_keys.get("Bluetooth Host 1");
      local BT2 = kbd.custom_keys.get("Bluetooth Host 2");
      local BT3 = kbd.custom_keys.get("Bluetooth Host 3");
      local WL = kbd.custom_keys.get("2.4G");
      local BL = kbd.custom_keys.get("Battery Level");
      local NKRO = 'MAGIC_TOGGLE_NKRO';

      via.layer([
        [ xxxxxx,    'KC_F1','KC_F2','KC_F3','KC_F4',  'KC_F5','KC_F6','KC_F7','KC_F8',  'KC_F9','KC_F10','KC_F11','KC_F12',        xxxxxx,'RGB_TOG'],
        [ xxxxxx,BT1, BT2, BT3,  WL,     xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx,  xxxxxx,  xxxxxx,  xxxxxx,        xxxxxx,                  xxxxxx  ],
        ['RGB_TOG','RGB_MOD','RGB_VAI','RGB_HUI','RGB_SAI','RGB_SPI',xxxxxx,xxxxxx,xxxxxx,xxxxxx,xxxxxx,xxxxxx,xxxxxx,xxxxxx,               xxxxxx  ],
        [xxxxxx,'RGB_RMOD','RGB_VAD','RGB_HUD','RGB_SAD','RGB_SPD', xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx,                'KC_END'                 ],
        [xxxxxx,    xxxxxx,   xxxxxx,   xxxxxx,   xxxxxx,   BL,   NKRO,   xxxxxx,   xxxxxx,   xxxxxx,   xxxxxx,   xxxxxx,                   xxxxxx          ],
        [xxxxxx,xxxxxx,xxxxxx,                           xxxxxx,                                xxxxxx,xxxxxx,xxxxxx,xxxxxx,        xxxxxx, xxxxxx, xxxxxx  ],
      ]),

    // my controls for rectangle window management
    rect_layer:: function()
      via.layer([
        [ xxxxxx,  xxxxxx,xxxxxx,xxxxxx,xxxxxx,  xxxxxx,xxxxxx,xxxxxx,xxxxxx,  xxxxxx,xxxxxx,xxxxxx,xxxxxx, 'HYPR(KC_PSCR)', xxxxxx],
        [ xxxxxx,  'HYPR(KC_1)','HYPR(KC_2)','HYPR(KC_3)','HYPR(KC_4)','HYPR(KC_5)','HYPR(KC_6)', xxxxxx, xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_MINS)', 'HYPR(KC_EQL)',  'HYPR(KC_BSPC)', xxxxxx],
        [xxxxxx, xxxxxx, 'HYPR(KC_W)',    'HYPR(KC_E)', xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_U)',    'HYPR(KC_I)', xxxxxx, xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_BSLS)', xxxxxx],
        [xxxxxx, 'HYPR(KC_A)',    'HYPR(KC_S)',    'HYPR(KC_D)', xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_J)',    'HYPR(KC_K)', xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_ENT)', xxxxxx],
        [xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_M)', xxxxxx, xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_UP)'],
        [xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_SPC)', xxxxxx, xxxxxx, xxxxxx, 'HYPR(KC_LEFT)', 'HYPR(KC_DOWN)', 'HYPR(KC_RGHT)'],
      ]),

  name: kbd.name,
  vendorProductId: kbd.id,
  macros: kbd.default_macros(),
  layers: via.layers([
    self.default_layer(),
    self.fn_layer(),
    kbd.default_win_layer(), // just fall back to normal qwerty if the windows switch is activated
    self.rect_layer(),
  ], kbd.padder),
  encoders: [
    [
      [
        "KC_VOLD",
        "KC_VOLU"
      ],
      [
        "RGB_VAD",
        "RGB_VAI"
      ],
      [
        "KC_VOLD",
        "KC_VOLU"
      ],
      [
        "RGB_VAD",
        "RGB_VAI"
      ]
    ]
  ]
};

function()
  cfg

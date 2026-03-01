local via = (import 'via.libsonnet')();
local k8_pro = (import 'k8-pro.libsonnet')();

local kbd = k8_pro.new(via);
local xxxxxx = "KC_NO";

local cfg = {
    default_layer:: function()
      local MC = kbd.custom_keys.get("Mission Control");
      local LP = kbd.custom_keys.get("Launch pad");
      local SS = kbd.custom_keys.get("Screen shot");
      local SI = kbd.custom_keys.get("Siri");
      local LO = kbd.custom_keys.get("Left Option");
      local LC = kbd.custom_keys.get("Left Cmd");
      local RO = kbd.custom_keys.get("Right Option");
      local RC = kbd.custom_keys.get("Right Cmd");
      local HYPR = 'LM(0, MOD_LGUI | MOD_LCTL | MOD_LALT)';

      via.layer([
        ['KC_ESC', 'KC_BRID','KC_BRIU',MC,LP, 'RGB_VAD','RGB_VAI','KC_MPRV','KC_MPLY', 'KC_MNXT','KC_MUTE','KC_VOLD','KC_VOLU',     SS,        SI,     'RGB_MOD'],
        ['KC_GRV','KC_1','KC_2','KC_3','KC_4','KC_5','KC_6','KC_7','KC_8','KC_9','KC_0','KC_MINS','KC_EQL',     'KC_BSPC',       'KC_INS',  'KC_HOME', 'KC_PGUP'],
        ['KC_TAB',  'KC_Q','KC_W','KC_E','KC_R','KC_T','KC_Y','KC_U','KC_I','KC_O','KC_P', 'KC_LBRC', 'KC_RBRC', 'KC_BSLS',      'KC_DEL',  'KC_END',  'KC_PGDN'],
        ['MT(MOD_LCTL,KC_ENT)','KC_A','KC_S','KC_D','KC_F','KC_G','KC_H','KC_J','KC_K','KC_L','KC_SCLN','KC_QUOT','MT(MOD_RCTL,KC_ENT)'                         ],
        ['KC_LSPO',     'KC_Z','KC_X','KC_C','KC_V','KC_B','KC_N','KC_M', 'KC_COMM', 'KC_DOT', 'KC_SLSH',       'KC_RSPC',                  'KC_UP'             ],
        [HYPR,LC,LO,                           'KC_SPC',                                       RO,RC,'MO(1)',HYPR,         'KC_LEFT', 'KC_DOWN', 'KC_RGHT'],
      ]),

    // same as kbd.default_mac_fn_layer but without transparent keys
    fn_layer:: function()
      local BT1 = kbd.custom_keys.get("Bluetooth Host 1");
      local BT2 = kbd.custom_keys.get("Bluetooth Host 2");
      local BT3 = kbd.custom_keys.get("Bluetooth Host 3");
      local BL = kbd.custom_keys.get("Battery Level");

      via.layer([
        [ xxxxxx,    'KC_F1','KC_F2','KC_F3','KC_F4',  'KC_F5','KC_F6','KC_F7','KC_F8',  'KC_F9','KC_F10','KC_F11','KC_F12',       xxxxxx, xxxxxx,'RGB_TOG'],
        [ xxxxxx,BT1, BT2, BT3,  xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx,  xxxxxx,  xxxxxx,  xxxxxx,        xxxxxx,         xxxxxx, xxxxxx, xxxxxx  ],
        ['RGB_TOG','RGB_MOD','RGB_VAI','RGB_HUI','RGB_SAI','RGB_SPI',xxxxxx,xxxxxx,xxxxxx,xxxxxx,xxxxxx,xxxxxx,xxxxxx,xxxxxx,      xxxxxx, xxxxxx, xxxxxx  ],
        [xxxxxx,'RGB_RMOD','RGB_VAD','RGB_HUD','RGB_SAD','RGB_SPD', xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx, xxxxxx                                 ],
        [xxxxxx,    xxxxxx,   xxxxxx,   xxxxxx,   xxxxxx,   BL,   xxxxxx,   xxxxxx,   xxxxxx,   xxxxxx,   xxxxxx,   xxxxxx,                xxxxxx          ],
        [xxxxxx,xxxxxx,xxxxxx,                           xxxxxx,                                xxxxxx,xxxxxx,xxxxxx,xxxxxx,       xxxxxx, xxxxxx, xxxxxx  ],
      ]),

  name: kbd.name,
  vendorProductId: kbd.id,
  macros: kbd.default_macros(),
  layers: via.layers([
    self.default_layer(),
    self.fn_layer(),
    kbd.default_win_layer(),
    kbd.default_win_fn_layer(),
  ], kbd.padder),
};

function()
  cfg

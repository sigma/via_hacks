local keycodes = import 'keycodes.libsonnet';
local via = (import 'via.libsonnet')();
local q1_max = (import 'q1-max.libsonnet')();

local kbd = q1_max.new(via);

local cfg = {
    default_layer:: function()
      local LO = kbd.custom_keys.get("Left Option");
      local LC = kbd.custom_keys.get("Left Cmd");
      local HYPR = 'LM(0, MOD_LGUI | MOD_LCTL | MOD_LALT)';

      kbd.default_mac_layer().override([
        null,
        null,
        null,
        ['MT(MOD_LCTL,KC_ENT)', null, null, null, null, null, null, null, null, null, null, null, 'MT(MOD_RCTL,KC_ENT)', null],
        ['KC_LSPO', null, null, null, null, null, null, null, null, null, null, 'KC_RSPC', null],
        [HYPR, LC, LO, null, null, null, HYPR, null, null, null],
      ]),

    fn_layer:: function() kbd.default_mac_fn_layer(),

  name: kbd.name,
  vendorProductId: kbd.id,
  macros: kbd.default_macros(),
  layers: via.layers([
    self.default_layer(),
    self.fn_layer(),
    kbd.default_win_layer(), // just fall back to normal qwerty if the windows switch is activated
    kbd.default_win_fn_layer(),
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

function(format='via')
  keycodes.output(format, cfg, kbd.matrix)

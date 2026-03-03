local keycodes = import 'keycodes.libsonnet';
local keys = import 'keys.libsonnet';
local via = (import 'via.libsonnet')();
local q1_max = (import 'q1-max.libsonnet')();

local kbd = q1_max.new(via);

local cfg = {
    default_layer:: function()
      local LO = kbd.custom_keys.get("Left Option");
      local LC = kbd.custom_keys.get("Left Cmd");

      kbd.default_mac_layer().override([
        null,
        null,
        null,
        [keys.LCTL_ENT, null, null, null, null, null, null, null, null, null, null, null, keys.RCTL_ENT, null],
        [keys.LSPO, null, null, null, null, null, null, null, null, null, null, keys.RSPC, null],
        [keys.HYPR(0), LC, LO, null, null, null, keys.HYPR(0), null, null, null],
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

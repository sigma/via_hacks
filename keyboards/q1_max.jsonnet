local keycodes = import 'keycodes.libsonnet';
local via = (import 'via.libsonnet')();
local q1_max = (import 'q1-max.libsonnet')();

local kbd = q1_max.new(via);
local keys = (import 'keys.libsonnet')(kbd);
local layouts = (import 'layouts.libsonnet')(keys);

local cfg = {
    default_layer:: function()
      kbd.default_mac_layer()
        .override(layouts.symmetrical_ctrl_return)
        .override(layouts.space_cadet)
        .override({
          '5': [keys.HYPR(0), keys.LC, keys.LO, null, null, null, keys.HYPR_S(0)],
        }),

  local dl = self.default_layer(),
  name: kbd.name,
  vendorProductId: kbd.id,
  macros: kbd.default_macros(),
  layers: kbd.layers({ default_mac: dl }),
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

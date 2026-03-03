local keycodes = import 'keycodes.libsonnet';
local via = (import 'via.libsonnet')();
local q1_max = (import 'q1-max.libsonnet')();

local kbd = q1_max.new(via);
local keys = (import 'keys.libsonnet')(kbd);

local cfg = {
    default_layer:: function()
      kbd.default_mac_layer().override([
        null,
        null,
        null,
        [keys.LCTL_ENT, null, null, null, null, null, null, null, null, null, null, null, keys.RCTL_ENT, null],
        [keys.LSPO, null, null, null, null, null, null, null, null, null, null, keys.RSPC, null],
        [keys.HYPR(0), keys.LC, keys.LO, null, null, null, keys.HYPR_S(0), null, null, null],
      ]),

    fn_layer:: function() kbd.default_mac_fn_layer(),

  name: kbd.name,
  vendorProductId: kbd.id,
  macros: kbd.default_macros(),
  layers: kbd.layers([self.default_layer(), self.fn_layer()]),
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

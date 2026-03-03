local keycodes = import 'keycodes.libsonnet';
local via = (import 'via.libsonnet')();
local k8_pro = (import 'k8-pro.libsonnet')();

local kbd = k8_pro.new(via);
local keys = (import 'keys.libsonnet')(kbd);

local cfg = {
    default_layer:: function()
      kbd.default_mac_layer().override([
        null,
        null,
        null,
        [keys.LCTL_ENT, null, null, null, null, null, null, null, null, null, null, null, keys.RCTL_ENT],
        [keys.LSPO, null, null, null, null, null, null, null, null, null, null, keys.RSPC, null],
        [keys.HYPR(0), keys.LC, keys.LO, null, keys.RO, keys.RC, null, keys.HYPR_S(0), null, null, null],
      ]),

    fn_layer:: function() kbd.default_mac_fn_layer(),

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

function(format='via')
  keycodes.output(format, cfg, kbd.matrix)

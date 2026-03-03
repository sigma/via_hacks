local keycodes = import 'keycodes.libsonnet';
local via = (import 'via.libsonnet')();
local k8_pro = (import 'k8-pro.libsonnet')();

local kbd = k8_pro.new(via);
local keys = (import 'keys.libsonnet')(kbd);
local layouts = (import 'layouts.libsonnet')(keys, kbd);

local cfg = {
  default_layer:: function()
    kbd.default_mac_layer()
    .override(layouts.symmetrical_ctrl_return)
    .override(layouts.space_cadet)
    .override({
      [kbd.rows.mods]: [keys.HYPR(kbd.layer_idx.default_mac), keys.LC, keys.LO, null, keys.RO, keys.RC, null, keys.HYPR_S(kbd.layer_idx.default_mac)],
    }),

  local dl = self.default_layer(),
  name: kbd.name,
  vendorProductId: kbd.id,
  macros: kbd.default_macros(),
  layers: kbd.layers({ default_mac: dl }),
};

function(format='via')
  keycodes.output(format, cfg, kbd.matrix)

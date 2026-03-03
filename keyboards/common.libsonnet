local keycodes = import 'keycodes.libsonnet';
local via = (import 'via.libsonnet')();

function(kbd_module) {
  local kbd = kbd_module.new(via),
  local keys = (import 'keys.libsonnet')(kbd),
  local layouts = (import 'layouts.libsonnet')(keys, kbd),

  local cfg = {
    default_layer:: function()
      kbd.default_mac_layer()
      .override(layouts.symmetrical_ctrl_return)
      .override(layouts.space_cadet)
      .override(layouts.hyper_mods(kbd.layer_idx.default_mac)),

    local dl = self.default_layer(),
    name: kbd.name,
    vendorProductId: kbd.id,
    macros: kbd.default_macros(),
    layers: kbd.layers({ default_mac: dl }),
  } + if std.objectHasAll(kbd, 'default_encoders') then {
    encoders: kbd.default_encoders(),
  } else {},

  output:: function(format='via')
    keycodes.output(format, cfg, kbd.matrix),
}

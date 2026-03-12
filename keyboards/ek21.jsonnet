local keycodes = import 'keycodes.libsonnet';
local via = (import 'via.libsonnet')();
local kbd_module = (import 'ek21.libsonnet')();
local kbd = kbd_module.new(via);

local cfg = {
  name: kbd.name,
  vendorProductId: kbd.id,
  macros: kbd.default_macros(),
  layers: kbd.layers(),
  encoders: kbd.default_encoders(),
};

function(format='via')
  keycodes.output(format, cfg, kbd.matrix)

local via = (import 'via.libsonnet')();
local k8_pro = (import 'k8-pro.libsonnet')();

local kbd = k8_pro.new(via);

local cfg = {
    default_layer:: function()
      local LO = kbd.custom_keys.get("Left Option");
      local LC = kbd.custom_keys.get("Left Cmd");
      local RO = kbd.custom_keys.get("Right Option");
      local RC = kbd.custom_keys.get("Right Cmd");
      local HYPR = 'LM(0, MOD_LGUI | MOD_LCTL | MOD_LALT)';

      kbd.default_mac_layer().override([
        null,
        null,
        null,
        ['MT(MOD_LCTL,KC_ENT)', null, null, null, null, null, null, null, null, null, null, null, 'MT(MOD_RCTL,KC_ENT)'],
        ['KC_LSPO', null, null, null, null, null, null, null, null, null, null, 'KC_RSPC', null],
        [HYPR, LC, LO, null, RO, RC, null, HYPR, null, null, null],
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

function()
  cfg

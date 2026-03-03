// Common keycode aliases shared across keyboard definitions.
function(kbd) {
  HYPR(layer):: 'LM(%d, MOD_LGUI | MOD_LCTL | MOD_LALT)' % layer,
  HYPR_S(layer):: 'LM(%d, MOD_LGUI | MOD_LCTL | MOD_LALT | MOD_LSFT)' % layer,
  LCTL_ENT:: 'MT(MOD_LCTL,KC_ENT)',
  RCTL_ENT:: 'MT(MOD_RCTL,KC_ENT)',
  LSPO:: 'KC_LSPO',
  RSPC:: 'KC_RSPC',
  LO:: kbd.custom_keys.get('Left Option'),
  LC:: kbd.custom_keys.get('Left Cmd'),
  RO:: kbd.custom_keys.get('Right Option'),
  RC:: kbd.custom_keys.get('Right Cmd'),
}

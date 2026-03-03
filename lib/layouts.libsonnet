function(keys, kbd) {
  local rows = kbd.rows,
  symmetrical_ctrl_return:: { [rows.home]: [keys.LCTL_ENT, null, null, null, null, null, null, null, null, null, null, null, keys.RCTL_ENT] },
  space_cadet:: { [rows.lower]: [keys.LSPO, null, null, null, null, null, null, null, null, null, null, keys.RSPC] },
  hyper_mods:: function(layer) {
    local right = if kbd.right_mods >= 4 then [keys.RO, keys.RC, null, keys.HYPR_S(layer)]
                  else [null, null, keys.HYPR_S(layer)],
    [rows.mods]: [keys.HYPR(layer), keys.LC, keys.LO, null] + right,
  },
}

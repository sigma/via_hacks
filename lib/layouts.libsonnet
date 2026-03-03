function(keys, kbd) {
  local rows = kbd.rows,
  symmetrical_ctrl_return:: { [rows.home]: [keys.LCTL_ENT, null, null, null, null, null, null, null, null, null, null, null, keys.RCTL_ENT] },
  space_cadet:: { [rows.lower]: [keys.LSPO, null, null, null, null, null, null, null, null, null, null, keys.RSPC] },
}

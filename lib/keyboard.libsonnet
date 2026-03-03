function(via) {
  rows:: {
    funcs: '0',
    number: '1',
    upper: '2',
    home: '3',
    lower: '4',
    mods: '5',
  },

  layers:: function(overrides={})
    local names = ['default_mac', 'fn_mac', 'default_win', 'fn_win'];
    local defaults = [
      self.default_mac_layer(),
      self.default_mac_fn_layer(),
      self.default_win_layer(),
      self.default_win_fn_layer(),
    ];
    via.layers([
      if std.objectHas(overrides, names[i]) then overrides[names[i]]
      else defaults[i]
      for i in std.range(0, std.length(names) - 1)
    ], self.padder),
}

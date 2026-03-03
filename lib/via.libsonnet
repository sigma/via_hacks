local _layer = function(keys)
  {
    keys:: keys,

    flatten:: function()
      std.flattenArrays(self.keys),

    pad:: function(padder)
      _layer(padder(keys)),

    override:: function(overrides)
      _layer([
        if std.objectHas(overrides, std.toString(i)) then [
          if j >= std.length(overrides[std.toString(i)]) || overrides[std.toString(i)][j] == null then self.keys[i][j]
          else overrides[std.toString(i)][j]
          for j in std.range(0, std.length(self.keys[i]) - 1)
        ]
        else self.keys[i]
        for i in std.range(0, std.length(self.keys) - 1)
      ]),
  };

function()
  {
    layer:: function(keys)
      _layer(keys),

    layers:: function(lyrs, padder)
      [l.pad(padder).flatten() for l in lyrs],

    block:: function(s, n)
      [s for i in std.range(1, n)],

    no:: function(n)
      self.block("KC_NO", n),

    trns:: function(n)
      self.block("KC_TRNS", n),
  }

local kbd = (import 'q1-max.libsonnet')();
local common = (import 'common.libsonnet')(kbd);

function(format='via')
  common.output(format)

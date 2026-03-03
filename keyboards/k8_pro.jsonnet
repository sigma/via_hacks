local kbd = (import 'k8-pro.libsonnet')();
local common = (import 'common.libsonnet')(kbd);

function(format='via')
  common.output(format)

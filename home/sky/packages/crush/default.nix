{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  sys.packages = lib.mkIf config.sys.profiles.graphical.enable {
    inherit (inputs.ai-tools.packages.${pkgs.system}) crush;
  };

  xdg.configFile."crush/crush.json".source = ./config.json;
}

{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.profiles = {
    graphical.enable = mkEnableOption "Graphical Interface";
    headless.enable = mkEnableOption "Headless";
  };
}

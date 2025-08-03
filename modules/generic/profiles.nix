{ lib, ... }:
let
  inherit (lib) mkEnableOption;
in
{
  options.gum.profiles = {
    graphical.enable = mkEnableOption "Graphical Interface";
    headless.enable = mkEnableOption "Headless";
  };
}

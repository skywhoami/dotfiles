{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  options.gum.services.docker.enable = mkEnableOption "Enable Docker";

  config = mkIf config.gum.services.docker.enable {
    virtualisation.docker.enable = true;
  };
}

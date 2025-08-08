{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  options.sys.services.docker.enable = mkEnableOption "Enable Docker";

  config = mkIf config.sys.services.docker.enable {
    virtualisation.docker.enable = true;
  };
}

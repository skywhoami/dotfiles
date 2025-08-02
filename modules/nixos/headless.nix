{ lib, config, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.profiles.headless.enable {
    environment.variables.BROWSER = "echo";
    systemd = {
      enableEmergencyMode = false;

      sleep.extraConfig = ''
        AllowSuspend=no
        AllowHibernation=no
      '';
    };
  };
}

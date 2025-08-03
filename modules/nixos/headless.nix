{ lib, config, ... }:
{
  config = lib.mkIf config.gum.profiles.headless.enable {
    environment.variables.BROWSER = "echo";

    systemd = {
      enableEmergencyMode = false;
    };
  };
}

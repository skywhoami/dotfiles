{ lib, config, ... }:
{
  config = lib.mkIf config.profiles.headless.enable {
    environment.variables.BROWSER = "echo";

    systemd = {
      enableEmergencyMode = false;
    };
  };
}

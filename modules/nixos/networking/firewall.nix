{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = {
    networking.firewall = {
      enable = true;
      package = pkgs.iptables;

      allowedTCPPorts = [
        443
      ];
      allowedUDPPorts = [ ];

      allowedTCPPortRanges = [ ];
      allowedUDPPortRanges = [ ];

      allowPing = config.profiles.headless.enable;

      logReversePathDrops = true;
      logRefusedConnections = false;

      checkReversePath = lib.mkForce false;
    };
  };
}

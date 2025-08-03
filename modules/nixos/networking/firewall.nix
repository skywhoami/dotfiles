{ pkgs, config, ... }:
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

      allowPing = config.gum.profiles.headless.enable;
    };
  };
}

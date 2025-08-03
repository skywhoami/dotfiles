{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (config.services) tailscale;
in
{
  config = {
    packages = { inherit (pkgs) tailscale; };
    networking.firewall = {
      trustedInterfaces = [ "${tailscale.interfaceName}" ];
      allowedUDPPorts = [ tailscale.port ];
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = lib.mkDefault true;
    };
  };
}

{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.services) tailscale;
in
{
  options.sys.networking.tailscale.enable = mkEnableOption "Enable Tailscale";

  config = mkIf config.sys.system.networking.tailscale.enable {
    sys.packages = { inherit (pkgs) tailscale; };
    networking.firewall = {
      trustedInterfaces = [ "${tailscale.interfaceName}" ];
      allowedUDPPorts = [ tailscale.port ];
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = lib.mkDefault "server";
    };
  };
}

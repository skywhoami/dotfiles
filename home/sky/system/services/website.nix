{ config, lib, ... }:
{
  config = lib.mkIf config.gum.services.caddy.enable {
    services.caddy.virtualHosts = {
      "${config.gum.services.caddy.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:3000
        '';
      };
    };
  };
}

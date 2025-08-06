{ config, lib, ... }:
{
  options.gum.services.website.enable = lib.options.mkEnableOption "sky-website";

  config = lib.mkIf config.gum.services.website.enable {
    services.caddy.virtualHosts = {
      "${config.gum.services.caddy.domain}" = {
        extraConfig = ''
          reverse_proxy localhost:3000
        '';
      };
    };
  };
}

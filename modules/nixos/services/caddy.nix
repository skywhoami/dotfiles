{
  self,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib)
    types
    mkIf
    mkOption
    mkDefault
    mkEnableOption
    ;
  cfg = config.gum.services.caddy;
in
{
  options = {
    gum.services.caddy = {
      enable = mkEnableOption "Enable Caddy web server.";

      domain = mkOption {
        type = types.str;
        default = "skylar.sh";
        description = "Domain to serve.";
      };
    };

    services.caddy.virtualHosts = mkOption {
      type = types.attrsOf (
        types.submodule (
          { config, ... }:
          {
            freeformType = types.attrsOf types.anything;
            options = {
              forceSSL = mkOption {
                type = types.bool;
                default = true;
                description = "Redirect HTTP to HTTPS (default true).";
              };
              enableACME = mkOption {
                type = types.bool;
                default = true;
                description = "Enable ACME for certificates (default true, Caddy default).";
              };
              useACMEHost = mkOption {
                type = types.str;
                default = cfg.domain;
                description = "ACME host for this vhost.";
              };
            };
          }
        )
      );
      default = { };
      description = "Caddy per-virtual-host configuration.";
    };
  };

  config = mkIf cfg.enable {
    sops.secrets.cloudflare-cert-api = {
      sopsFile = "${self}/secrets/services/cloudflare.yaml";
      key = "cert-api";
      owner = "caddy";
      group = "caddy";
    };

    networking = { inherit (cfg) domain; };

    security.acme = {
      acceptTerms = true;
      defaults.email = "hi" + "@" + "skylar" + "." + "sh";
    };

    users.users.caddy.extraGroups = [ "acme" ];

    services.caddy = {
      enable = true;
      email = "hi" + "@" + "skylar" + "." + "sh";
      package = pkgs.caddy.override { withCloudflareDNS = true; };
      configFile = pkgs.writeText "Caddyfile" ''
        {
          email hi@skylar.sh
        }

        ${cfg.domain}, *.${cfg.domain} {
          reverse_proxy 127.0.0.1:3000
          dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          header {
            Referrer-Policy "origin-when-cross-origin"
            X-Frame-Options "SAMEORIGIN"
            X-Content-Type-Options "nosniff"
          }
        }
      '';
      environment = {
        CLOUDFLARE_API_TOKEN = config.sops.secrets.cloudflare-cert-api.path;
      };
    };
  };
}

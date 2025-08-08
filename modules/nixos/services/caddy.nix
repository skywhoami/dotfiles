{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    types
    mkIf
    mkOption
    mkEnableOption
    ;
  cfg = config.sys.services.caddy;
in
{
  options = {
    sys.services.caddy = {
      enable = mkEnableOption "Enable Caddy web server.";

      domain = mkOption {
        type = types.str;
        default = "skylar.sh";
        description = "Domain to serve.";
      };
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
      certs.${cfg.domain} = {
        extraDomainNames = [ "*.${cfg.domain}" ];
        dnsProvider = "cloudflare";
        credentialsFile = config.sops.secrets.cloudflare-cert-api.path;
      };
    };

    users.users.caddy.extraGroups = [ "acme" ];

    services.caddy = {
      enable = true;
    };
  };
}

{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) str port;

  cfg = config.sys.services.pds;
in
{

  options.sys.services.pds = {
    enable = mkEnableOption "Enable PDS";

    hostname = mkOption {
      type = str;
      default = "bsky.subnetbabe.cloud";
    };

    port = mkOption {
      type = port;
      default = 3601;
    };
  };

  config = mkIf cfg.enable {
    sops.secrets.pds-env = {
      sopsFile = "${self}/secrets/services/pds.yaml";
      owner = "caddy";
      group = "caddy";
    };

    services = {
      pds = {
        enable = true;
        pdsadmin.enable = true;

        environmentFiles = [
          config.sops.secrets.pds-env.path
        ];

        settings = {
          PDS_PORT = cfg.port;
          PDS_HOSTNAME = cfg.hostname;
          PDS_CRAWLERS = "https://bsky.network";
        };
      };

      caddy.virtualHosts.${cfg.hostname} = {
        extraConfig = ''
          handle_path /xrpc/app.bsky.unspecced.getAgeAssuranceState {
            respond 200 {
              body `{
                "lastInitiatedAt": "2025-07-14T15:11:05.487Z",
                "status": "assured"
              }`
            }
            header {
              Access-Control-Allow-Headers "authorization,dpop,atproto-accept-labelers,atproto-proxy"
              Access-Control-Allow-Origin  "*"
              X-Frame-Options             "SAMEORIGIN"
              X-Content-Type-Options     "nosniff"
              Content-Type               "application/json"
            }
          }

          handle {
            reverse_proxy 127.0.0.1:${toString cfg.port}
          }
        '';
      };
    };
  };
}

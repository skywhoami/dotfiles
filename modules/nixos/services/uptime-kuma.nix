{ lib, config, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.types) str port;
  inherit (lib.options) mkEnableOption mkOption;

  cfg = config.sys.services.uptime-kuma;
in
{
  options.sys.services.uptime-kuma = {
    enable = mkEnableOption "Enable Uptime Kuma";

    domain = mkOption {
      type = str;
      default = "status.subnetbabe.cloud";
    };

    port = mkOption {
      type = port;
      default = 3060;
    };
  };

  config = mkIf cfg.enable {
    services = {
      uptime-kuma = {
        enable = true;

        settings = {
          HOST = cfg.host;
          PORT = toString cfg.port;
        };
      };

      caddy.virtualHosts.${cfg.domain} = {
        extraConfig = ''
          reverse_proxy localhost:${toString cfg.port}
        '';
      };
    };
  };
}

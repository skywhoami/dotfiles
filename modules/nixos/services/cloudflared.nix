{ self, config, ... }:
{
  config = {
    sops.secrets.cloudflared-cherry = {
      sopsFile = "${self}/secrets/services/cloudflared.yaml";
      key = "cherry";
    };

    services.cloudflared = {
      enable = true;
      tunnels.${config.networking.hostName} = {
        credentialsFile = config.sops.secrets.cloudflared-cherry.path;
        default = "http_status:404";
      };
    };
  };
}

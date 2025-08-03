{ config, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels.${config.networking.hostName} = {
      credentialsFile = "${config.sops.secrets.cloudflared.path}";
      default = "http_status:404";
    };
  };
}

{ self, config, ... }:
{
  config = {
    networking.domain = "skylar.sh";

    sops.secrets.cloudflare-cert-api = {
      sopsFile = "${self}/secrets/services/cloudflare.yaml";
      key = "cert-api";
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "hi" + "@" + "skylar" + "." + "sh";

      certs."skylar.sh" = {
        extraDomainNames = [ "*.skylar.sh" ];
        dnsProvider = "cloudflare";
        credentialsFile = config.sops.secrets.cloudflare-cert-api.path;
      };
    };

    services.caddy = {
      enable = true;
      email = "hi" + "@" + "skylar" + "." + "sh";
    };
  };
}

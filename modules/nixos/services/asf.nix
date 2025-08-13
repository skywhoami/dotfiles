{
  self,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.options) mkEnableOption;
in
{
  options.sys.services.asf.enable = mkEnableOption "Enable ASF";

  config = mkIf config.sys.services.asf.enable {
    sops.secrets.asf = {
      sopsFile = "${self}/secrets/services/asf.yaml";
      owner = "archisteamfarm";
      group = "archisteamfarm";
    };

    services.archisteamfarm = {
      enable = true;
      web-ui.enable = true;
      ipcSettings = {
        Kestrel = {
          Endpoints = {
            HTTP = {
              Url = "http://*:1242";
            };
          };
        };
      };
      ipcPasswordFile = config.sops.secrets.asf.path;
    };
  };
}

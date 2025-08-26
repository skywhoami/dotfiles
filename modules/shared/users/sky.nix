{
  lib,
  config,
  ...
}:
let
  inherit (lib) elem mkIf;
in
{
  config = mkIf (elem "sky" config.sys.users) {
    users.users.sky.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIyMCwBcRVn8QdhGrI/2PWY6g9cIFEGphXBG2T3FHg5"
    ];
  };
}

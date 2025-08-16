{
  lib,
  _class,
  config,
  ...
}:
let
  inherit (lib)
    mkDefault
    mergeAttrsList
    optionalAttrs
    genAttrs
    ;
in
{
  users.users = genAttrs config.sys.users (
    name:
    mergeAttrsList [
      { shell = "/run/current-system/sw/bin/zsh"; }

      (optionalAttrs (_class == "darwin") {
        home = "/Users/${name}";
      })

      (optionalAttrs (_class == "nixos") {
        home = "/home/${name}";
        uid = mkDefault 1000;
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "nix"
        ]
        ++ (if config.sys.services.docker.enable then [ "docker" ] else [ ]);
      })
    ]
  );
}

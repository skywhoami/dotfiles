{
  lib,
  config,
  self,
  self',
  inputs,
  inputs',
  ...
}:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";

    extraSpecialArgs = {
      inherit
        self
        self'
        inputs
        inputs'
        ;
    };

    users = lib.genAttrs config.gum.users (name: {
      imports = [ ./${name} ];
    });

    sharedModules = [ (self + /modules/home/default.nix) ];
  };
}

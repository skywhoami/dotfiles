{
  lib,
  self,
  self',
  config,
  inputs,
  inputs',
  ...
}:
{
  users.users.sky.home = "/Users/sky";
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

    users = {
      sky = ./sky;
    };

    sharedModules = [ (self + /modules/home/default.nix) ];
  };
}

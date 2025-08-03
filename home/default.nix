{
  self,
  self',
  inputs,
  inputs',
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  users.users.sky.home = if isDarwin then "/Users/sky" else "/home/sky";
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

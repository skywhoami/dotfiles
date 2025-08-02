{
  self,
  self',
  inputs,
  inputs',
  _class,
  ...
}:
{
  users.users.sky.isNormalUser = true;
  users.users.sky.home = if _class == "darwin" then "/Users/sky" else "/home/sky";
  users.users.sky.extraGroups = ["wheel"];
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

{ inputs, self, ... }:
{
  users.users.sky.home = "/Users/sky";
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";

    extraSpecialArgs = { inherit inputs; };

    sharedModules = [
      {
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
      }
      (self + /modules/home/default.nix)
    ];

    users.sky = ./sky;
  };
}

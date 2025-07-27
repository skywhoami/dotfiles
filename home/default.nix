{ inputs, pkgs, ... }:
{
  users.users = {
    sky = {
      home = "/Users/sky";
      shell = pkgs.zsh;
    };
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    extraSpecialArgs = { inherit inputs; };

    sharedModules = [
      {
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
      }
    ];

    backupFileExtension = "bak";

    users.sky = ./sky;
  };
}

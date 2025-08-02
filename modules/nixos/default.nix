{ inputs, ... }:
{
  _class = "nixos";

  imports = [
    ../base
    ./environment
    inputs.home-manager.nixosModules.home-manager
    ./hardware
    ./headless.nix
    ./networking
    ./security
  ];
}

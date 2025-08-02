{ inputs, ... }:
{
  _class = "nixos";

  imports = [
    ../base
    ./boot.nix
    ./environment
    inputs.home-manager.nixosModules.home-manager
    ./hardware
    ./headless.nix
    ./networking
    ./security
  ];
}

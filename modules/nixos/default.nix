{ inputs, ... }:
{
  _class = "nixos";

  imports = [
    ../base
    inputs.home-manager.nixosModules.home-manager
  ];
}

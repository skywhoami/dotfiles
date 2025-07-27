{ pkgs, inputs, ... }:
{
  home.username = "sky";
  home.homeDirectory = "/Users/sky";
  programs.home-manager.enable = true;

  imports = [
    ./packages
    ./catppuccin.nix
  ];
}

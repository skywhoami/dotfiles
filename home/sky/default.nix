{ pkgs, _class, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  home.username = "sky";
  home.homeDirectory = if isDarwin then "/Users/sky" else "/home/sky";
  home.stateVersion = "25.05";
  home.file.".hushlogin".text = "";

  imports = [
    ./packages
    ./catppuccin.nix
    ./yabai.nix
    ./system
  ];
}

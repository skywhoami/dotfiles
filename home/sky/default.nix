{ _class, ... }:
{
  home.username = "sky";
  home.homeDirectory = if _class == "darwin" then "/Users/sky" else "/home/sky";
  home.stateVersion = "25.05";
  home.file.".hushlogin".text = "";

  imports = [
    ./packages
    ./catppuccin.nix
    ./yabai.nix
    ./system
  ];
}

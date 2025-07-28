{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "lavender";
    nvim.enable = false;
  };
}

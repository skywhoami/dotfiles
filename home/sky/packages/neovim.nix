{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      catppuccin-nvim
      nvim-cmp
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      conform-nvim
      cord-nvim
      gitsigns-nvim
      lualine-nvim
      mason-nvim
      mason-lspconfig-nvim
      mini-nvim
      nvim-lspconfig
      nvim-navic
      nvim-tree-lua
      nvim-treesitter
      plenary-nvim
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      which-key-nvim
    ];
  };
  home.file = {
    ".vimrc".text = builtins.readFile ./neovim/.vimrc;
  };

  xdg.configFile."nvim" = {
    source = ./neovim;
    recursive = true;
  };
}

{ lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
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

    extraLuaConfig = builtins.readFile ./config/init.lua;

  };
  home.file = {
    ".vimrc".text = builtins.readFile ./config/.vimrc;
    ".config/nvim/lua/plugins/cmp.lua".text = builtins.readFile ./config/cmp.lua;
    ".config/nvim/lua/plugins/conform.lua".text = builtins.readFile ./config/conform.lua;
    ".config/nvim/lua/plugins/discord.lua".text = builtins.readFile ./config/discord.lua;
    ".config/nvim/lua/plugins/freeze.lua".text = builtins.readFile ./config/freeze.lua;
    ".config/nvim/lua/plugins/git.lua".text = builtins.readFile ./config/git.lua;
    ".config/nvim/lua/plugins/lsp.lua".text = builtins.readFile ./config/lsp.lua;
    ".config/nvim/lua/plugins/lualine.lua".text = builtins.readFile ./config/lualine.lua;
    ".config/nvim/lua/plugins/mini.lua".text = builtins.readFile ./config/mini.lua;
    ".config/nvim/lua/plugins/telescope.lua".text = builtins.readFile ./config/telescope.lua;
    ".config/nvim/lua/plugins/theme.lua".text = builtins.readFile ./config/theme.lua;
    ".config/nvim/lua/plugins/tree.lua".text = builtins.readFile ./config/tree.lua;
    ".config/nvim/lua/plugins/ts.lua".text = builtins.readFile ./config/ts.lua;
    ".config/nvim/lua/plugins/which-key.lua".text = builtins.readFile ./config/which-key.lua;
  };
}

{ pkgs, config, ... }:
{
  programs.neovim = {
    inherit (config.profiles.graphical) enable;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
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
      plenary-nvim
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      which-key-nvim
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          nix
          bash
          css
          html
          javascript
          typescript
          json
          lua
          dockerfile
          vue
          yaml
        ]
      ))
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      vim.cmd("colorscheme catppuccin")
    '';
  };

  home.file = {
    ".vimrc".text = builtins.readFile ./.vimrc;
  };
}

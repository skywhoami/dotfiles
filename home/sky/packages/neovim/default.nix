{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
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
          astro
        ]
      ))
    ];
    extraPackages = with pkgs; [
      ripgrep
      nil
      vtsls
      vue-language-server
      docker-language-server
      docker-compose-language-service
      yaml-language-server
      bash-language-server
      lua-language-server
      astro-language-server
      tailwindcss-language-server
      emmet-language-server
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

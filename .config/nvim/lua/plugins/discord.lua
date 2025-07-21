return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  opts = {
    editor = {
      icon = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp",
    },
    display = {
      theme = "catppuccin",
      flavor = "accent",
      swap_icons = true,
    },
  },
}

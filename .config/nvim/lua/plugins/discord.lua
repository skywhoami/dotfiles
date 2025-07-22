return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  opts = {
    editor = {
      tooltip = "Neovim",
      icon = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp",
    },
    display = {
      theme = "catppuccin",
      flavor = "accent",
    },
    text = {
      file_browser = true,
      workspace = "Working on ${workspace}",
    },
    variables = true,
  },
}

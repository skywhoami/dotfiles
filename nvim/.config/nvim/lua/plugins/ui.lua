return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "rose-pine"
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup {
        plugins = {
          spelling = { enabled = true },
          presets = { operators = false },
        },
        win = {
          border = "rounded",
          padding = { 2, 2, 2, 2 },
        },
      }
    end,
  },
}

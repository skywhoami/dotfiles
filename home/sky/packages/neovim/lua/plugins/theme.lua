return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      transparent_background = true,
    })

    vim.cmd("colorscheme catppuccin")
  end,
}

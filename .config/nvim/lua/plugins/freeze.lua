return {
  "charm-and-friends/freeze.nvim",
  config = function()
    require("freeze").setup({
      command = "freeze",
      open = true,
      output = function()
        return "./" .. os.date("%Y-%m-%d") .. "_freeze.png"
      end,
      show_line_numbers = true,
      theme = "catppuccin-mocha",
    })

    vim.api.nvim_set_keymap("v", "<leader>sc", "<cmd>Freeze<cr>", {})
  end,
}

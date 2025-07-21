return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  config = function()
    require("nvim-tree").setup({
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = false,
            modified = true,
          },
        },
      },
      view = {
        width = 30,
        side = "left",
        hide_root_folder = false,
      },
      disable_netrw = true,
      hijack_netrw = true,
      update_focused_file = { enable = true },
      filters = { dotfiles = false },
      git = { enable = false },
    })

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>fe", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })
  end,
}

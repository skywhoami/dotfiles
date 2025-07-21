return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

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
        side = "right",
      },
      disable_netrw = true,
      hijack_netrw = true,
      update_focused_file = { enable = true },
      filters = { dotfiles = false },
      git = { enable = false },
    })

    vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })
  end,
}

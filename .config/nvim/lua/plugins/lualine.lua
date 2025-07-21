return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  config = function()
    require("nvim-navic").setup({
      lsp = { auto_attach = true },
      separator = " › ",
      highlight = true,
    })
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        component_separators = "",
        section_separators = "",
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          { "branch" },
          "diff",
        },
        lualine_c = { { "filename", path = 1, shorting_target = 40 } },
        lualine_x = { "diagnostics" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {
        lualine_c = {
          {
            "navic",
            cond = function()
              return require("nvim-navic").is_available()
            end,
          },
        },
      },
      inactive_winbar = {},
      extensions = {},
    })
    vim.opt.showmode = false
  end,
}

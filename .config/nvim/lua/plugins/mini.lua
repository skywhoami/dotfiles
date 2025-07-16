return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.pairs").setup()

    require("mini.notify").setup({
      window = {
        winblend = 0,
        lsp_progress = {
          enable = true,
        },
      },
    })

    require("mini.move").setup({
      mappings = {
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
      options = {
        reindent_linewise = true,
      },
    })

    require("mini.comment").setup({
      options = {
        custom_commentstring = nil,
        ignore_blank_line = false,
        start_of_line = false,
        pad_comment_parts = true,
      },
      mappings = {
        comment = "gc",
        comment_line = "gcc",
      },
    })
  end,
}

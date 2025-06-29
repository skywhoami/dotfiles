return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      },

      sources = cmp.config.sources({
        { name = "copilot" },
        {
          name = "nvim_lsp",
          ---@param entry cmp.Entry
          ---@param ctx cmp.Context
          entry_filter = function(entry, ctx)
            if ctx.filetype ~= "vue" then
              return true
            end

            local cursor_before_line = ctx.cursor_before_line
            if cursor_before_line:sub(-1) == "@" then
              return entry.completion_item.label:match("^@")
            elseif cursor_before_line:sub(-1) == ":" then
              return entry.completion_item.label:match("^:")
                and not entry.completion_item.label:match("^:on%-")
            else
              return true
            end
          end,
        },
        { name = "buffer" },
        { name = "path" },
      }),

      formatting = {
        format = function(entry, item)
          item.menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            path = "[Path]",
            copilot = "[Copilot]",
          })[entry.source.name]
          return item
        end,
      },
    })

    cmp.event:on("menu_closed", function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.b[bufnr]._vue_ts_cached_is_in_start_tag = nil
    end)
  end,
}

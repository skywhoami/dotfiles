return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua" },
        ts = { "prettier", "prettierd" },
        tsx = { "prettier", "prettierd" },
        js = { "prettier", "prettierd" },
        jsx = { "prettier", "prettierd" },
        swift = { "swift_format" },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    }
  end,
}

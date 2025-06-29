return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")

    mason.setup()
    mason_lsp.setup({
      ensure_installed = {
        "dockerfile-language-server",
        "vtsls",
        "vue-language-server",
        "bash-language-server",
        "css-lsp",
        "docker-compose-language-service",
        "json-lsp",
        "lua-language-server",
        "yaml-language-server",
      },
    })

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "if_many",
        header = "",
        prefix = "",
      },
    })

    lspconfig["yamlls"].setup({
      settings = {
        yaml = {
          schemas = {
            ["https://www.schemastore.org/github-workflow.json"] = ".github/workflows/*",
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",
          },
        },
      },
    })

    lspconfig["jsonls"].setup({
      settings = {
        json = {
          schemas = {
            {
              fileMatch = { "package.json" },
              url = "https://www.schemastore.org/package.json",
            },
            {
              fileMatch = { "tsconfig*.json" },
              url = "https://www.schemastore.org/tsconfig.json",
            },
          },
        },
      },
    })

    lspconfig["lua_ls"].setup({
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
  end,
}

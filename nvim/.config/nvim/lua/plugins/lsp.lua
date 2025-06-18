return {
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require "mason-lspconfig"

      mason_lspconfig.setup {
        ensure_installed = {
          "ts_ls",
          "yamlls",
          "jsonls",
          "bashls",
          "lua_ls",
          "dockerls",
        },
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require "lspconfig"

      for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
        if server_name == "yamlls" then
          lspconfig.yamlls.setup {
            capabilities = capabilities,
            settings = {
              yaml = {
                schemas = {
                  ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                },
              },
            },
          }
        elseif server_name == "jsonls" then
          lspconfig.jsonls.setup {
            capabilities = capabilities,
            settings = {
              json = {
                schemas = {
                  {
                    fileMatch = { "package.json" },
                    url = "https://json.schemastore.org/package.json",
                  },
                  {
                    fileMatch = { "tsconfig*.json" },
                    url = "https://json.schemastore.org/tsconfig.json",
                  },
                  {
                    fileMatch = { ".prettierrc.json", ".prettierrc" },
                    url = "https://json.schemastore.org/prettierrc.json",
                  },
                },
              },
            },
          }
        else
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "bash",
          "css",
          "git_config",
          "gitattributes",
          "go",
          "json",
          "jsdoc",
          "lua",
          "make",
          "markdown_inline",
          "markdown",
          "nginx",
          "sql",
          "swift",
          "tmux",
          "tsx",
          "typescript",
          "vue",
          "vim",
          "yaml",
          "javascript",
        },
        sync_install = true,
        highlight = { enable = true },
      }
    end,
  },
}

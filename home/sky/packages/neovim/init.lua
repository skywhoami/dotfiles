vim.cmd("source ~/.vimrc")

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
  },

  sources = cmp.config.sources({
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
      })[entry.source.name]
      return item
    end,
  },
})

cmp.event:on("menu_closed", function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.b[bufnr]._vue_ts_cached_is_in_start_tag = nil
end)

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    vue = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ timeout_ms = 500, lsp_format = "fallback" })
end, { desc = "Format buffer or selection" })

require("cord").setup({
  editor = {
    tooltip = "Neovim",
    icon = "https://raw.githubusercontent.com/IogaMaster/neovim/main/.github/assets/nixvim-dark.webp",
  },
  display = {
    theme = "catppuccin",
    flavor = "accent",
  },
  text = {
    file_browser = true,
    workspace = "Working on ${workspace}",
  },
  variables = true,
})

require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 100,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%d-%m-%Y> - <summary>",
})

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

local vue_language_server_path = vim.fn.stdpath("data")
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = { "typescript", "javascript", "vue" },
}

local vue_ls_config = {
  on_init = function(client)
    client.handlers["tsserver/request"] = function(_, result, context)
      local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
      if #clients == 0 then
        vim.notify(
          "Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
          vim.log.levels.ERROR
        )
        return
      end
      local ts_client = clients[1]

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = "typescript.tsserverRequest",
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response_data = { { id, r.body } }
        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify("tsserver/response", response_data)
      end)
    end
  end,
}

vim.lsp.config("vtsls", vtsls_config)
vim.lsp.config("vue_ls", vue_ls_config)
vim.lsp.enable({ "vtsls", "vue_ls" })

mason.setup()
mason_lsp.setup({
  ensure_installed = {
    "dockerls",
    "docker_compose_language_service",
    "vtsls",
    "vue_ls",
    "bashls",
    "cssls",
    "jsonls",
    "lua_ls",
    "yamlls",
    "tailwindcss",
    "just",
    "nil_ls",
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  max_width = 80,
})

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set(
  "n",
  "K",
  vim.lsp.buf.hover,
  { noremap = true, silent = true, desc = "LSP Hover Documentation" }
)

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
    component_separators = "",
    section_separators = "",
    always_divide_middle = true,
    ignore_focus = { "NvimTree" },
    disabled_filetypes = {
      statusline = { "NvimTree" },
      winbar = { "NvimTree" },
    },
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
vim.o.cmdheight = 0
vim.o.laststatus = 3

require("mini.pairs").setup()

require("mini.notify").setup({
  window = {
    winblend = 0,
    lsp_progress = {
      enable = true,
    },
  },
})

vim.notify = require("mini.notify").make_notify()
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "" or vim.bo[args.buf].buftype ~= "" then
      return
    end

    local fn = vim.fn.fnamemodify(args.file, ":t")
    vim.notify("Saved " .. fn, vim.log.levels.INFO, { title = "File Written" })
  end,
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

require("mini.surround").setup({
  mappings = {
    add = "S", -- Add surrounding in Normal and Visual modes
    delete = "ds", -- Delete surrounding
    find = "sf", -- Find surrounding (to the right)
    find_left = "sF", -- Find surrounding (to the left)
    highlight = "sh", -- Highlight surrounding
    replace = "cs", -- Replace surrounding
  },
})

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "bun.lock" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap(
  "n",
  "<leader>ff",
  "<cmd>lua require('telescope.builtin').find_files()<CR>",
  opts
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fg",
  "<cmd>lua require('telescope.builtin').live_grep()<CR>",
  opts
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fl",
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
  opts
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fr",
  "<cmd>lua require('telescope.builtin').lsp_references()<CR>",
  opts
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fd",
  "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>",
  opts
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>ft",
  "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>",
  opts
)
vim.api.nvim_set_keymap("n", "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>Telescope lsp_document_symbols<CR>", opts)

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

require("nvim-treesitter.configs").setup({
  highlight = { enable = true, additional_vim_regex_highlighting = true },
  indent = { enable = true },
})

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

require("catppuccin").setup({
  flavour = "frappe",
  transparent_background = true,
})

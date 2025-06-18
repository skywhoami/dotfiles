return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local action_layout = require "telescope.actions.layout"

    telescope.setup {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_ignore_patterns = {
          "node_modules/.*",
          "secret.d/.*",
          "%.pem",
          ".DS_Store",
          "%.git/",
          "%.svn/",
          "%.hg/",
          "CVS/",
          ".next/",
          ".nuxt/",
          "dist/",
          "build/",
          "target/",
          "%.o",
          "%.a",
          "%.out",
          "%.class",
          "%.pdf",
          "%.mkv",
          "%.mp4",
          "%.zip",
        },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            ["<C-w>"] = { "<c-s-w>", type = "command" },
            ["<C-r><C-w>"] = actions.insert_symbol,
            ["<C-r><C-a>"] = actions.insert_symbol,
            ["<C-r><C-f>"] = actions.insert_symbol,
            ["<C-r><C-l>"] = actions.insert_symbol,
            ["<M-p>"] = action_layout.toggle_preview,
            ["<M-m>"] = action_layout.toggle_mirror,
          },
          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["?"] = actions.which_key,
            ["<M-p>"] = action_layout.toggle_preview,
            ["<M-m>"] = action_layout.toggle_mirror,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
          sort_mru = true,
        },
        live_grep = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
        grep_string = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          theme = "ivy",
          mappings = {
            ["i"] = {
              ["<A-c>"] = require("telescope._extensions.file_browser.actions").create,
              ["<S-CR>"] = require("telescope._extensions.file_browser.actions").create_from_prompt,
              ["<A-r>"] = require("telescope._extensions.file_browser.actions").rename,
              ["<A-m>"] = require("telescope._extensions.file_browser.actions").move,
              ["<A-y>"] = require("telescope._extensions.file_browser.actions").copy,
              ["<A-d>"] = require("telescope._extensions.file_browser.actions").remove,
              ["<C-o>"] = require("telescope._extensions.file_browser.actions").open,
              ["<C-g>"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
              ["<C-e>"] = require("telescope._extensions.file_browser.actions").goto_home_dir,
              ["<C-w>"] = require("telescope._extensions.file_browser.actions").goto_cwd,
              ["<C-t>"] = require("telescope._extensions.file_browser.actions").change_cwd,
              ["<C-f>"] = require("telescope._extensions.file_browser.actions").toggle_browser,
              ["<C-h>"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
              ["<C-s>"] = require("telescope._extensions.file_browser.actions").toggle_all,
            },
            ["n"] = {
              ["c"] = require("telescope._extensions.file_browser.actions").create,
              ["r"] = require("telescope._extensions.file_browser.actions").rename,
              ["m"] = require("telescope._extensions.file_browser.actions").move,
              ["y"] = require("telescope._extensions.file_browser.actions").copy,
              ["d"] = require("telescope._extensions.file_browser.actions").remove,
              ["o"] = require("telescope._extensions.file_browser.actions").open,
              ["g"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
              ["e"] = require("telescope._extensions.file_browser.actions").goto_home_dir,
              ["w"] = require("telescope._extensions.file_browser.actions").goto_cwd,
              ["t"] = require("telescope._extensions.file_browser.actions").change_cwd,
              ["f"] = require("telescope._extensions.file_browser.actions").toggle_browser,
              ["h"] = require("telescope._extensions.file_browser.actions").toggle_hidden,
              ["s"] = require("telescope._extensions.file_browser.actions").toggle_all,
            },
          },
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt { postfix = " --iglob " },
            },
          },
        },
      },
    }

    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "file_browser")
    pcall(telescope.load_extension, "live_grep_args")

    local builtin = require "telescope.builtin"

    vim.keymap.set("n", "<leader>fb", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = "Fuzzy find in current buffer" })

    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files {
        hidden = true,
      }
    end, { desc = "Find files" })

    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set(
      "n",
      "<leader>fG",
      ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
      { desc = "Live grep with args" }
    )
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
    vim.keymap.set("n", "<leader>ft", builtin.help_tags, { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
    vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
    vim.keymap.set("n", "<leader>fh", builtin.command_history, { desc = "Command history" })
    vim.keymap.set("n", "<leader>fs", builtin.search_history, { desc = "Search history" })
    vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Marks" })
    vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Quickfix" })
    vim.keymap.set("n", "<leader>fl", builtin.loclist, { desc = "Location list" })
    vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Jumplist" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Treesitter" })
    vim.keymap.set("n", "<leader>fp", builtin.planets, { desc = "Planets" })
    vim.keymap.set("n", "<leader>fi", builtin.builtin, { desc = "Builtin pickers" })

    -- LSP pickers
    vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "LSP references" })
    vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "LSP definitions" })
    vim.keymap.set("n", "gD", builtin.lsp_type_definitions, { desc = "LSP type definitions" })
    vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "LSP implementations" })
    vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "LSP document symbols" })
    vim.keymap.set("n", "<leader>lS", builtin.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
    vim.keymap.set("n", "<leader>ld", builtin.lsp_dynamic_workspace_symbols, { desc = "LSP dynamic workspace symbols" })

    -- Additional useful pickers
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep string under cursor" })
    vim.keymap.set("v", "<leader>fw", builtin.grep_string, { desc = "Grep selected text" })
    vim.keymap.set("n", "<leader>fW", function()
      builtin.grep_string { search = vim.fn.input "Grep > " }
    end, { desc = "Grep input string" })

    vim.keymap.set("n", "<leader>f/", function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      }
    end, { desc = "Live grep in open files" })
  end,
}

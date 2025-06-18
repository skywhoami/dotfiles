return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup {
        n_lines = 500,
        custom_textobjects = {
          o = require("mini.ai").gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          d = { "%f[%d]%d+" },
          e = {
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line "$",
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      }

      require("mini.surround").setup {
        mappings = {
          add = "gsa", -- Add surrounding in Normal and Visual modes
          delete = "gsd", -- Delete surrounding
          find = "gsf", -- Find surrounding (to the right)
          find_left = "gsF", -- Find surrounding (to the left)
          highlight = "gsh", -- Highlight surrounding
          replace = "gsr", -- Replace surrounding
          update_n_lines = "gsn", -- Update `n_lines`
        },
      }

      require("mini.animate").setup {
        cursor = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear { duration = 100, unit = "total" },
        },
        scroll = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear { duration = 150, unit = "total" },
        },
        resize = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear { duration = 100, unit = "total" },
        },
        open = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear { duration = 150, unit = "total" },
        },
        close = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear { duration = 150, unit = "total" },
        },
      }

      require("mini.move").setup {
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
      }

      require("mini.bracketed").setup()

      require("mini.align").setup()

      require("mini.pairs").setup()

      require("mini.comment").setup()

      require("mini.pick").setup {
        window = {
          config = {
            width = math.floor(0.8 * vim.o.columns),
            height = math.floor(0.8 * vim.o.lines),
          },
        },
      }

      require("mini.splitjoin").setup {
        mappings = {
          toggle = "gS",
        },
      }

      require("mini.cursorword").setup()

      require("mini.hipatterns").setup {
        highlighters = {
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        },
      }
    end,
  },
}

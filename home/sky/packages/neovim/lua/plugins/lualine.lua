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
	end,
}

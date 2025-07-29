return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"css",
				"dockerfile",
				"javascript",
				"json",
				"lua",
				"typescript",
				"vue",
				"yaml",
			},
			highlight = { enable = true, additional_vim_regex_highlighting = true },
		})
	end,
}

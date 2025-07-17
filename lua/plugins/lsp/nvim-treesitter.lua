return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"html",
				"css",
				"javascript",
				"typescript",
				"python",
				"go",
				"gomod",
				"gowork",
				"gosum",
				"svelte",
				"markdown",
				"java",
				"latex",
			},
			
			sync_install = true,
			highlight = { enable = true, disable = { "html" } },
			indent = { enable = true },
		})
	end,
}

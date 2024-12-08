return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		--load colorscheme
		vim.cmd([[colorscheme kanagawa-dragon]])
	end,
}

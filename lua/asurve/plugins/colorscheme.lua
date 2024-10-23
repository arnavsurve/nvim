return {
	{
		"bluz71/vim-moonfly-colors",
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			--load colorscheme
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},

	{
		"projekt0n/github-nvim-theme",
	},
}

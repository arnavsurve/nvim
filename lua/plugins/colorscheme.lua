return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme kanagawa-dragon]])
		end,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
	},
	{
		"vague2k/vague.nvim",
		name = "vague",
		lazy = false,
	},
}

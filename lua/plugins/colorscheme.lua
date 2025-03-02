return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
	},

	{
		"sainnhe/edge",
		lazy = false,
	},

	{
		"d00h/nvim-rusticated",
		lazy = false,
	},

	{
		"rose-pine/neovim",
		name = "rosepine",
		lazy = false,
	},

	{
		"savq/melange-nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme melange]])
		end,
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
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

return {
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
	},

	{
		"deparr/tairiki.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tairiki-dark]])
		end,
	},

	{
		"sainnhe/edge",
		lazy = true,
	},

	{
		"d00h/nvim-rusticated",
		lazy = true,
	},

	{
		"rose-pine/neovim",
		name = "rosepine",
		lazy = true,
	},

	{
		"savq/melange-nvim",
		lazy = true,
		priority = 1000,
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},

	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = true,
	},

	{
		"vague2k/vague.nvim",
		name = "vague",
		lazy = true,
	},

	{
		"rockyzhang24/arctic.nvim",
		branch = "v2",
		dependencies = { "rktjmp/lush.nvim" },
		lazy = true,
	},

	{
		"Mofiqul/vscode.nvim",
		lazy = true,
	},
}

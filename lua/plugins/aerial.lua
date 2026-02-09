return {
	"stevearc/aerial.nvim",
	opts = {
		layout = {
			min_width = 60,
		},
		filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Function",
			"Interface",
			"Method",
			"Struct",
		},
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
}

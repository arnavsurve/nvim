return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = "│",
			highlight = { "IblIndent" },
		},
		scope = {
			enabled = true,
			char = "│",
			highlight = { "IblScope" },
		},
	},
	config = function(_, opts)
		vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2a2a" })
		vim.api.nvim_set_hl(0, "IblScope", { fg = "#7c7c7c" })
		require("ibl").setup(opts)
	end,
}

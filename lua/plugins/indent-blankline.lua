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
	},
	config = function(_, opts)
		vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2a2a" })
		require("ibl").setup(opts)
	end,
}

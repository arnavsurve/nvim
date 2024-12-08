return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- Python formatters
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,

				-- Python linters
				null_ls.builtins.diagnostics.pylint,
				null_ls.builtins.diagnostics.mypy,

				-- Prettier
				null_ls.builtins.formatting.prettier,
			},
		})
	end,
}

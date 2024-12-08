return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black", "isort" },
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			java = { "google-java-format" },
			go = { "gofumpt" },
		},

		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}

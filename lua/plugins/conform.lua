return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			css = { "prettier" },
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			kotlin = { "ktlint" },
			java = { "google-java-format" },
			go = { "gofumpt" },
		},

		format_on_save = {
			timeout_ms = 3000,
			lsp_fallback = true,
		},
	},
}

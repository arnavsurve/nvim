return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls",
				"pyright",
				"html",
				"cssls",
				"tailwindcss",
				"ts_ls",
				"gopls",
				"jdtls",
				"clangd",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"black", -- python formatter
				"isort", -- python formatter
				"pylint", -- python linter
				"mypy", -- python type checker
				"prettier", -- html, css, js formatter
				"eslint", -- js linter
				"golangci-lint", -- go linter
				"google-java-format", -- java formatter
			},
		})
	end,
}

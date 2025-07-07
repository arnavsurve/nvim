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
				"pyright",  -- Keep only pyright for Python
				"html",
				"cssls",
				"emmet_ls",
				"tailwindcss",
				"ts_ls",
				"gopls",
				"jdtls",
				"clangd",
			},
			-- Enable automatic installation
			automatic_installation = true,
			-- Automatically enable installed servers (this replaces the setup_handlers approach)
			automatic_enable = true,
		})

		-- Configure LSP servers in lspconfig.lua
		-- The on_attach and capabilities are exported as global variables

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"black", -- python formatter
				"isort", -- python formatter
				"mypy", -- python type checker
				"prettier", -- html, css, js formatter
				"eslint", -- js linter
				"golangci-lint", -- go linter
				"google-java-format", -- java formatter
				"cpptools", -- cpp DAP
				"codelldb", -- native lldb debugger
			},
		})
	end,
}

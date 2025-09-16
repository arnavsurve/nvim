return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
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
				"terraformls",
			},
			-- Enable automatic installation
			automatic_installation = true,
		})

		-- Setup servers without handlers (compatibility)
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local servers = {
			"lua_ls",
			"pyright",
			"html",
			"cssls",
			"emmet_ls",
			"tailwindcss",
			"ts_ls",
			"gopls",
			"clangd",
			"terraformls",
		}

		for _, server in ipairs(servers) do
			local server_opts = { capabilities = capabilities }

			if server == "lua_ls" then
				server_opts.settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
						telemetry = { enable = false },
					},
				}
			elseif server == "ts_ls" then
				server_opts.filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "mdx" }
			elseif server == "gopls" then
				server_opts.filetypes = { "go", "gomod" }
			elseif server == "terraformls" then
				server_opts.filetypes = { "terraform", "tf", "tfvars", "hcl" }
			elseif server == "eslint" then
				server_opts.filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
			elseif server == "pyright" then
				server_opts.settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							diagnosticMode = "openFilesOnly",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				}
			end

			lspconfig[server].setup(server_opts)
		end

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
				"gofumpt", -- go formatter used by conform
				"cpptools", -- cpp DAP
				"codelldb", -- native lldb debugger
			},
		})
	end,
}

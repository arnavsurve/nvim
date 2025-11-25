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
				"eslint",
				"gopls",
				"jdtls",
				"clangd",
				"kotlin_language_server",
				"terraformls",
			},
			-- Enable automatic installation
			automatic_installation = true,
			automatic_enable = false,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local servers = {
			"lua_ls",
			"pyright",
			"html",
			"cssls",
			"emmet_ls",
			"tailwindcss",
			"ts_ls",
			"eslint",
			"gopls",
			"clangd",
			"kotlin_language_server",
			"terraformls",
		}

		local overrides = {
			lua_ls = {
				settings = {
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
				},
			},
			eslint = {
				settings = {
					format = false, -- Use Prettier for formatting via conform.nvim
					workingDirectories = { mode = "auto" },
				},
				on_attach = function(client, bufnr)
					-- Create the EslintFixAll command
					vim.api.nvim_buf_create_user_command(bufnr, "EslintFixAll", function()
						vim.lsp.buf.code_action({
							context = {
								only = { "source.fixAll.eslint" },
								diagnostics = {},
							},
							apply = true,
						})
					end, { desc = "Fix all ESLint problems" })

					-- Auto-fix on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.code_action({
								context = {
									only = { "source.fixAll.eslint" },
									diagnostics = {},
								},
								apply = true,
							})
						end,
					})
				end,
			},
			pyright = {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							diagnosticMode = "openFilesOnly",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			},
			ts_ls = {
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "mdx" },
			},
			gopls = {
				filetypes = { "go", "gomod" },
			},
			terraformls = {
				filetypes = { "terraform", "tf", "tfvars", "hcl" },
			},
		}

		for _, server in ipairs(servers) do
			local server_opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, overrides[server] or {})
			vim.lsp.config(server, server_opts)
			vim.lsp.enable(server)
		end


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
				"kotlin-language-server", -- kotlin LSP
				"ktlint", -- kotlin formatter
				"delve", -- go debugger
				"java-debug-adapter", -- java debug adapter (jdtls bundles)
				"java-test", -- java test adapter (jdtls bundles)
				"cpptools", -- cpp DAP
				"codelldb", -- native lldb debugger
			},
		})
	end,
}

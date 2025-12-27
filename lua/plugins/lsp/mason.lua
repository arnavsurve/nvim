return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

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
			ensure_installed = {
				"lua_ls",
				"basedpyright",
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
				"yamlls",
			},
			automatic_installation = true,
			automatic_enable = false,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local servers = {
			"lua_ls",
			"basedpyright",
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
			"yamlls",
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
					experimental = { useFlatConfig = true }, -- Set to false if using .eslintrc
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

					-- Auto-fix on save (augroup prevents duplicates on LspRestart)
					local group = vim.api.nvim_create_augroup("EslintFixOnSave" .. bufnr, { clear = true })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = group,
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
			basedpyright = {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "standard",
							diagnosticMode = "workspace",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticSeverityOverrides = {
								reportUnusedImport = "warning",
								reportUnusedVariable = "warning",
								reportDuplicateImport = "warning",
							},
						},
					},
				},
			},
			ts_ls = {
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "mdx" },
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						suggest = {
							completeFunctionCalls = true,
							autoImports = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
						suggest = {
							completeFunctionCalls = true,
							autoImports = true,
						},
					},
				},
			},
			gopls = {
				filetypes = { "go", "gomod" },
			},
			terraformls = {
				filetypes = { "terraform", "tf", "tfvars", "hcl" },
			},
			yamlls = {
				settings = {
					yaml = {
						schemas = {
							kubernetes = "*.yaml",
						},
						format = {
							enable = true,
						},
						validate = true,
						completion = true,
					},
				},
			},
		}

		for _, server in ipairs(servers) do
			local server_opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, overrides[server] or {})
			vim.lsp.config(server, server_opts)
			vim.lsp.enable(server)
		end

		-- SourceKit-LSP for Swift (not managed by Mason, comes with Swift toolchain)
		vim.lsp.config("sourcekit", {
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}),
			filetypes = { "swift", "objective-c", "objective-cpp" },
		})
		vim.lsp.enable("sourcekit")

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"black",
				"isort",
				"ruff",
				"mypy",
				"debugpy",
				"prettier",
				"eslint",
				"golangci-lint",
				"google-java-format",
				"gofumpt",
				"kotlin-language-server",
				"ktlint",
				"delve",
				"java-debug-adapter",
				"java-test",
				"cpptools",
				"codelldb",
			},
		})
	end,
}

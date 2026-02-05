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
				"biome",
				"gopls",
				"jdtls",
				"clangd",
				"kotlin_language_server",
				"terraformls",
				"yamlls",
				"rust_analyzer",
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
			"biome",
			"gopls",
			"clangd",
			"kotlin_language_server",
			"terraformls",
			"yamlls",
			-- rust_analyzer excluded: managed by rustaceanvim
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
			biome = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"json",
					"jsonc",
					"css",
				},
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
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = capabilities,
				flags = { debounce_text_changes = 150 },
			}, overrides[server] or {})
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

		-- tsgo: native Go-based TypeScript server (not managed by Mason)
		-- Install: npm install --global @typescript/native-preview
		vim.lsp.config("tsgo", {
			cmd = { "tsgo", "--lsp", "--stdio" },
			capabilities = capabilities,
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
			root_markers = {
				"tsconfig.json",
				"jsconfig.json",
				"package.json",
				"tsconfig.base.json",
				".git",
			},
		})
		vim.lsp.enable("tsgo")

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"black",
				"isort",
				"ruff",
				"mypy",
				"debugpy",
				"biome",
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

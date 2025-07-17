return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Enable the default diagnostic handlers
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local lspconfig = require("lspconfig")

		local opts = { noremap = true, silent = true }

		-- Function to attach keybinds
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show codebase diagnostics"
			vim.keymap.set("n", "<leader>DD", "<cmd>Telescope diagnostics<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
				vim.schedule(function()
					vim.diagnostic.open_float()
				end)
			end, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
				vim.schedule(function()
					vim.diagnostic.open_float()
				end)
			end, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- Capabilities for autocompletion
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Configure server-specific settings
		-- These will be used by mason-lspconfig's automatic_enable feature
		
		-- Lua language server configuration
		vim.lsp.config.lua_ls = {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
					telemetry = { enable = false },
				},
			},
		}

		-- TypeScript server
		vim.lsp.config.ts_ls = {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "mdx" },
		}

		-- Go language server
		vim.lsp.config.gopls = {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "go", "gomod" },
		}

		-- Java language server
		vim.lsp.config.jdtls = {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "java" },
		}

		-- C/C++ language server
		vim.lsp.config.clangd = {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "c", "cpp" },
		}

		-- Configure all other servers with default settings
		local servers = {
			"pyright",
			"html",
			"cssls",
			"emmet_ls",
			"tailwindcss",
		}

		for _, server in ipairs(servers) do
			vim.lsp.config[server] = {
				on_attach = on_attach,
				capabilities = capabilities,
			}
		end

		vim.lsp.config.eslint.filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
		
		if vim.lsp.config.pyright then
			vim.lsp.config.pyright.settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic",
						diagnosticMode = "openFilesOnly",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticSeverityOverrides = {
							-- Customize specific diagnostic severities if needed
							-- reportUnusedImport = "information",
						},
					},
				},
			}
		end
	end,
}

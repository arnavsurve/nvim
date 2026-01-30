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

		-- Set buffer-local LSP keymaps on attach for all servers
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local opts = { noremap = true, silent = true, buffer = bufnr }

				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)

				opts.desc = "Go to definition in new tab"
				vim.keymap.set("n", "gt", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)

				opts.desc = "See available code actions"
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>FzfLua diagnostics_document<CR>", opts)

				opts.desc = "Show workspace diagnostics"
				vim.keymap.set("n", "<leader>DD", "<cmd>FzfLua diagnostics_workspace<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Prev diagnostic"
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
					vim.schedule(function()
						vim.diagnostic.open_float()
					end)
				end, opts)

				opts.desc = "Next diagnostic"
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
					vim.schedule(function()
						vim.diagnostic.open_float()
					end)
				end, opts)

				opts.desc = "Hover docs"
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				-- TypeScript-specific keymaps (typescript-tools.nvim)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.name == "typescript-tools" then
					opts.desc = "Organize imports"
					vim.keymap.set("n", "<leader>to", "<cmd>TSToolsOrganizeImports<CR>", opts)

					opts.desc = "Sort imports"
					vim.keymap.set("n", "<leader>ts", "<cmd>TSToolsSortImports<CR>", opts)

					opts.desc = "Remove unused imports"
					vim.keymap.set("n", "<leader>tu", "<cmd>TSToolsRemoveUnusedImports<CR>", opts)

					opts.desc = "Add missing imports"
					vim.keymap.set("n", "<leader>ti", "<cmd>TSToolsAddMissingImports<CR>", opts)

					opts.desc = "Fix all auto-fixable issues"
					vim.keymap.set("n", "<leader>tf", "<cmd>TSToolsFixAll<CR>", opts)

					opts.desc = "Go to source definition"
					vim.keymap.set("n", "<leader>td", "<cmd>TSToolsGoToSourceDefinition<CR>", opts)

					opts.desc = "Find file references"
					vim.keymap.set("n", "<leader>tr", "<cmd>TSToolsFileReferences<CR>", opts)

					opts.desc = "Rename file + update imports"
					vim.keymap.set("n", "<leader>tR", "<cmd>TSToolsRenameFile<CR>", opts)
				end
			end,
		})
	end,
}

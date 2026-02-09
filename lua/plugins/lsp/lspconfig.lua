return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Enable the default diagnostic handlers
		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Set buffer-local LSP keymaps on attach for all servers
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf

				vim.api.nvim_create_autocmd("CursorHold", {
					buffer = bufnr,
					callback = function()
						vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
					end,
				})
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

				opts.desc = "Copy diagnostic to clipboard"
				vim.keymap.set("n", "<leader>dc", function()
					local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
					if #diags == 0 then
						vim.notify("No diagnostics on this line", vim.log.levels.WARN)
						return
					end
					local msgs = vim.tbl_map(function(d) return d.message end, diags)
					local text = table.concat(msgs, "\n")
					vim.fn.setreg("+", text)
					vim.notify("Copied " .. #msgs .. " diagnostic(s)", vim.log.levels.INFO)
				end, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})
	end,
}

return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

		-- Function to attach keybinds
		local on_attach = function(client, bufnr)
			local bufmap = function(mode, lhs, rhs, opts)
				opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			-- Keybindings
			bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
			bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
			bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
			bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
			bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
		end

		-- Capabilities for autocompletion
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

		-- Lua language server configuration
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		-- Python language server configuration
		lspconfig.pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
}

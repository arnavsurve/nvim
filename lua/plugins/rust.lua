return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		ft = { "rust" },
		init = function()
			vim.g.rustaceanvim = {
				tools = {
					float_win_config = {
						border = "rounded",
					},
				},
				server = {
					default_settings = {
						["rust-analyzer"] = {
							check = {
								command = "clippy",
							},
							inlayHints = {
								chainingHints = { enable = true },
								typeHints = { enable = true },
								parameterHints = { enable = true },
							},
						},
					},
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				cmp = { enabled = true },
			},
		},
	},
}

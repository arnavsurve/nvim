return {
	-- {
	-- 	"arnavsurve/anysphere.nvim",
	-- 	lazy = false,
	-- 	-- config = function()
	-- 	-- 	local function set_tabline_hl()
	-- 	-- 		vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#ffffff", fg = "#1e1e1e", bold = true })
	-- 	-- 		vim.api.nvim_set_hl(0, "TabLine", { bg = "#2d2d2d", fg = "#808080" })
	-- 	-- 		vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#1e1e1e" })
	-- 	-- 	end
	-- 	-- 	vim.api.nvim_create_autocmd("ColorScheme", {
	-- 	-- 		callback = set_tabline_hl,
	-- 	-- 	})
	-- 	-- 	vim.cmd.colorscheme("anysphere")
	-- 	-- 	set_tabline_hl()
	-- 	-- end,
	-- },

	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		-- config = function()
		-- 	vim.cmd.colorscheme("carbonfox")
		-- end,
	},

	{
		"deparr/tairiki.nvim",
		lazy = true,
	},

	{
		"ellisonleao/gruvbox.nvim",
		lazy = true,
	},

	{
		"sainnhe/gruvbox-material",
		lazy = true,
		opts = ...,
		-- config = function()
		-- 	vim.cmd.colorscheme("gruvbox-material")
		-- 	vim.g.gruvbox_material_enable_italic = true
		-- end,
	},

	{
		"sainnhe/edge",
		lazy = true,
	},

	{
		"d00h/nvim-rusticated",
		lazy = true,
	},

	{
		"rose-pine/neovim",
		name = "rosepine",
		lazy = true,
	},

	{
		"savq/melange-nvim",
		lazy = true,
		priority = 1000,
	},

	{
		"rebelot/kanagawa.nvim",
		lazy = true,
	},

	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = true,
	},

	{
		"vague2k/vague.nvim",
		name = "vague",
		lazy = true,
	},

	{
		"rockyzhang24/arctic.nvim",
		branch = "v2",
		dependencies = { "rktjmp/lush.nvim" },
		lazy = true,
	},

	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			vim.cmd.colorscheme("vscode")
		end,
	},
}

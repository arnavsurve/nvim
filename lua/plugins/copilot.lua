return {
	"github/copilot.vim",
	event = "InsertEnter",
	config = function()
		-- Disable default tab mapping (conflicts with nvim-cmp)
		vim.g.copilot_no_tab_map = true

		-- Accept suggestion with Ctrl+J instead
		vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
			silent = true,
		})
	end,
}

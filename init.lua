require("config.lazy")
require("config.keymaps")
require("config.options")
require("scripts.toggletheme")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.grc",
	command = "set filetype=grace",
})

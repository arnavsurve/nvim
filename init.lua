require("config.lazy")
require("config.keymaps")
require("config.options")
require("scripts.toggletheme")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.grace",
	command = "set filetype=grace",
})

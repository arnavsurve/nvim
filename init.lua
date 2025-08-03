require("config.lazy")
require("config.keymaps")
require("config.options")
require("scripts.toggletheme")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.grc",
	callback = function()
		vim.opt.syntax = "enable"
		vim.bo.filetype = "grace"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.tf", "*.tfvars", "*.hcl" },
	callback = function()
		vim.bo.filetype = "terraform"
		vim.bo.commentstring = "# %s"
	end,
})

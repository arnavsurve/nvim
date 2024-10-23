local colorscheme_toggle = false -- Switch between two colorschemes

function ToggleColorschemeAndTransparency()
	if colorscheme_toggle then
		vim.cmd("TransparentEnable")
		vim.cmd([[colorscheme kanagawa-dragon]])
	else
		vim.cmd([[colorscheme rusticated]])
		vim.cmd("set background=light")
		vim.cmd("TransparentDisable")
	end
	colorscheme_toggle = not colorscheme_toggle
end

vim.api.nvim_create_user_command("ToggleTheme", ToggleColorschemeAndTransparency, {})

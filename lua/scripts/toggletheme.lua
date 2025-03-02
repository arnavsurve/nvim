function _G.toggle_theme()
	local current = vim.g.colors_name or ""
	if current == "melange" then
		vim.cmd("colorscheme rose-pine-dawn")
	elseif current == "rose-pine-dawn" then
		vim.cmd("colorscheme melange")
	else
		vim.cmd("colorscheme melange")
	end
end

vim.api.nvim_create_user_command("ToggleTheme", "lua toggle_theme()", {})

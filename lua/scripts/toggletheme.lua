local theme_dark = "anysphere"
local theme_light = "dayfox"

function _G.toggle_theme()
	local current = vim.g.colors_name or ""
	if current == theme_dark then
		vim.o.background = "light"
		vim.cmd("colorscheme " .. theme_light)
	elseif current == theme_light then
		vim.o.background = "dark"
		vim.cmd("colorscheme " .. theme_dark)
	else
		-- Fallback: default to dark theme
		vim.o.background = "dark"
		vim.cmd("colorscheme " .. theme_dark)
	end
end

vim.api.nvim_create_user_command("ToggleTheme", "lua toggle_theme()", {})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local theme_file = vim.fn.stdpath("config") .. "/last_theme.txt"
		local file = io.open(theme_file, "w")
		if file then
			file:write(vim.g.colors_name)
			file:close()
		end
	end,
})

local theme_file = vim.fn.stdpath("config") .. "/last_theme.txt"
local file = io.open(theme_file, "r")
if file then
	local theme = file:read("*l")
	file:close()
	if theme == theme_light then
		vim.o.background = "light"
		vim.cmd("colorscheme " .. theme_light)
	else
		vim.o.background = "dark"
		vim.cmd("colorscheme " .. theme_dark)
	end
end

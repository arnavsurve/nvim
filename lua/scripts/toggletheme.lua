-- Canonical names to apply
local theme_dark_apply = "tairiki"      -- tairiki sets colors_name to "tairiki"
local theme_light_apply = "dawnfox"

-- Accept multiple identifiers reported by colorschemes
local dark_names = {
  ["tairiki"] = true,
  ["tairiki-dark"] = true,
}
local light_names = {
  ["dawnfox"] = true,
}

function _G.toggle_theme()
  local current = vim.g.colors_name or ""
  if dark_names[current] then
    vim.o.background = "light"
    vim.cmd("colorscheme " .. theme_light_apply)
  elseif light_names[current] then
    vim.o.background = "dark"
    vim.cmd("colorscheme " .. theme_dark_apply)
  else
    -- Fallback: default to dark theme
    vim.o.background = "dark"
    vim.cmd("colorscheme " .. theme_dark_apply)
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
  if light_names[theme] then
    vim.o.background = "light"
    vim.cmd("colorscheme " .. theme_light_apply)
  else
    vim.o.background = "dark"
    vim.cmd("colorscheme " .. theme_dark_apply)
  end
end

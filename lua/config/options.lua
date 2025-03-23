local opt = vim.opt

-- line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.relativenumber = true -- show relative line numbers

-- tabs & indentation
-- opt.tabstop = 4
-- opt.shiftwidth = 4
-- opt.expandtab = true -- expand tab to spaces
-- opt.autoindent = true -- copy indent from current line when starting new one

-- Function to set indentation
local function set_indentation(spaces)
	vim.bo.expandtab = true
	vim.bo.shiftwidth = spaces
	vim.bo.tabstop = spaces
	vim.bo.softtabstop = spaces
end

local autocmd = vim.api.nvim_create_autocmd

-- Set default indentation to 4 spaces
set_indentation(4)

-- Set file type specific indentation
autocmd("FileType", {
	pattern = { "python", "go" },
	callback = function()
		set_indentation(4)
	end,
})

-- Set 2-space indentation for specific file types
autocmd("FileType", {
	pattern = {
		"lua",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"html",
		"css",
		"yaml",
		"json",
		"java",
		"cpp",
		"c",
	},
	callback = function()
		set_indentation(2)
	end,
})

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = { "*.*" },
	desc = "save view (folds), when closing file",
	command = "mkview",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*.*" },
	desc = "load view (folds), when opening file",
	command = "silent! loadview",
})

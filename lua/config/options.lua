local opt = vim.opt

-- line numbers
opt.number = true
opt.relativenumber = false

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

-- auto reload files when changed outside of vim
opt.autoread = true

-- trigger autoread when files change on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	command = "checktime",
})

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = { "*.*" },
	desc = "save view (folds), when closing file",
	command = "silent! mkview",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*.*" },
	desc = "load view (folds), when opening file",
	command = "silent! loadview",
})

-- Performance: faster CursorHold for LSP hover (default 4000ms)
opt.updatetime = 250

-- Prevent "pattern too complex" on large/minified files
opt.maxmempattern = 5000

-- Large file protection: disable expensive features for files >1MB
vim.api.nvim_create_autocmd("BufReadPre", {
	desc = "Disable heavy features for large files",
	callback = function(args)
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
		if ok and stats and stats.size > 1024 * 1024 then
			vim.notify("Large file detected — disabling treesitter, LSP, syntax, and folds", vim.log.levels.WARN)
			vim.cmd("syntax off")
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.foldexpr = "0"
			vim.opt_local.undofile = false
			vim.opt_local.swapfile = false
			vim.b[args.buf].large_file = true

			vim.api.nvim_create_autocmd("BufReadPost", {
				buffer = args.buf,
				once = true,
				callback = function()
					vim.treesitter.stop(args.buf)
					vim.schedule(function()
						vim.lsp.buf_detach_client(args.buf, nil)
					end)
				end,
			})
		end
	end,
})

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.keymap.set('n', '<leader>fs', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>h', ':nohlsearch<cr>')
vim.keymap.set('n', '<leader>c', ':!pdflatex @%')



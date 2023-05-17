-- Set up Vimtex
require('vimtex').setup{
  -- Enable automatic compilation
  autocmds = {
    BufWritePost = {'*.tex', '!pdflatex %'}
  }
}

-- vim.api.nvim_set_keymap('n', '<leader>c', ':VimtexCompile<CR>', {noremap = true, silent = true})

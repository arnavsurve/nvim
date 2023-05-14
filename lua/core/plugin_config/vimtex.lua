-- Set up Vimtex
require('vimtex').setup{
  -- Enable automatic compilation
  autocmds = {
    BufWritePost = {'*.tex', '!pdflatex %'}
  }
}


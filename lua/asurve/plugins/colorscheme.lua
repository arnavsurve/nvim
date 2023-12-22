return {
  -- {
  --   "bluz71/vim-moonfly-colors",
  --   priority = 1000,
  --   config = function()
  --     --load colorscheme
  --     vim.cmd([[colorscheme moonfly]])
  --   end,
  -- },

  {'myagko/nymph', branch = 'Neovim',
    config = function()
      --load colorcheme
      vim.cmd([[colorscheme nymph]])
    end,
  }
}

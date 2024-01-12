## My Neovim Config

This is my current neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management and [mason.nvim](https://github.com/williamboman/mason.nvim) to manage LSP servers, linters, and formatters.

To install, clone this repository into your `~/.config` directory, then run `nvim` for initial setup!

You will see a Lazy gui installing all the necessary plugins and packages on startup. Run another `:Lazy sync` to ensure plugins are installed, clean, and updated. Following this step, a fully functional neovim configuration should be installed! To remove, simply delete the `~/.config/nvim` directory.

Out of the box, LSP and autocompletion functionality is included for HTML/CSS, Python, Lua, LaTeX, and C/C++. Additional LSP servers can be installed with `:MasonInstall [package name]`. I suggest reading [the docs](https://github.com/williamboman/mason.nvim?tab=readme-ov-file#commands).

Note that for all symbols and glyphs to display properly, your terminal emulator should use a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) that supports these features. My personal recommendation is **Hack Nerd Font**.

The plugins included in my config are located in `nvim/lua/asurve/plugins`:
#### LSP
- [lspconfig](https://github.com/neovim/nvim-lspconfig)
- [mason](https://github.com/williamboman/mason.nvim)
	- Note that [npm](https://www.npmjs.com/package/npm) is required as a dependency for Mason to successfully install some packages
#### General
- [autopairs](https://github.com/windwp/nvim-autopairs)
- [bufferline](https://github.com/akinsho/bufferline.nvim)
- [colorscheme (nymph)](https://github.com/myagko/nymph/tree/Neovim)
- [comment](https://github.com/numToStr/Comment.nvim) `gc to comment highlighted lines`
- [lualine](https://github.com/nvim-lualine/lualine.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) `SPC + E to toggle`
- [telescope](https://github.com/nvim-telescope/telescope.nvim) `SPC + ff for fuzzy finding files`
- [vim-maximizer](https://github.com/szw/vim-maximizer)
- [vimtex](https://github.com/lervag/vimtex) `LaTeX compilation using Skim.app as default PDF reader`

In the `nvim/lua/asurve/core` directory, you can find `keymaps.lua`,  a configuration file for keymaps, mostly for window management (splits, tabs) as well as a keymap for toggling the file explorer (nvim-tree). Also located in this directory is `options.lua` with settings that might be found in a simpler `init.vim` or `init.lua` file. Options such as tabs & indentation and line numbers can be changed here.

Thanks for taking a look! I hope if anything this has helped to give some ideas on directory structure or helped you build your own Neovim config. 🫶

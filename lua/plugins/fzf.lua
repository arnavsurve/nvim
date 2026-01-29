return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      "default-title",
      defaults = {
        file_ignore_patterns = {
          "node_modules/",
          ".git/",
          ".next/",
          "dist/",
          "build/",
          "%.lock",
          "package%-lock%.json",
          "yarn%.lock",
          "pnpm%-lock%.yaml",
          "bun%.lockb",
          ".turbo/",
          "coverage/",
        },
      },
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = "rounded",
        preview = {
          layout = "flex",
        },
      },
      files = {
        prompt = "Files❯ ",
        cwd_prompt = false,
        file_ignore_patterns = {
          "node_modules/",
          ".git/",
          ".next/",
          "dist/",
          "build/",
          "%.lock",
          "package%-lock%.json",
          "yarn%.lock",
          "pnpm%-lock%.yaml",
          "bun%.lockb",
          ".turbo/",
          "coverage/",
        },
        fd_opts = "--color=never --type f --hidden --follow "
          .. "--exclude .git "
          .. "--exclude .yarn "
          .. "--exclude node_modules "
          .. "--exclude .next "
          .. "--exclude dist "
          .. "--exclude build "
          .. "--exclude '*.lock' "
          .. "--exclude package-lock.json "
          .. "--exclude yarn.lock "
          .. "--exclude pnpm-lock.yaml "
          .. "--exclude bun.lockb "
          .. "--exclude .turbo "
          .. "--exclude coverage",
      },
      grep = {
        prompt = "Grep❯ ",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 "
          .. "-g !node_modules/ "
          .. "-g !.git/ "
          .. "-g !.yarn/ "
          .. "-g !.next/ "
          .. "-g !dist/ "
          .. "-g !build/ "
          .. "-g !*.lock "
          .. "-g !package-lock.json "
          .. "-g !yarn.lock "
          .. "-g !pnpm-lock.yaml "
          .. "-g !bun.lockb "
          .. "-g !.turbo/ "
          .. "-g !coverage/",
      },
      oldfiles = {
        prompt = "History❯ ",
        cwd_only = true,
      },
    })

    -- set keymaps (same as before)
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fw", "<cmd>FzfLua live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>FzfLua grep_cword<cr>", { desc = "Find string under cursor in cwd" })
  end,
}

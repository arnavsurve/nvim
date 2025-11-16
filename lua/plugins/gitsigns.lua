return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, {
          buffer = bufnr,
          desc = "Toggle git blame"
        })
      end,
    })
  end,
}

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current)" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File history (repo)" },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal", -- stacked: top=old, bottom=new
          winbar_info = false,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
      },
      file_panel = {
        listing_style = "list", -- simpler than tree view
        win_config = {
          position = "left",
          width = 35,
        },
      },
    })
  end,
}

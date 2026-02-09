return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    {
      "<leader>gd",
      function()
        vim.cmd("tabnew")
        vim.cmd("DiffviewOpen")
      end,
      desc = "Open Diffview",
    },
    {
      "<leader>gh",
      function()
        local file = vim.fn.expand("%:p")
        vim.cmd("tabnew")
        vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(file))
      end,
      desc = "File history (current)",
    },
    {
      "<leader>gH",
      function()
        vim.cmd("tabnew")
        vim.cmd("DiffviewFileHistory")
      end,
      desc = "File history (repo)",
    },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
      },
      file_panel = {
        listing_style = "list",
        win_config = {
          position = "left",
          width = 35,
        },
      },
      hooks = {
        view_closed = function()
          -- Clean up the empty tab left after diffview closes
          vim.schedule(function()
            local buf = vim.api.nvim_get_current_buf()
            local name = vim.api.nvim_buf_get_name(buf)
            if name == "" and not vim.bo[buf].modified and vim.fn.tabpagenr("$") > 1 then
              vim.cmd("tabclose")
            end
          end)
        end,
      },
    })
  end,
}

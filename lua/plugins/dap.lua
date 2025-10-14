return {
  -- Core DAP client
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- UI setup
      dapui.setup({})
      require("nvim-dap-virtual-text").setup({})

      -- Auto-open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Keymaps (leader-based, no function keys)
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map("n", "<leader>dc", dap.continue, vim.tbl_extend("force", opts, { desc = "DAP Continue" }))
      map("n", "<leader>dn", dap.step_over, vim.tbl_extend("force", opts, { desc = "DAP Step Over" }))
      map("n", "<leader>di", dap.step_into, vim.tbl_extend("force", opts, { desc = "DAP Step Into" }))
      map("n", "<leader>do", dap.step_out, vim.tbl_extend("force", opts, { desc = "DAP Step Out" }))
      map("n", "<leader>dk", dap.terminate, vim.tbl_extend("force", opts, { desc = "DAP Terminate" }))
      map("n", "<leader>db", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "DAP Toggle Breakpoint" }))
      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, vim.tbl_extend("force", opts, { desc = "DAP Conditional Breakpoint" }))
      map("n", "<leader>dr", dap.restart, vim.tbl_extend("force", opts, { desc = "DAP Restart" }))
      map("n", "<leader>dl", dap.run_last, vim.tbl_extend("force", opts, { desc = "DAP Run Last" }))
      map({ "n", "v" }, "<leader>de", function()
        dapui.eval()
      end, vim.tbl_extend("force", opts, { desc = "DAP Eval" }))
      map("n", "<leader>du", dapui.toggle, vim.tbl_extend("force", opts, { desc = "DAP UI Toggle" }))

      -- C/C++: codelldb adapter and launch configs
      local data = vim.fn.stdpath("data")
      local mason = data .. "/mason"
      local codelldb_root = mason .. "/packages/codelldb/extension/"
      local adapter_path = codelldb_root .. "adapter/codelldb"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = adapter_path,
          args = { "--port", "${port}" },
        },
      }

      local launch = {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        terminal = "integrated",
      }

      dap.configurations.c = { launch }
      dap.configurations.cpp = { launch }
    end,
  },

  -- Go adapter helpers (dlv)
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map("n", "<leader>dgt", function()
        require("dap-go").debug_test()
      end, vim.tbl_extend("force", opts, { desc = "DAP Go: Debug Test" }))
      map("n", "<leader>dgl", function()
        require("dap-go").debug_last()
      end, vim.tbl_extend("force", opts, { desc = "DAP Go: Debug Last" }))
    end,
  },
}

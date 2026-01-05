return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
    },
    opts = function()
      local root = (LazyVim and LazyVim.root) and LazyVim.root() or vim.fn.getcwd()

      return {
        adapters = {
          require("neotest-jest")({
            jestCommand = "yarn jest",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function()
              return root
            end,
          }),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            if require("lazy.core.config").plugins["trouble.nvim"] then
              require("trouble").open({ mode = "quickfix", focus = true })
            else
              vim.cmd("copen")
            end
          end,
        },
      }
    end,
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if not opts.adapters then
        opts.adapters = {}
      end

      opts.consumers = opts.consumers or {}
      opts.consumers.coverage = {
        enabled = false,
      }

      require("neotest").setup(opts)
    end,
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.uv.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest",
      },
      {
        "<leader>ts",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach",
      },
    },
  },
}

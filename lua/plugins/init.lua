return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- ToggleTerm (terminal manager)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",  -- or "horizontal"/"vertical"
        open_mapping = [[<leader>tt]],  -- Optional: Direct mapping here instead of mappings.lua
      })
    end,
  },

  -- Go.nvim (Go development)
  {
    "ray-x/go.nvim",
    ft = "go",  -- Only load for Go files
    config = function()
      require("go").setup({
        goimport = "gopls",  -- Use gopls for imports
        gofmt = "gofmt",     -- Use gofmt
        lsp_keymaps = false, -- Disable default LSP keymaps (use yours from mappings.lua)
      })
    end,
    dependencies = {  -- Optional: Install these if you need debugging
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
  },

  -- swenv.nvim (Python virtualenv switcher)
  {
    "AckslD/swenv.nvim",
    ft = "python",  -- Only load for Python files
    config = function()
      require("swenv").setup({
        venvs_path = vim.fn.expand("~/venvs"),  -- Path to your Python venvs
      })
    end,
  },

  -- nvim-dap-python (Python debugging)
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")  -- Path to debugpy
    end,
  },

  -- UI Theme (optional - replace with your preferred theme)
  {
    "NvChad/nvim-colorizer.lua",
    opts = { user_default_options = { names = false } },  -- Better color highlighting
  },
  {
    "devsjc/vim-jb",
    lazy = false,
    config = function()
      vim.g.jb_plugin_option = "value"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}

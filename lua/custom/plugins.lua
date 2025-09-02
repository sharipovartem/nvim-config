return {
  -- ToggleTerm (terminal manager)
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {"<leader>tt"},
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = nil, -- We'll use our custom mapping instead
        direction = "float",  -- or "horizontal"/"vertical"
        float_opts = {
          border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.8)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.8)
          end,
        },
        shell = vim.o.shell,
        autochdir = true, -- When enabled automatically change to directory of current file
      })
    end,
  },

  -- Go.nvim (Go development)
  {
    "ray-x/go.nvim",
    ft = "go",  -- Only load for Go files
    cmd = {"GoImports", "GoRun", "GoTest", "GoInstallDeps"},
    config = function()
      require("go").setup({
        goimports = "gopls",  -- Use gopls for imports
        gofmt = "gofumpt",   -- Use gofumpt for better formatting
        lsp_keymaps = false, -- Disable default LSP keymaps
        lsp_document_formatting = true, -- Enable automatic formatting on save
        lsp_inlay_hints = { enable = true },
        run_in_floaterm = true,
        diagnostic = true,
        imports_on_save = true,  -- Re-enabling auto imports
        lsp_codelens = true,
        impl_template = 'type $T struct {\n\t$I\n}\n\nfunc (t $T) $F {\n\t$B\n}',
      })
      
      -- Remove gopls special configuration that might interfere
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*.go",
      --   callback = function()
      --     -- Format without changing imports
      --     require("go.format").gofmt()
      --   end,
      -- })
      
      -- Restore automatic imports and formatting on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
      })
    end,
    dependencies = {  
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- remote-nvim (Remote development)
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
  },
    lazy = false,  -- Don't lazy load
    priority = 1000,  -- Load early
    config = function()
      require("remote-nvim").setup()
      -- Force command registration
      vim.api.nvim_create_user_command("RemoteStart", function()
        require("remote-nvim").start()
      end, {})
    end,
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
  {
   "amitds1997/remote-nvim.nvim",
   version = "*", -- Pin to GitHub releases
   dependencies = {
       "nvim-lua/plenary.nvim", -- For standard functions
       "MunifTanjim/nui.nvim", -- To build the plugin UI
       "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
   },
   config = function ()
     require("remote-nvim").setup()
    end,
  },

  -- UI Theme (optional - replace with your preferred theme)
  {
    "NvChad/nvim-colorizer.lua",
    opts = { user_default_options = { names = false } },  -- Better color highlighting
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    lazy = false,
    event = "InsertEnter",
    config = function()
      -- Disable default tab mapping
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Use Alt+Enter for acceptance (less likely to conflict)
      vim.api.nvim_set_keymap('i', '<M-CR>', 'copilot#Accept("<CR>")', {
        expr = true,
        silent = true
      })
      
      -- Simpler keybindings that are less likely to conflict
      vim.api.nvim_set_keymap('i', '<M-n>', '<Plug>(copilot-next)', { silent = true })
      vim.api.nvim_set_keymap('i', '<M-p>', '<Plug>(copilot-previous)', { silent = true })
      vim.api.nvim_set_keymap('i', '<M-d>', '<Plug>(copilot-dismiss)', { silent = true })
      
      -- Create toggle command for Copilot
      vim.api.nvim_create_user_command('CopilotToggle', function()
        if vim.g.copilot_enabled == 0 then
          vim.cmd('Copilot enable')
          print("Copilot enabled")
        else
          vim.cmd('Copilot disable')
          print("Copilot disabled")
        end
      end, {})
      
      -- Commands for panel and toggle
      vim.keymap.set('n', '<leader>cp', '<cmd>Copilot panel<CR>', { desc = "Copilot panel", silent = true })
      vim.keymap.set('n', '<leader>ct', '<cmd>CopilotToggle<CR>', { desc = "Toggle Copilot", silent = true })
    end,
  },

  -- Refactoring tools by ThePrimeagen
  {
    "ThePrimeagen/refactoring.nvim",
    ft = {"go", "lua", "javascript", "typescript", "python"},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup({})
      
      -- Keymaps for refactoring
      vim.keymap.set("x", "<leader>re", function() require("refactoring").refactor("Extract Function") end, 
        { desc = "Extract function" })
      vim.keymap.set("x", "<leader>rv", function() require("refactoring").refactor("Extract Variable") end, 
        { desc = "Extract variable" })
      vim.keymap.set("n", "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, 
        { desc = "Inline variable" })
      
      -- Prompt for refactoring
      vim.keymap.set(
        {"n", "x"}, 
        "<leader>rr", 
        function() require("refactoring").select_refactor() end, 
        { desc = "Select refactoring" }
      )
      
      -- Debug print statements
      vim.keymap.set("n", "<leader>rp", function() require("refactoring").debug.printf({below = false}) end, 
        { desc = "Debug print" })
      vim.keymap.set("n", "<leader>rv", function() require("refactoring").debug.print_var() end, 
        { desc = "Debug print variable" })
      vim.keymap.set("n", "<leader>rc", function() require("refactoring").debug.cleanup() end, 
        { desc = "Debug cleanup" })
    end,
  },
}

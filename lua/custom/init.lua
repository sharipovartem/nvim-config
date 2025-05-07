-- custom/init.lua
-- This file loads custom configurations

local autocmd = vim.api.nvim_create_autocmd

-- Load custom mappings for toggleterm and Go commands
local function load_custom_mappings()
  -- ToggleTerm mappings
  vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal", silent = true })
  vim.keymap.set("t", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal", silent = true })
  vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })
  
  -- Go commands
  vim.keymap.set("n", "<leader>go", "<cmd>GoImports<CR>", { desc = "Add Go imports", silent = true })
  vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<CR>", { desc = "Run Go file", silent = true })
end

-- Load our custom mappings
load_custom_mappings()

-- Auto commands
autocmd("FileType", {
  pattern = "go",
  callback = function()
    -- Ensure Go commands are available when editing Go files
    vim.cmd("silent! GoInstallDeps")
  end,
})

-- Ensure ToggleTerm is working properly
autocmd("VimEnter", {
  callback = function()
    -- Make sure ToggleTerm is loaded at startup
    vim.cmd("silent! lua require('toggleterm').setup()")
    -- Reload mappings for good measure
    load_custom_mappings()
  end,
})

-- Better LSP setup for Go
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if lspconfig_ok then
  lspconfig.gopls.setup({
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        gofumpt = true,
        usePlaceholders = true,
        completeUnimported = true,
        matcher = "fuzzy",
        experimentalPostfixCompletions = true,
      },
    },
    flags = {
      debounce_text_changes = 150,
    },
  })
end

-- Ensure Go tools are installed
local function ensure_go_tools()
  local go_tools = {
    "golang.org/x/tools/gopls@latest",
    "github.com/fatih/gomodifytags@latest",
    "github.com/josharian/impl@latest",
    "github.com/cweill/gotests/gotests@latest",
    "github.com/segmentio/golines@latest",
    "mvdan.cc/gofumpt@latest",
    "honnef.co/go/tools/cmd/staticcheck@latest",
  }
  
  for _, tool in ipairs(go_tools) do
    vim.cmd("silent! GoInstallBinaries " .. tool)
  end
end

-- Run tool installation when opening a Go file for the first time
autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.defer_fn(function()
      ensure_go_tools()
    end, 1000) -- Delay by 1 second to not slow down startup
  end,
  once = true, -- Only run once per session
}) 
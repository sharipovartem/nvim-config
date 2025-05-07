require "nvchad.mappings"

-- Add your mappings here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Initialize toggleterm
local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if toggleterm_ok then
  toggleterm.setup({
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = nil, -- We'll use our custom mapping instead
    direction = "float",
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
  })
end

-- ToggleTerm
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal", silent = true })
map("t", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal", silent = true })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode", silent = true })

-- Go
map("n", "<leader>go", "<cmd>GoImport<CR>", { desc = "Add Go import", silent = true })
map("n", "<leader>gr", "<cmd>GoRun<CR>", { desc = "Run Go file", silent = true })

-- Python
map("n", "<leader>pv", "<cmd>lua require('swenv.api').pick_venv()<CR>", { desc = "Switch Python venv", silent = true })

local M = {}

-- Add any additional mappings for the NvChad API here
-- These will be loaded via the NvChad API, not directly via vim.keymap.set

return M

-- custom/mappings.lua

local M = {}

M.general = {
  n = {
    -- ToggleTerm
    ["<leader>tt"] = { "<cmd>ToggleTerm<CR>", "Toggle terminal" },
    
    -- Go
    ["<leader>go"] = { "<cmd>GoImports<CR>", "Add Go imports" },
    ["<leader>gr"] = { "<cmd>GoRun<CR>", "Run Go file" },
    ["<leader>gt"] = { "<cmd>GoTest<CR>", "Test Go package" },
    ["<leader>gi"] = { "<cmd>GoImpl<CR>", "Generate interface implementation" },
    ["<leader>gd"] = { "<cmd>GoDoc<CR>", "Show Go documentation" },
    
    -- Refactoring (ThePrimeagen)
    ["<leader>ri"] = { function() require("refactoring").refactor("Inline Variable") end, "Inline variable" },
    ["<leader>rp"] = { function() require("refactoring").debug.printf({below = false}) end, "Debug print" },
    ["<leader>rc"] = { function() require("refactoring").debug.cleanup() end, "Clean debug prints" },
    ["<leader>rr"] = { function() require("refactoring").select_refactor() end, "Select refactoring" },
    
    -- GitHub Copilot
    ["<leader>cp"] = { "<cmd>Copilot panel<CR>", "Open Copilot suggestion panel" },
    ["<leader>ct"] = { "<cmd>CopilotToggle<CR>", "Toggle Copilot on/off" },
  },
  i = {
    -- GitHub Copilot insert mode bindings (Alt-based for fewer conflicts)
    ["<M-CR>"] = { 'copilot#Accept("<CR>")', "Accept Copilot suggestion", expr = true },
    ["<M-n>"] = { "<Plug>(copilot-next)", "Next Copilot suggestion" },
    ["<M-p>"] = { "<Plug>(copilot-previous)", "Previous Copilot suggestion" },
    ["<M-d>"] = { "<Plug>(copilot-dismiss)", "Dismiss Copilot suggestion" },
  },
  x = {
    -- Visual mode refactoring
    ["<leader>re"] = { function() require("refactoring").refactor("Extract Function") end, "Extract function" },
    ["<leader>rv"] = { function() require("refactoring").refactor("Extract Variable") end, "Extract variable" },
  },
  t = {
    ["<leader>tt"] = { "<cmd>ToggleTerm<CR>", "Toggle terminal" },
    ["<Esc>"] = { "<C-\\><C-n>", "Exit terminal mode" },
  },
}

return M
---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>rc"] = { "<cmd>lua require('persistence').load()<cr>", "restore the session for the current directory" },
    ["<leader>rl"] = { "<cmd>lua require('persistence').load({ last = true })<cr>", "restore the last session" },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

-- more keybinds!

return M

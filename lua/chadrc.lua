-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "bearded-arc",

  -- hl_override = {
  --  Comment = { italic = true },
  --  ["@comment"] = { italic = true },
  -- },
  tabufline = {
    enabled = false,
    lazyload = true,
    overriden_modules = nil,
  },
  nvdash = {
    load_on_startup = true,
  },
}

return M

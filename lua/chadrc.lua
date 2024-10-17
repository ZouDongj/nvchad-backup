-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },

    FoldColumn = {
      bg = "black",
    },
  },
}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },

  tabufline = {
    enabled = false,
    lazyload = true,
    overriden_modules = nil,
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
       "                            ",
       "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
       "   ▄▀███▄     ▄██ █████▀    ",
       "   ██▄▀███▄   ███           ",
       "   ███  ▀███▄ ███           ",
       "   ███    ▀██ ███           ",
       "   ███      ▀ ███           ",
       "   ▀██ █████▄▀█▀▄██████▄    ",
       "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
       "                            ",
       "     Powered By Neovim    ",
       "                            ",
     },
}

return M

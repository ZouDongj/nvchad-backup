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
    theme = "default",
    separator_style = "round",
  },

  tabufline = {
    enabled = false,
    lazyload = true,
    overriden_modules = nil,
  },

  cmp = {
    lspkind_text = true,
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true,
    },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "                                  ",
    "  ███╗   ███╗██████╗    ███████╗  ",
    "  ████╗ ████║██╔══██╗   ╚══███╔╝  ",
    "  ██╔████╔██║██████╔╝     ███╔╝   ",
    "  ██║╚██╔╝██║██╔══██╗    ███╔╝    ",
    "  ██║ ╚═╝ ██║██║  ██║██╗███████╗  ",
    "  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚══════╝  ",
    "                                  ",
    "        󰖨  Be Your Own Sun        ",
    "                                  ",
  },
}

return M

vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require("options")
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("nvchad.autocmds")

-- lua/xml tab
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "xml" },
  callback = function()
    vim.opt_local.tabstop = 2 -- 设置 tab 的宽度为 2 个空格
    vim.opt_local.shiftwidth = 2 -- 设置自动缩进的宽度为 2 个空格
    vim.opt_local.expandtab = true -- 将 tab 替换为空格
  end,
})

-- set filetype for log files
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  pattern = "*.log",
  callback = function()
    vim.bo.filetype = "log" -- 设置文件类型为 log
  end,
})

vim.schedule(function()
  require("mappings")
end)

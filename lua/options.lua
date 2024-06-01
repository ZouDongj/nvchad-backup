require "nvchad.options"

-- add yours here!
local opt = vim.opt
local g = vim.g

-- utf8
opt.fileencoding = "utf-8"
g.encoding = "UTF-8"

-- 移动光标时周围保留8行
opt.scrolloff = 8
opt.sidescrolloff = 8

-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2

-- 高亮所在行
vim.wo.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.mouse = ""

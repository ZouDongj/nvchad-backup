require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- save
map("n", "q", "<cmd> q <CR>", { desc = "Quit" })
map("n", "qq", "<cmd> q! <CR>", { desc = "Force quit" })
map("n", "w", "<cmd> w <CR>", { desc = "Save file" })
map("n", "ww", "<cmd> wq <CR>", { desc = "Save file" })

-- edit
map("n", "dd", '"_dd', { desc = "delete text without copy" })
map("i", "jk", "<ESC>")

-- move
map("n", "<C-u>", "10k", { desc = "Move up by 10 lines" })
map("n", "<C-d>", "10j", { desc = "Move down by 10 lines" })

-- split windows
map("n", "sv", ":vsp<CR>", { desc = "Split vertical" })
map("n", "sc", "<C-w>c", { desc = "Close current window" })

-- indent
map("v", "<", "<gv", { desc = "Indent line left" })
map("v", ">", ">gv", { desc = "Indent line right" })

map("n", "<A-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map("n", "<A-m>", "<cmd> SymbolsOutline <CR>", { desc = "Toggle symbolsOutline" })

-- Lazy git
map("n", "<A-g>", "<cmd> LazyGitCurrentFile <CR>", { desc = "Toggle Lazy git" })
map("n", "<A-f>", "<cmd> LazyGitFilterCurrentFile <CR>", { desc = "Toggle lazy git current file" })

-- persistence
map("n", "<leader>rc", "<cmd> lua require('persistence').load() <CR>", {desc = "Restore the session for the current directory"})
map("n", "<leader>rl", "<cmd>lua require('persistence').load({ last = true })<CR>", {desc = "Restore the last session"})

-- hop
map("n", "<leader>h", "<cmd> HopWord <CR>", {desc = "Hop word"})
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

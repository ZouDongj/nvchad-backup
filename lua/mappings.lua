require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- save
map("n", "q", "<cmd> q <CR>", { desc = "Buffer Quit" })
map("n", "qq", "<cmd> q! <CR>", { desc = "Buffer Force quit" })
map("n", "w", "<cmd> w <CR>", { desc = "Buffer Save file" })
map("n", "ww", "<cmd> wq <CR>", { desc = "Buffer Save file" })

-- edit
map("n", "dd", '"_dd', { desc = "Edit delete text without copy" })
map("v", "d", '"_d', { desc = "Edit delete without copy" })
map("v", "J", ":move '>+1<CR>gv-gv", { desc = "Edit mv selected text down" })
map("v", "K", ":move '<-2<CR>gv-gv", { desc = "Edit mv selected text up" })

-- nvim-spectre
map(
  "n",
  "<leader>so",
  '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
  { desc = "nvim-spectre Search current word" }
)

map(
  "n",
  "<leader>sp",
  '<cmd>lua require("spectre").open_file_search()<CR>',
  { desc = "nvim-spectre Search on current file" }
)

-- move
map("n", "<C-u>", "10k", { desc = "Edit Move up by 10 lines" })
map("n", "<C-d>", "10j", { desc = "Edit Move down by 10 lines" })

-- split windows
map("n", "sv", ":vsp<CR>", { desc = "WindowsManage Split vertical" })
map("n", "sc", "<C-w>c", { desc = "WindowsManage Split Close current window" })

-- indent
map("v", "<", "<gv", { desc = "Indent Indent line left" })
map("v", ">", ">gv", { desc = "Indent Indent line right" })

map("n", "<A-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Nvimtree Toggle nvimtree" })
map("n", "<A-m>", "<cmd> Outline <CR>", { desc = "Nvimtree Toggle symbols outline" })

-- Lazy git
map("n", "<A-g>", "<cmd> LazyGitCurrentFile <CR>", { desc = "LazyGit Toggle Lazy git" })
map("n", "<A-f>", "<cmd> LazyGitFilterCurrentFile <CR>", { desc = "LazyGit Toggle lazy git current file" })

-- persistence
map(
  "n",
  "<leader>rc",
  "<cmd> lua require('persistence').load() <CR>",
  { desc = "Persistence Restore the session for the current directory" }
)
map(
  "n",
  "<leader>rl",
  "<cmd>lua require('persistence').load({ last = true })<CR>",
  { desc = "Persistence Restore the last session" }
)

-- hop
map("n", "<leader>h", "<cmd> HopWord <CR>", { desc = "Hop Hop word" })

-- lsp
map("n", "<leader>lf", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "Lsp Floating diagnostic" })

-- call-tree
map("n", "<A-t>", "<cmd> lua vim.lsp.buf.incoming_calls() <CR>", { desc = "calltree incoming_calls" })
map("n", "<A-l>", "<cmd> LTPanel <CR>", { desc = "calltree toggle calltree panel" })

-- barbar
map("n", "<tab>", "<cmd> BufferNext <CR>", { desc = "Barbar Go to next buffer" })
map("n", "<S-tab>", "<cmd> BufferPrevious <CR>", { desc = "Barbar Go to previous buffer" })
map("n", "<leader>x", "<cmd> BufferClose <CR>", { desc = "Barbar Close current buffer" })
map("n", "<A-p>", "<cmd> BufferPin <CR>", { desc = "Barbar Pin current buffer" })
map("n", "<A-j>", "<cmd> BufferPick <CR>", { desc = "Barbar Pick buffer" })
map("n", "<A-d>", "<cmd> BufferPickDelete <CR>", { desc = "Barbar Pick buffer to delete" })
map("n", "<A-<>", "<cmd> BufferMovePrevious <CR>", { desc = "Barbar Re-order current buffer to previous" })
map("n", "<A->>", "<cmd> BufferMoveNext <CR>", { desc = "Barbar Re-order current buffer to next" })

-- myword
map("n", "<F8>", "<cmd> lua require'mywords'.hl_toggle() <CR>", { desc = "MyWords highlight current word" })

-- trim
map("n", "tt", "<cmd> Trim <CR>", { desc = "Trim Trim whitespace" })

-- resize
map("n", "<C-Left>", "<cmd> vertical resize -2 <CR>", { desc = "WindowsManage decrease windows width" })
map("n", "<C-Right>", "<cmd> vertical resize +2 <CR>", { desc = "WindowsManage increase windows width" })

-- gitsigns
map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { expr = true }, { desc = "GitSigns Jump to next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { expr = true }, { desc = "GitSigns Jump to prev hunk" })

map("n", "<leader>gb", function()
  package.loaded.gitsigns.blame_line()
end, { desc = "GitSigns Blame line" })

map("n", "<leader>tb", function()
  package.loaded.gitsigns.toggle_current_line_blame()
end, { desc = "GitSigns Toggle blame current line" })

-- telescope
local function live_grep_opts(opts)
  local flags = tostring(vim.v.count)
  local additional_args = {}
  local prompt_title = "Live Grep"
  if flags:find("1") then
    prompt_title = prompt_title .. " [w]"
    table.insert(additional_args, "--word-regexp")
  end
  if flags:find("2") then
    prompt_title = prompt_title .. " [Aa]"
    table.insert(additional_args, "--case-sensitive")
  end
  if flags:find("3") then
    prompt_title = prompt_title .. " [.*]"
  else
    table.insert(additional_args, "--fixed-strings")
  end

  opts = opts or {}
  opts.additional_args = function()
    return additional_args
  end
  opts.prompt_title = prompt_title
  return opts
end

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep(live_grep_opts({}))
end, { desc = "telescope live grep" })
map("n", "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })

-- format file
map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
  vim.cmd("retab")
end, { desc = "Edit General Format file" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Disable mappings
local nomap = vim.keymap.del
nomap("n", "<leader>fw")
nomap("n", "<leader>fz")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- leader
vim.g.mapleader = " "

-- save
map({ "n", "i" }, "<C-s>", "<cmd>w<CR>", opts)

-- quit
map("n", "<C-c>", "<cmd>qa<CR>", opts)

-- clear search highlight
map("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- window resize
map("n", "<C-Up>",    ":resize -2<CR>", opts)
map("n", "<C-Down>",  ":resize +2<CR>", opts)
map("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

-- move lines (visual mode) 上下移动一行
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- keep cursor centered when jumping
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- terminal escape
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- better paste (keep register)
map("x", "<leader>p", [["_dP]], opts)

-- 替换光标附近单词
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>//g<Left><Left>", opts)

-- LuaSnip: Tab 展开/跳转
vim.schedule(function()
  local ls = require("luasnip")
  map("i", "<Tab>", function()
    if ls.expand_or_jumpable() then ls.expand_or_jump()
    else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true) end
  end, opts)
  map("i", "<S-Tab>", function()
    if ls.jumpable(-1) then ls.jump(-1)
    else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", true) end
  end, opts)
end)

-- markdown math
map("i", "<A-m>", "$$  $$<Esc>2hi", opts)
map("i", "<A-s>", "$$<Left>", opts)

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
map("n", "<leader>s", ":%s/<C-r><C-a>//g<Left><Left>", opts)

-- S-Tab dedent
map("i", "<S-Tab>", "<C-d>", opts)

-- insert mode 方向键：C-b 左移，C-f 右移（已覆盖 blink 默认绑定）
map("i", "<C-b>", "<Left>", opts)
map("i", "<C-f>", "<Right>", opts)

-- markdown math（仅在 md 文件生效）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    map("i", "<A-m>", "$$  $$<Esc>2hi", opts)
    map("i", "<A-s>", "$$<Left>", opts)
  end,
})

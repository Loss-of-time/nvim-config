local opt = vim.opt

-- UI
opt.number = true           -- 显示绝对行号
opt.relativenumber = true   -- 显示相对行号（方便行移动）
opt.cursorline = true       -- 高亮当前行
opt.signcolumn = "yes"      -- 始终显示左侧符号列（git/诊断）
opt.showmode = false        -- 不显示 -- INSERT --（lualine 已显示）
opt.guicursor = "a:blinkwait700-blinkon400-blinkoff250" -- 光标闪烁

-- Colors
opt.termguicolors = true    -- 24 位真彩色（WezTerm 支持）

-- Window
opt.splitright = true       -- 新窗口在右
opt.splitbelow = true       -- 新窗口在下
opt.scrolloff = 8           -- 光标上方/下方保留行数
opt.sidescrolloff = 8       -- 光标左侧/右侧保留列数

-- Mouse
opt.mouse = "a"             -- 全部模式启用鼠标（WSL2 下选择/滚动）

-- Clipboard
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- SSH 时不连系统剪贴板
vim.g.clipboard = {                                              -- 手动指定 Wayland 剪贴板工具
  name = "wl-clipboard",
  copy = { ["+"] = "wl-copy", ["*"] = "wl-copy" },
  paste = {
    ["+"] = { "sh", "-c", "wl-paste | tr -d '\\r'" },
    ["*"] = { "sh", "-c", "wl-paste | tr -d '\\r'" },
  },
  cache_enabled = 0,
}

-- Undo
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
opt.undofile = true        -- 跨会话持久撤销
opt.undodir = undodir      -- 撤销历史文件存储目录
opt.backup = false         -- 不创建备份文件
opt.writebackup = false    -- 写入时不创建临时备份
opt.swapfile = false       -- 不创建 swap 文件

-- Search
opt.ignorecase = true    -- 搜索忽略大小写
opt.smartcase = true     -- 输入大写时区分大小写

-- Indent
opt.expandtab = true     -- Tab 转空格
opt.shiftwidth = 2       -- 缩进宽度
opt.tabstop = 2          -- Tab 显示宽度
opt.smartindent = true   -- 自动缩进

-- Behavior
opt.confirm = true                          -- 未保存时询问确认
opt.autoread = true                         -- 外部修改后自动重读
opt.autowrite = false                       -- 不自动保存
opt.autochdir = false                       -- 不自动切换目录
opt.wrap = false                            -- 禁止自动换行
opt.selection = "inclusive"                 -- 选择包含结尾字符
opt.backspace = "indent,eol,start"          -- 退格键行为
opt.updatetime = 300                        -- swap 写入 / 触发 CursorHold 的间隔
opt.timeoutlen = 500                        -- 快捷键序列超时
opt.ttimeoutlen = 50                        -- 坑: 设为 0 则 DA 序列被拆解，showcmd 显示 42c

-- Session 自动恢复（无参数启动时）
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require("persistence").load()
      end)
    end
  end,
})

-- Markdown 自动换行
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
})

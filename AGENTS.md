# nnvim — 从零搭建的 Neovim 配置

## 环境
- 系统：WSL2 openSUSE Tumbleweed
- 终端：WezTerm（配置：`/mnt/c/Users/Loss_/.wezterm.lua`）
- Neovim：v0.12.2（内置 LSP、Treesitter）

## 启动方式
nnvim 使用独立配置目录 `~/.config/nnvim/`，通过 `NVIM_APPNAME` 启动：

```bash
NVIM_APPNAME=nnvim nvim
```

未设置永久环境变量，需要手动前缀。

## Agent 操作规范
- 编辑 nnvim 配置后，必须用 `NVIM_APPNAME=nnvim nvim` 测试生效
- `options.lua` 当前留空，新增选项优先直接写入 `init.lua`
- `lua/plugins/` 预留目录，装插件时按插件名分文件放入

## 设计原则
- **学透再装** — 先理解内置方案，有明确不足再引入插件
- **Ponytail 模式** — 最小可行配置，YAGNI，能不装就不装

## 目录结构
```
~/.config/nnvim/
├── init.lua              # 主入口：选项 + 映射 + 剪贴板 + lazy bootstrap
├── lua/
│   ├── options.lua       # （预留）选项不够多了再拆
│   ├── keymaps.lua       # 快捷键映射
│   └── plugins/          # 插件规格文件（15 个）
│       ├── autopairs.lua
│       ├── comment.lua
│       ├── flash.lua
│       ├── indent-blankline.lua
│       ├── live-preview.lua
│       ├── lualine.lua
│       ├── luasnip.lua
│       ├── persistence.lua
│       ├── smear_cursor.lua
│       ├── telescope.lua
│       ├── toggleterm.lua
│       ├── tokyonight.lua
│       ├── treesitter.lua
│       └── which-key.lua
```

## 已装插件
| 插件 | 作用 |
|------|------|
| `folke/tokyonight.nvim` | 主题（moon 风格） |
| `nvim-treesitter/nvim-treesitter` | 语法高亮 / 解析器 |
| `nvim-lualine/lualine.nvim` | 状态栏美化 |
| `windwp/nvim-autopairs` | 括号/引号自动补全 |
| `numToStr/Comment.nvim` | `gcc` 注释切换 |
| `nvim-telescope/telescope.nvim` | 模糊搜索文件/内容/缓冲区 |
| `L3MON4D3/LuaSnip` | 代码片段引擎 |
| `LukasKorotaj/luasnip-markdown-snippets.nvim` | Markdown LaTeX 数学片段 |
| `folke/flash.nvim` | 标签跳跃 |
| `folke/persistence.nvim` | 自动保存/恢复 session |
| `lukas-reineke/indent-blankline.nvim` | 缩进参考线 |
| `smear-cursor.nvim` | 光标滑动过渡 |
| `akinsho/toggleterm.nvim` | 浮动终端 |
| `folke/which-key.nvim` | 输入提示按键弹窗 |
| `folke/live-preview.nvim` | Markdown 实时预览 |

## 关键配置说明

### 选项
| 设定 | 值 | 原因 |
|------|----|------|
| `tabstop` / `shiftwidth` | 2 | 前端/YAML 默认缩进 |
| `relativenumber` | true | 方便行移动 |
| `mouse` | a | WSL2 下鼠标选择/滚动 |
| `termguicolors` | true | WezTerm 支持真彩色 |
| `undo` | `~/.vim/undodir` | 自动创建，持久撤销 |
| `ttimeoutlen` | 50 | 终端序列超时，设为 0 会导致 `42c` 显示异常 |
| `clipboard` | wl-copy/wl-paste | Wayland 剪贴板互通 |
| `guicursor` | `blinkwait700-blinkon400-blinkoff250` | 光标闪烁 |

### 快捷键一览
| 键 | 模式 | 作用 |
|---|------|------|
| `<Space>` | — | Leader 键 |
| `<C-s>` | n / i | 保存 |
| `<C-c>` | n | 退出所有窗口（:qa） |
| `<leader>h` | n | 清除搜索高亮 |
| `<leader>pv` | n | 打开 netrw 文件浏览器 |
| `<leader>s` | n | 替换光标下单词 |
| `<leader>p` | x | 粘贴时不污染寄存器 |
| `<leader><leader>` | n | Telescope 搜文件名 |
| `<leader>fg` | n | Telescope 搜内容（grep） |
| `<leader>fb` | n | Telescope 切换缓冲区 |
| `<leader>fh` | n | Telescope 搜帮助文档 |
| `<leader>qs` | n | 恢复当前目录 session |
| `<leader>qS` | n | 选择 session 恢复 |
| `<leader>ql` | n | 恢复最近一次 session |
| `<C-h/j/k/l>` | n | 窗口导航 |
| `J`/`K` | v | 上下移动选中行 |
| `n`/`N` | n | 跳转后光标居中 |
| `<Esc>` | t | 退出终端模式 |
| `<A-m>` | i | 插入 `$$  $$` 行间公式 |
| `<A-s>` | i | 插入 `$` 行内公式 |

### 已排雷
- `ttimeoutlen = 0` → 导致终端 DA 序列被拆解，showcmd 显示 `42c`，光标变下划线
- `vim.cmd.colorscheme = "oxocarbon"` → 语法错误，应使用 `vim.cmd("colorscheme ...")`，且无插件时主题不存在
- VimEnter 中直接 `require("persistence")` 会找不到插件（lazy.nvim 未初始化完），必须用 `vim.schedule` 推迟


## 开发规范
- 保持零插件优先级：能内置就不装
- 新功能先在 `init.lua` 加，足够大了再拆到 `lua/` 下
- 每加一个插件前先问：内置方案真的不够？
- 快捷键定义原则：插件相关快捷键 → 写在该插件的 `keys` 字段内；编辑器全局快捷键（非插件特定）→ 写在 `lua/keymaps.lua`
- 编辑后手动用 `NVIM_APPNAME=nnvim nvim` 验证

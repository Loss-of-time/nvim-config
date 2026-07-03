vim.g.mapleader = " "

require("options")
require("keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
})
vim.cmd.colorscheme("tokyonight")

local win_group = vim.api.nvim_create_augroup("ActiveWindowHighlight", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = win_group,
  -- 进入窗口时清除覆盖，恢复 Normal 高亮
  callback = function() vim.wo.winhighlight = "" end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = win_group,
  -- 离开窗口时应用 NormalNC，背景变暗
  callback = function() vim.wo.winhighlight = "Normal:NormalNC" end,
})

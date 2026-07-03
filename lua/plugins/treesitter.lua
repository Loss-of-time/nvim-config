return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c", "lua", "vim", "vimdoc",
      "markdown", "markdown_inline",
      "python", "javascript", "typescript",
    },
    auto_install = true,
    highlight = { enable = true },
  },
}

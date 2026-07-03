return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    opts = {
      enable_autosnippets = true,
    },
  },
  {
    "LukasKorotaj/luasnip-markdown-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip" },
    config = true,
  },
}

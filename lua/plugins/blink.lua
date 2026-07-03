return {
  "saghen/blink.cmp",
  dependencies = { "saghen/blink.lib" },
  build = function()
    require("blink.cmp").build():pwait()
  end,
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_visible() then return cmp.select_and_accept()
          elseif cmp.snippet_active() then return cmp.accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<C-b>"] = { "fallback" }, -- 透传给 keymaps.lua <C-b> → Left
      ["<C-f>"] = { "fallback" }, -- 透传给 keymaps.lua <C-f> → Right
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    completion = { documentation = { auto_show = true } },
    snippets = { preset = "luasnip" },
    fuzzy = { implementation = "rust" },
  },
}

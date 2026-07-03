return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  event = "VeryLazy", -- 必须有 event，否则 keys 会让它懒加载，Telescope 打开文件时看不到标签栏
  opts = {
    options = {
      mode = "buffers",
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      color_icons = true,
      separator_style = "thin",
    },
  },
  keys = {
    { "<S-l>",       "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<S-h>",       "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "<leader>bd",  "<Cmd>bdelete!<CR>",            desc = "Close buffer" },
    { "<leader>bo",  "<Cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
  },
}

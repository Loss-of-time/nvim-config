return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader><leader>", ":Telescope find_files<CR>", desc = "find files" },
    { "<leader>fg", ":Telescope live_grep<CR>", desc = "grep" },
    { "<leader>fb", ":Telescope buffers<CR>", desc = "buffers" },
    { "<leader>fh", ":Telescope help_tags<CR>", desc = "help" },
  },
  opts = {},
}

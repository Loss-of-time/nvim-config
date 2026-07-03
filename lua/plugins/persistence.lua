return {
  "folke/persistence.nvim",
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    need = 1,
    branch = true,
  },
  keys = {
    {
      "<leader>qs",
      function() require("persistence").load() end,
      desc = "Load session for cwd",
    },
    {
      "<leader>qS",
      function() require("persistence").select() end,
      desc = "Select session",
    },
    {
      "<leader>ql",
      function() require("persistence").load({ last = true }) end,
      desc = "Load last session",
    },
  },
}

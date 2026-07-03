return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "clangd", "marksman" },
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)

    vim.lsp.enable("clangd")
    vim.lsp.enable("marksman")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("nnvim-lsp-format", { clear = true }),
      callback = function(args)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ bufnr = args.buf })
        end, { buffer = args.buf, noremap = true, silent = true, desc = "LSP format" })
      end,
    })
  end,
  dependencies = {
    { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },
    "neovim/nvim-lspconfig",
  },
}

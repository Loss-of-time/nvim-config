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
      group = vim.api.nvim_create_augroup("nnvim-lsp", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buf, noremap = true, silent = true, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "LSP definition")
        map("n", "gr", vim.lsp.buf.references, "LSP references")
        map("n", "gI", vim.lsp.buf.implementation, "LSP implementation")
        map("n", "gy", vim.lsp.buf.type_definition, "LSP type definition")
        map("n", "gl", vim.diagnostic.open_float, "LSP line diagnostics")
        map("n", "<leader>f", function()
          vim.lsp.buf.format({ bufnr = buf })
        end, "LSP format")
      end,
    })
  end,
  dependencies = {
    { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },
    "neovim/nvim-lspconfig",
  },
}

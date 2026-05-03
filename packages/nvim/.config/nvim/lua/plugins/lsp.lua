vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifierPreference = 'non-relative',
      },
    },
    javascript = {
      preferences = {
        importModuleSpecifierPreference = 'non-relative',
      },
    },
  },
})

return {
  { "neovim/nvim-lspconfig" },

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = { automatic_enable = true },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP servers
        "ts_ls",
        "gopls",
        "pyright",
        "tailwindcss",
        -- Formatters
        "prettierd",
        "prettier",
        "goimports",
        "ruff",
        "black",
        "stylua",
      },
    },
  },
}

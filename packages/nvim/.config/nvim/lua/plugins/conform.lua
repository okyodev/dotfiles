return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'W', 'FormatDisable', 'FormatEnable' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      desc = 'Code format',
    },
    {
      '<leader>W',
      '<cmd>noautocmd write<CR>',
      desc = 'Write without formatting',
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      jsonc = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      lua = { 'stylua' },
      go = { 'goimports', 'gofmt' },
      python = { 'ruff_format', 'black', stop_after_first = true },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
  },
  config = function(_, opts)
    require('conform').setup(opts)

    vim.api.nvim_create_user_command('W', 'noautocmd write', { desc = 'Write without formatting' })

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { desc = 'Disable autoformat-on-save', bang = true })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = 'Re-enable autoformat-on-save' })
  end,
}

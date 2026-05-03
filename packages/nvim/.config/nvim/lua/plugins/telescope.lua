return {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
  },
  config = function() 
    require('telescope').setup{}

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Telescope Buffers' })
    vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = 'Telescope Git status' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume,      { desc = 'Telescope resume' })
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Document symbols' })
  end
}

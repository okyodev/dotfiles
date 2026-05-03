return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- para los íconos
  },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'auto', -- se adapta a tu colorscheme
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          { 'branch', icon = '' },
          { 'diff' },
          { 'diagnostics' },
        },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    })
  end,
}

return {
  "aserowy/tmux.nvim",
  config = function()
    require("tmux").setup({
      copy_sync = {
        enable = false,
      },
      navigation = {
        enable_default_keybindings = true,
      },
      resize = {
        enable_default_keybindings = true,
        resize_step_x = 5,
        resize_step_y = 5,
      },
    })
  end,
}

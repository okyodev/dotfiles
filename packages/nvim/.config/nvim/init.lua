-- lazy.nvim (plugin manager)
require("config.lazy")

-- keymaps
require("config.keymaps")

-- colorscheme
vim.cmd("colorscheme retrolegends")
vim.o.winborder = "single"

-- Copy on the system clipboard
vim.opt.clipboard = "unnamedplus"

-- indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- setup mapleader
vim.g.mapleader = " "

-- scroll
-- vim.o.scroll = 3

-- search case-smart (case insensitive)
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- number column
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Auto-reload files changed outside of Neovim
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

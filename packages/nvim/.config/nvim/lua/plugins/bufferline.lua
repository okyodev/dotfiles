return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")

		local theme = require("config.theme")
		local transparent = { bg = theme.bg }
		local hl = {}
		local selected = { bg = theme.bg, fg = theme.fg, sp = theme.fg }

		-- transparent background
		for _, group in ipairs({
			"fill",
			"background",
			"buffer",
			"buffer_visible",
			"tab",
			"tab_close",
			"tab_separator",
			"tab_separator_selected",
			"close_button",
			"close_button_visible",
			"close_button_selected",
			"numbers",
			"numbers_visible",
			"diagnostic",
			"diagnostic_visible",
			"hint",
			"hint_visible",
			"hint_diagnostic",
			"hint_diagnostic_visible",
			"info",
			"info_visible",
			"info_diagnostic",
			"info_diagnostic_visible",
			"warning",
			"warning_visible",
			"warning_diagnostic",
			"warning_diagnostic_visible",
			"error",
			"error_visible",
			"error_diagnostic",
			"error_diagnostic_visible",
			"modified",
			"modified_visible",
			"modified_selected",
			"duplicate",
			"duplicate_visible",
			"duplicate_selected",
			"separator",
			"separator_visible",
			"separator_selected",
			"indicator_visible",
			"pick",
			"pick_visible",
			"pick_selected",
			"offset_separator",
			"trunc_marker",
			"group_separator",
			"group_label",
		}) do
			hl[group] = transparent
		end

		-- Selected tab style
		for _, group in ipairs({
			"buffer_selected",
			"tab_selected",
			"numbers_selected",
			"diagnostic_selected",
			"hint_selected",
			"hint_diagnostic_selected",
			"info_selected",
			"info_diagnostic_selected",
			"warning_selected",
			"warning_diagnostic_selected",
			"error_selected",
			"error_diagnostic_selected",
			"indicator_selected",
		}) do
			hl[group] = selected
		end

		bufferline.setup({
			highlights = hl,
			options = {
				style_preset = {
					bufferline.style_preset.no_italic,
					bufferline.style_preset.no_bold,
				},
				color_icons = false,
				separator_style = "thin",
				always_show_bufferline = false,

				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,

				show_close_icon = false,
				show_buffer_close_icons = false,
				hover = { enabled = false },
				indicator = { style = "underline" },
				offsets = {
					{
						filetype = "neo-tree",
						separator = true,
						highlight = "NeoTreeNormal",
					},
				},
			},
		})

		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
		vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
		vim.keymap.set("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "Close buffer" })
		vim.keymap.set("n", "<leader>bX", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close all buffers" })
		vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Pin buffer" })
		vim.keymap.set("n", "<leader>bl", "<silent>[b :BufferLineCycleNext<CR>", { desc = "Move right buffer" })
		vim.keymap.set("n", "<leader>bh", "<silent>b] :BufferLineCyclePrev", { desc = "Move left buffer" })
	end,
}

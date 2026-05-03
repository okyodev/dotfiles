return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = function()
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			local theme = require("config.theme")
			vim.api.nvim_set_hl(0, "IBLScope", { fg = theme.fg })
		end)

		return {
			scope = {
				enabled = true,
				char = "▏",
				highlight = { "IBLScope" },
				show_start = false,
				show_end = false,
				injected_languages = true,
			},
		}
	end,
}

return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	config = function()
		local theme = require("config.theme")

		vim.diagnostic.config({ virtual_text = false })
		require("tiny-inline-diagnostic").setup({
			preset = "simple",
			hi = {
				background = theme.bg,
				mixing_color = theme.bg,
			},
			signs = {
				diag = " ",
			},
			options = {
				multilines = {
					enabled = true,
					always_show = true,
				},
			},
		})
	end,
}

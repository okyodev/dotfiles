return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diff view" },
		{ "<leader>gD", "<cmd>DiffviewOpen HEAD~1<CR>", desc = "Diff prev commit" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
		{ "<leader>gq", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
	},
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"javascript",
			"typescript",
			"go",
			"python",
			"tsx",
			"markdown",
			"json",
			"css",
			"html",
			"bash",
		})
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}

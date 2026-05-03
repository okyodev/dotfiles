return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",

	config = function()
		require("gitsigns").setup({
			signs = {
				add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = {
					hl = "GitSignsChange",
					text = "│",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				topdelete = {
					hl = "GitSignsDelete",
					text = "‾",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "~",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			},
		})

		local gs = require("gitsigns")
		vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
		vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
		vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
		vim.keymap.set("n", "<leader>gb", gs.blame_line, { desc = "Blame line" })

		vim.keymap.set("n", "]g", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, { desc = "Next git hunk" })
		vim.keymap.set("n", "[g", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, { desc = "Previous git hunk" })

		vim.keymap.set("n", "<leader>gv", function()
			local file = vim.fn.expand("%:p")
			if file == "" then
				vim.notify("No file in current buffer", vim.log.levels.WARN)
				return
			end
			local cwd = vim.fn.fnamemodify(file, ":h")
			local diff = vim.fn.systemlist({ "git", "-C", cwd, "diff", "HEAD", "--", file })
			if vim.v.shell_error ~= 0 or #diff == 0 then
				vim.notify("No changes vs HEAD", vim.log.levels.INFO)
				return
			end
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, diff)
			vim.bo[buf].filetype = "diff"
			vim.bo[buf].modifiable = false
			local width = math.min(80, math.floor(vim.o.columns * 0.6))
			local height = math.min(#diff, math.floor(vim.o.lines * 0.4))
			vim.api.nvim_open_win(buf, true, {
				relative = "cursor",
				width = width,
				height = height,
				row = 1,
				col = 0,
				style = "minimal",
				border = "rounded",
				title = " Diff vs HEAD ",
				title_pos = "center",
			})
			vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
			vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = buf, silent = true })
		end, { desc = "View file diff vs HEAD (popup)" })
	end,
}

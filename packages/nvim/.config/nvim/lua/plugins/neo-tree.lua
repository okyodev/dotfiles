return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			commands = {
				copy_path = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local filename = node.name
					local modify = vim.fn.fnamemodify

					local results = {
						filepath,
						modify(filepath, ":."),
						modify(filepath, ":~"),
						filename,
						modify(filename, ":r"),
						modify(filename, ":e"),
					}

					local choices = {
						"Absolute path: " .. results[1],
						"Path relative to CWD: " .. results[2],
						"Path relative to HOME: " .. results[3],
						"Filename: " .. results[4],
						"Filename without extension: " .. results[5],
						"Extension of the filename: " .. results[6],
					}

					vim.ui.select(choices, { prompt = "Choose to copy to clipboard:" }, function(choice)
						if choice then
							for idx, c in ipairs(choices) do
								if c == choice then
									local result = results[idx]
									vim.fn.setreg("+", result)
									return
								end
							end
						end
					end)
				end,
			},
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
			window = {
				width = 30,
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["Y"] = "copy_path",
				},
			},
		})

		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle explorer" })
		vim.keymap.set("n", "<leader>ef", ":Neotree focus<CR>", { desc = "Focus explorer" })
		vim.keymap.set("n", "<leader>er", ":Neotree reveal<CR>", { desc = "Reveal current file" })
		vim.keymap.set("n", "<leader>eg", ":Neotree git_status<CR>", { desc = "Git status" })
		vim.keymap.set("n", "<leader>eb", ":Neotree buffers<CR>", { desc = "Buffers in explorer" })
	end,
}

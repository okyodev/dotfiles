vim.keymap.set("n", "gd", vim.lsp.buf.definition,     { desc = "Go to definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation,  { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references,      { desc = "Go to references" })
vim.keymap.set("n", "K",  vim.lsp.buf.hover,           { desc = "Hover docs" })
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename,   { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ float = false }) end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next({ float = false }) end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostic" })


vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<C-w>|", ":vsplit<CR>", { desc = "Split vertical (lado a lado)" })
vim.keymap.set("n", "<C-w>-", ":split<CR>",  { desc = "Split horizontal (arriba/abajo)" })

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")


map({ "n", "x", "v" }, "<C-Left>", "<cmd>:TmuxNavigateLeft<cr>", { silent = true, remap = false })
map({ "n", "x", "v" }, "<C-Right>", "<cmd>:TmuxNavigateRight<cr>", { silent = true, remap = false })
map({ "n", "x", "v" }, "<C-Down>", "<cmd>:TmuxNavigateDown<cr>", { silent = true, remap = false })
map({ "n", "x", "v" }, "<C-Up>", "<cmd>:TmuxNavigateUp<cr>", { silent = true, remap = false })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

map("n", "-", function()
	local buf_name = vim.api.nvim_buf_get_name(0)
	local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
	MiniFiles.open(path)
	MiniFiles.reveal_cwd()
end, { desc = "Open Mini Files" })

-- disable accidental Q key-press
map({ "n", "v" }, "q:", "<Nop>")
map("n", "Q", "<Nop>")

map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

map({ "n", "v", "x" }, "<leader>d", '"_d')

local opts = { noremap = true, silent = true }

-- vim.keymap.set('n', '<leader>t', ':nohlsearch<CR>', opts)

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<C,up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C,down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C,left", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C,right>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<A-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<A-h>", ":bprevious<CR>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

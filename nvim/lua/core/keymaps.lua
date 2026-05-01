local opts = { noremap = true, silent = true }

-- Clear search highlights
vim.keymap.set("n", "<leader>t", "<cmd>nohlsearch<CR>", opts)

-- System clipboard yank (explicit — deletes never touch clipboard)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
vim.keymap.set("n", "<leader>Y", [["+Y]], opts)

-- Paste without clobbering register
vim.keymap.set("x", "<leader>p", [["_dP]], opts)

-- Delete to black hole (keeps clipboard clean)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts)

-- Find and replace word under cursor
vim.keymap.set("n", "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Replace word under cursor" })

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", opts)

-- Keep cursor centered on scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Keep cursor centered on search navigation
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize splits
vim.keymap.set("n", "<C-Up>",    ":resize +2<CR>",          opts)
vim.keymap.set("n", "<C-Down>",  ":resize -2<CR>",          opts)
vim.keymap.set("n", "<C-Left>",  ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
vim.keymap.set("n", "<A-l>", ":bnext<CR>",          opts)
vim.keymap.set("n", "<A-h>", ":bprevious<CR>",      opts)
vim.keymap.set("n", "<leader>bd", "<cmd>bp|bd #<CR>", { desc = "Close buffer, keep split" })

-- Indent without leaving visual mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Start/end of line
vim.keymap.set({ "n", "v" }, "H", "^", opts)
vim.keymap.set({ "n", "v" }, "L", "$", opts)

-- Save
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", opts)

-- Quick access to config
vim.keymap.set("n", "<leader>ec", "<cmd>e ~/.config/nvim/init.lua<CR>", opts)

-- Diagnostics navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,  opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next,  opts)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

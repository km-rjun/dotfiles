local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Flash yanked text
autocmd("TextYankPost", {
    group = augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
    group = augroup("TrimWhitespace", { clear = true }),
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

-- Restore cursor position when reopening a file
autocmd("BufReadPost", {
    group = augroup("RestoreCursor", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})

-- YAML/Helm: 2-space indentation (k8s/ansible standard)
autocmd("FileType", {
    group = augroup("YamlIndent", { clear = true }),
    pattern = { "yaml", "yml", "helm" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

-- Auto-resize splits when terminal is resized
autocmd("VimResized", {
    group = augroup("AutoResize", { clear = true }),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Highlight line number colors after colorscheme loads
autocmd("ColorScheme", {
    group = augroup("LineNrColors", { clear = true }),
    callback = function()
        vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'gray', bold = false })
        vim.api.nvim_set_hl(0, 'LineNr',      { fg = 'white', bold = true })
        vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'gray', bold = false })
    end,
})

-- Close certain windows with just 'q'
autocmd("FileType", {
    group = augroup("QuickClose", { clear = true }),
    pattern = { "help", "lspinfo", "man", "notify", "qf", "startuptime" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
})

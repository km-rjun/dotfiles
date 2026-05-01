require("trouble").setup({
    modes = {
        diagnostics = {
            auto_open   = false,
            auto_close  = true,
            auto_preview = true,
        },
    },
    icons = {
        error       = "",
        warning     = "",
        hint        = "󰠠",
        information = "",
    },
})

local map = function(k, f, d)
    vim.keymap.set("n", k, f, { desc = d, silent = true, noremap = true })
end

map("<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",                          "Diagnostics (Trouble)")
map("<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>",            "Buffer Diagnostics (Trouble)")
map("<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>",                 "Symbols (Trouble)")
map("<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>",  "LSP Panel (Trouble)")
map("<leader>xL", "<cmd>Trouble loclist toggle<CR>",                             "Location List (Trouble)")
map("<leader>xQ", "<cmd>Trouble qflist toggle<CR>",                              "Quickfix List (Trouble)")

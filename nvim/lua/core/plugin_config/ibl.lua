require("ibl").setup({
    indent = {
        char = "│",
    },
    scope = {
        enabled   = true,
        highlight = "IblScope",
        show_start = true,
        show_end   = false,
    },
    exclude = {
        filetypes = { "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
    },
})

-- Subtle muted blue/gray that works with catppuccin mocha
vim.api.nvim_set_hl(0, "IblScope", { fg = "#585b70", bold = false })

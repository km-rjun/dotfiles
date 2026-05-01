require("conform").setup({
    formatters_by_ft = {
        lua        = { "stylua" },
        python     = { "black", "isort" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        markdown   = { "prettier" },
        sh         = { "shfmt" },
        bash       = { "shfmt" },
        terraform  = { "terraform_fmt" },
        hcl        = { "terraform_fmt" },
        go         = { "gofmt" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,   -- fall back to LSP format if no formatter configured
    },
})

-- Manual format keymap (overrides lsp buf.format)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer/selection" })

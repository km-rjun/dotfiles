require("todo-comments").setup({
    signs      = true,
    sign_priority = 8,
    keywords   = {
        FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = "󰍨 ", color = "hint",    alt = { "INFO" } },
    },
    highlight  = {
        before        = "",
        keyword       = "wide",
        after         = "fg",
        pattern       = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
    },
    search = {
        command = "rg",
        args = {
            "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column",
        },
        pattern = [[\b(KEYWORDS):]],
    },
})

-- Search TODO comments with telescope
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs" })

require("gitsigns").setup({
    signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
    },
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
        end, "Next Hunk")

        map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
        end, "Prev Hunk")

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk,        "Stage Hunk")
        map("n", "<leader>hr", gs.reset_hunk,        "Reset Hunk")
        map("n", "<leader>hS", gs.stage_buffer,      "Stage Buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk,   "Undo Stage Hunk")
        map("n", "<leader>hR", gs.reset_buffer,      "Reset Buffer")
        map("n", "<leader>hp", gs.preview_hunk,      "Preview Hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>hd", gs.diffthis,          "Diff This")
        map("n", "<leader>td2", gs.toggle_deleted,   "Toggle Deleted")
    end,
})

local telescope = require("telescope")
local builtin   = require("telescope.builtin")

telescope.setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config   = { preview_width = 0.55 },
        file_ignore_patterns = {
            "node_modules", ".git/", "dist/", "build/",
            "%.lock", "%.class", "%.jar",
        },
        -- Use vim regex highlighting in previewer instead of treesitter.
        -- Treesitter is lazy and may not be ready when telescope opens,
        -- which causes the ft_to_lang nil error.
        preview = {
            treesitter = false,
        },
    },
    pickers = {
        find_files = { hidden = true },
    },
    extensions = {
        fzf = {
            fuzzy                   = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode               = "smart_case",
        },
    },
})

telescope.load_extension("fzf")

local map = function(k, f, d)
    vim.keymap.set("n", k, f, { desc = d })
end

map("<leader>ff", builtin.find_files,           "Find Files")
map("<leader>fg", builtin.live_grep,            "Live Grep")
map("<leader>fb", builtin.buffers,              "Find Buffers")
map("<leader>fh", builtin.help_tags,            "Help Tags")
map("<leader>fd", builtin.diagnostics,          "Diagnostics")
map("<leader>fr", builtin.lsp_references,       "LSP References")
map("<leader>fs", builtin.lsp_document_symbols, "Document Symbols")
map("<leader>fc", builtin.git_commits,          "Git Commits")
map("<leader>fo", builtin.oldfiles,             "Recent Files")
map("<leader>fw", builtin.grep_string,          "Grep Word Under Cursor")
map("<leader>ft", "<cmd>TodoTelescope<CR>",     "Find TODOs")

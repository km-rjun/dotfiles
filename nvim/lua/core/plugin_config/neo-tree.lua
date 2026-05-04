vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

require("neo-tree").setup({
    close_if_last_window = true,
    popup_border_style   = "rounded",
    enable_git_status    = true,
    enable_diagnostics   = true,

    window = {
        width    = 50,
        position = "right",
        mappings = {
            ["<space>"] = "none",
        },
    },

    filesystem = {
        filtered_items = {
            visible       = false,
            hide_dotfiles = false,
            hide_gitignored = true,
        },
        follow_current_file  = { enabled = true },
        use_libuv_file_watcher = true,
    },

    buffers = {
        follow_current_file = { enabled = true },
    },

    git_status = {
        window = { position = "float" },
    },

    default_component_configs = {
        git_status = {
            symbols = {
                added     = "✚",
                modified  = "",
                deleted   = "✖",
                renamed   = "󰁕",
                untracked = "",
                ignored   = "",
                unstaged  = "󰄱",
                staged    = "",
                conflict  = "",
            },
        },
    },
})

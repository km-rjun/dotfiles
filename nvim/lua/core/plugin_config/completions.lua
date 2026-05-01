local kind_icons = {
    Text          = "󰉿",
    Method        = "󰆧",
    Function      = "󰊕",
    Constructor   = "",
    Field         = " ",
    Variable      = "󰀫",
    Class         = "󰠱",
    Interface     = "",
    Module        = "",
    Property      = "󰜢",
    Unit          = "󰑭",
    Value         = "󰎠",
    Enum          = "",
    Keyword       = "󰌋",
    Snippet       = "",
    Color         = "󰏘",
    File          = "󰈙",
    Reference     = "",
    Folder        = "󰉋",
    EnumMember    = "",
    Constant      = "󰏿",
    Struct        = "",
    Event         = "",
    Operator      = "󰆕",
    TypeParameter = " ",
}

require("blink.cmp").setup({
    -- Use stable v1 release
    -- Keymaps matching your original nvim-cmp layout
    keymap = {
        preset        = 'none',
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>']     = { 'cancel', 'fallback' },
        ['<CR>']      = { 'accept', 'fallback' },
        ['<C-k>']     = { 'select_prev', 'fallback' },
        ['<C-j>']     = { 'select_next', 'fallback' },
        ['<C-b>']     = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>']     = { 'scroll_documentation_down', 'fallback' },
        ['<Tab>']     = { 'snippet_forward', 'select_next', 'fallback' },
        ['<S-Tab>']   = { 'snippet_backward', 'select_prev', 'fallback' },
    },

    appearance = {
        use_nvim_cmp_as_default = true,  -- makes menu look like nvim-cmp
        nerd_font_variant       = "mono",
    },

    completion = {
        documentation = {
            auto_show          = true,
            auto_show_delay_ms = 200,
            window = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            },
        },
        menu = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            draw   = {
                columns   = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            return (kind_icons[ctx.kind] or "") .. " "
                        end,
                    },
                    source_name = {
                        text = function(ctx)
                            local labels = {
                                lsp      = "[LSP]",
                                buffer   = "[Buffer]",
                                path     = "[Path]",
                                snippets = "[Snippet]",
                            }
                            return labels[ctx.source_name] or ("[" .. ctx.source_name .. "]")
                        end,
                    },
                },
            },
        },
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    snippets = { preset = "default" },

    fuzzy = { implementation = "prefer_rust_with_warning" },

    signature = { enabled = true },
})

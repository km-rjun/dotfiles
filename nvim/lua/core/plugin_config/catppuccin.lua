-- catppuccin must be setup + colorscheme applied BEFORE lualine/bufferline
-- initialize. We do NOT require other plugin configs here — Lazy handles
-- ordering via priority. This file only sets up catppuccin itself.
require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    dim_inactive = {
        enabled    = true,
        shade      = "dark",
        percentage = 2,
    },
    integrations = {
        bufferline         = true,
        cmp                = true,
        gitsigns           = true,
        neotree            = true,
        telescope          = { enabled = true },
        treesitter         = true,
        treesitter_context = true,
        indent_blankline   = { enabled = true, scope_color = "lavender" },
        rainbow_delimiters = true,
        lsp_trouble        = true,
        mini               = { enabled = true },
        which_key          = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors      = { "italic" },
                hints       = { "italic" },
                warnings    = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors      = { "underline" },
                hints       = { "underline" },
                warnings    = { "underline" },
                information = { "underline" },
            },
        },
    },
})

vim.cmd.colorscheme("catppuccin")

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'gray',  bold = false })
vim.api.nvim_set_hl(0, 'LineNr',      { fg = 'white', bold = true  })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'gray',  bold = false })

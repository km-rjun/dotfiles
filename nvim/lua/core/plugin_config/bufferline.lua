require("bufferline").setup({
    options = {
        mode              = "buffers",
        separator_style   = "slant",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon   = false,
        color_icons       = true,
        diagnostics       = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
            local icons = { error = " ", warning = " " }
            local ret = (diag.error and icons.error .. diag.error .. " " or "")
                     .. (diag.warning and icons.warning .. diag.warning or "")
            return vim.trim(ret)
        end,
        offsets = {
            {
                filetype   = "neo-tree",
                text       = "File Explorer",
                highlight  = "Directory",
                separator  = true,
            },
        },
    },
})

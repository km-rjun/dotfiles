require("bufferline").setup{
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = function()
                    return vim.fn.getcwd()
                end,
                highlight = "Directory",
                text_align = "left"
            }
        },
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
        end,
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        }
    },
}

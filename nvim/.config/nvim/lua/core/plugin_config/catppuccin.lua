require("catppuccin").setup({
    transparent_background = true,
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 2,
    },
})
vim.cmd.colorscheme "catppuccin"
function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='gray', bold=false })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='gray', bold=false })
end
LineNumberColors()

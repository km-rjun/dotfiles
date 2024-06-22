require("catppuccin").setup({
	transparent_background = true,
	 dim_inactive = {
		 enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15,
},
})

vim.cmd.colorscheme "catppuccin"

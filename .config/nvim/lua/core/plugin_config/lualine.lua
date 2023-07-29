require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'dracula',
	},
	selections = {
		lualine_a = {
			{
			'filename',
			path = 1,
			}
		}
	}
}

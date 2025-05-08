local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
	'nvim-tree/nvim-tree.lua',
	'nvim-tree/nvim-web-devicons',
    'windwp/nvim-autopairs',
	'nvim-treesitter/nvim-treesitter',
	'nvim-lualine/lualine.nvim',
	'catppuccin/nvim', as = 'catppuccin',
    'akinsho/bufferline.nvim',
    'lewis6991/gitsigns.nvim',

    -- LSP support
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- autocompletion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',

    -- snippets
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },

    {
        'norcalli/nvim-colorizer.lua',
    },

    {
        "jiaoshijie/undotree",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
        keys = { -- load the plugin only when using it's keybinding:
            { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },

    {
        'numToStr/Comment.nvim',
        opts = {
        },
        lazy = false,
    }

}

local opts = {}
require("lazy").setup(plugins, opts)

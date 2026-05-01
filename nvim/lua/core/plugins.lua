local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local buf_events = { "BufReadPre", "BufNewFile" }

local plugins = {

    -- ── Pure dependencies ────────────────────────────────────────────────
    { 'nvim-lua/plenary.nvim',       lazy = true },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
    { 'MunifTanjim/nui.nvim',        lazy = true },

    -- ── Colorscheme ──────────────────────────────────────────────────────
    {
        'catppuccin/nvim',
        name     = 'catppuccin',
        priority = 1000,
        lazy     = false,
        config   = function() require("core.plugin_config.catppuccin") end,
    },

    -- ── Status & buffer line ─────────────────────────────────────────────
    {
        'nvim-lualine/lualine.nvim',
        lazy         = false,
        priority     = 900,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config       = function() require("core.plugin_config.lualine") end,
    },
    {
        'akinsho/bufferline.nvim',
        lazy         = false,
        priority     = 900,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config       = function() require("core.plugin_config.bufferline") end,
    },

    -- ── Treesitter ───────────────────────────────────────────────────────
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy   = false,
        build  = ':TSUpdate',
        opts   = {
            ensure_installed = {
                "c", "lua", "rust", "vim", "vimdoc", "cpp", "css",
                "bash", "python", "yaml", "json", "toml", "hcl",
                "dockerfile", "go", "javascript", "typescript", "query",
            },
            highlight = { enable = true },
            indent    = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)
        end,
    },

    -- ── Flash (smart jump motions) ───────────────────────────────────────
    {
        'folke/flash.nvim',
        event = buf_events,
        keys  = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump()              end, desc = "Flash Jump" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter()        end, desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote()            end, desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Flash Treesitter Search" },
        },
    },

    -- ── Indent / scope lines ─────────────────────────────────────────────
    {
        'lukas-reineke/indent-blankline.nvim',
        main   = 'ibl',
        event  = buf_events,
        config = function() require("core.plugin_config.ibl") end,
    },

    -- ── Which-key ────────────────────────────────────────────────────────
    {
        'folke/which-key.nvim',
        event  = 'VeryLazy',
        config = function() require("core.plugin_config.which-key") end,
    },

    -- ── Trouble ──────────────────────────────────────────────────────────
    {
        'folke/trouble.nvim',
        cmd          = { 'Trouble' },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config       = function() require("core.plugin_config.trouble") end,
    },

    -- ── TODO comments ────────────────────────────────────────────────────
    {
        'folke/todo-comments.nvim',
        event        = buf_events,
        dependencies = { 'nvim-lua/plenary.nvim' },
        config       = function() require("core.plugin_config.todo-comments") end,
    },

    -- ── Neo-tree ─────────────────────────────────────────────────────────
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        cmd    = { 'Neotree' },
        keys   = {
            { '<leader>tr', '<cmd>Neotree toggle<CR>',         desc = 'Toggle file tree' },
            { '<leader>tf', '<cmd>Neotree reveal<CR>',         desc = 'Reveal file in tree' },
            { '<leader>tg', '<cmd>Neotree git_status<CR>',     desc = 'Neo-tree git status' },
            { '<leader>tb', '<cmd>Neotree buffers reveal<CR>', desc = 'Neo-tree buffers' },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        },
        config = function() require("core.plugin_config.neo-tree") end,
    },

    -- ── Telescope ────────────────────────────────────────────────────────
    {
        'nvim-telescope/telescope.nvim',
        tag  = '0.1.8',
        cmd  = { 'Telescope' },
        keys = {
            { '<leader>ff', desc = 'Find Files' },
            { '<leader>fg', desc = 'Live Grep' },
            { '<leader>fb', desc = 'Find Buffers' },
            { '<leader>fh', desc = 'Help Tags' },
            { '<leader>fd', desc = 'Diagnostics' },
            { '<leader>fr', desc = 'LSP References' },
            { '<leader>fs', desc = 'Document Symbols' },
            { '<leader>fc', desc = 'Git Commits' },
            { '<leader>fo', desc = 'Recent Files' },
            { '<leader>fw', desc = 'Grep Word' },
            { '<leader>ft', desc = 'Find TODOs' },
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true },
        },
        config = function() require("core.plugin_config.telescope") end,
    },

    -- ── Mason (must NOT be lazy — needs to modify PATH at startup) ────────
    {
        'mason-org/mason.nvim',
        lazy     = false,
        priority = 800,
        config   = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons  = {
                        package_installed   = "✓",
                        package_pending     = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    -- ── Mason tool installer (formatters + linters) ───────────────────────
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        lazy         = false,
        dependencies = { 'mason-org/mason.nvim' },
        config       = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- LSP servers
                    "lua-language-server",
                    "rust-analyzer",
                    "pyright",
                    "typescript-language-server",
                    "bash-language-server",
                    "yaml-language-server",
                    "terraform-ls",
                    "dockerfile-language-server",
                    "docker-compose-language-service",
                    -- Formatters
                    "stylua",
                    "black",
                    "isort",
                    "shfmt",
                    "prettier",
                    -- Linters
                    "yamllint",
                    "shellcheck",
                    "hadolint",
                    "tflint",
                },
                auto_update    = false,
                run_on_start   = true,
                debounce_hours = 24,
            })
        end,
    },

    -- ── LSP ──────────────────────────────────────────────────────────────
    {
        'neovim/nvim-lspconfig',
        event        = buf_events,
        dependencies = {
            'mason-org/mason.nvim',
            {
                'mason-org/mason-lspconfig.nvim',
                lazy = true,
            },
        },
        config = function() require("core.plugin_config.lsp_config") end,
    },

    -- ── Completion (blink.cmp replaces nvim-cmp) ──────────────────────────
    {
        'saghen/blink.cmp',
        version      = '1.*',
        event        = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = { 'rafamadriz/friendly-snippets' },
        config       = function() require("core.plugin_config.completions") end,
    },

    -- ── Formatting ───────────────────────────────────────────────────────
    {
        'stevearc/conform.nvim',
        event  = buf_events,
        config = function() require("core.plugin_config.conform") end,
    },

    -- ── Linting ──────────────────────────────────────────────────────────
    {
        'mfussenegger/nvim-lint',
        event  = buf_events,
        config = function() require("core.plugin_config.lint") end,
    },

    -- ── Git ──────────────────────────────────────────────────────────────
    {
        'lewis6991/gitsigns.nvim',
        event  = buf_events,
        config = function() require("core.plugin_config.gitsigns") end,
    },
    {
        'kdheepak/lazygit.nvim',
        cmd          = {
            'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile',
            'LazyGitFilter', 'LazyGitFilterCurrentFile',
        },
        keys         = { { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' } },
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
        config       = function()
            require('telescope').load_extension('lazygit')
        end,
    },

    -- ── Editing helpers ───────────────────────────────────────────────────
    {
        'windwp/nvim-autopairs',
        event  = 'InsertEnter',
        config = function() require("core.plugin_config.autopairs") end,
    },
    {
        'numToStr/Comment.nvim',
        event  = buf_events,
        config = function() require('Comment').setup() end,
    },
    {
        'echasnovski/mini.surround',
        version = '*',
        keys    = { 'sa', 'sd', 'sr', 'sf', 'sF', 'sh', 'sn' },
        config  = function() require("core.plugin_config.mini-surround") end,
    },

    -- ── Color preview ─────────────────────────────────────────────────────
    {
        'brenoprata10/nvim-highlight-colors',
        event  = buf_events,
        config = function() require("core.plugin_config.colorizer") end,
    },

    -- ── Undo tree ─────────────────────────────────────────────────────────
    {
        'jiaoshijie/undotree',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys         = {
            { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>", desc = 'Toggle Undotree' },
        },
        config = function() require("core.plugin_config.undotree") end,
    },

    -- ── DevOps ────────────────────────────────────────────────────────────
    { 'hashivim/vim-terraform', ft = { 'terraform', 'hcl', 'tf' } },
    { 'towolf/vim-helm',        ft = { 'helm', 'yaml' } },
    {
        'cuducos/yaml.nvim',
        ft           = { 'yaml', 'yml' },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-telescope/telescope.nvim' },
    },

    -- ── Tmux navigation ───────────────────────────────────────────────────
    { 'christoomey/vim-tmux-navigator', lazy = false },
}

require('lazy').setup(plugins, {
    checker          = { enabled = true, notify = false },
    change_detection = { notify = false },
    performance      = {
        rtp = {
            disabled_plugins = {
                "gzip", "matchit", "matchparen", "netrwPlugin",
                "tarPlugin", "tohtml", "tutor", "zipPlugin",
            },
        },
    },
})

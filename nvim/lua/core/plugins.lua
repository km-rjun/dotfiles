-- Native plugin manager (vim.pack, built into Neovim 0.12+ — no bootstrap
-- needed). See `lua/core/pack_loader.lua` for the lazy-loading layer on top
-- of it (vim.pack itself only installs/updates/loads; it has no event/ft/
-- cmd/keys lazy triggers like lazy.nvim did).
--
-- Everything not needed to draw the first frame is lazy-loaded so startup
-- stays fast: plugins are only `:packadd`-ed (and their config run) the
-- first time their event/filetype/command/keymap actually fires.

local pack = require("core.pack_loader")

-- Disable unneeded bundled runtime plugins (must happen before Nvim's own
-- automatic plugin-sourcing phase, which runs right after init.lua).
for _, name in ipairs({
	"gzip",
	"matchit",
	"matchparen",
	"netrw",
	"netrwPlugin",
	"tarPlugin",
	"tohtml",
	"tutor",
	"zipPlugin",
}) do
	vim.g["loaded_" .. name] = 1
end

local function gh(repo)
	return "https://github.com/" .. repo
end

local buf_events = { "BufReadPre", "BufNewFile" }

-- Register build hooks BEFORE the installing `vim.pack.add()` call below —
-- PackChanged can fire for a plugin's very first install during that call.
pack.on_build("nvim-treesitter", function()
	-- main branch dropped the `:TSUpdate` Ex command for a pure Lua API.
	vim.schedule(function()
		require("nvim-treesitter").update()
	end)
end)
pack.on_build("telescope-fzf-native.nvim", function(path)
	vim.system({ "make" }, { cwd = path })
end)

-- Install (if needed) + make every plugin reachable via require() on
-- 'runtimepath'. `load = false` means none of them are actually `:packadd`ed
-- (plugin/ftdetect/after scripts NOT sourced) yet — see pack_loader.lua for
-- what upgrades each one to fully loaded, and when.
vim.pack.add({
	-- Pure dependencies (never need their own `:packadd`; consumers just
	-- `require()` them once *they* load)
	{ src = gh("nvim-lua/plenary.nvim") },
	{ src = gh("nvim-tree/nvim-web-devicons") },
	{ src = gh("MunifTanjim/nui.nvim") },
	{ src = gh("rafamadriz/friendly-snippets") },
	{ src = gh("mason-org/mason-lspconfig.nvim") },

	-- Eager (needed at/near startup)
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	{ src = gh("nvim-lualine/lualine.nvim") },
	{ src = gh("akinsho/bufferline.nvim") },
	{ src = gh("nvim-treesitter/nvim-treesitter"), name = "nvim-treesitter", version = "main" },
	{ src = gh("mason-org/mason.nvim") },
	{ src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },
	{ src = gh("christoomey/vim-tmux-navigator") },

	-- Lazy (installed now, loaded on first real use — see triggers below)
	{ src = gh("folke/flash.nvim") },
	{ src = gh("lukas-reineke/indent-blankline.nvim"), name = "indent-blankline.nvim" },
	{ src = gh("folke/which-key.nvim") },
	{ src = gh("folke/trouble.nvim") },
	{ src = gh("folke/todo-comments.nvim") },
	{ src = gh("nvim-neo-tree/neo-tree.nvim"), version = "v3.x" },
	{ src = gh("nvim-telescope/telescope.nvim"), version = "0.1.8" },
	{ src = gh("nvim-telescope/telescope-fzf-native.nvim") },
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("1") },
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("mfussenegger/nvim-lint") },
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("kdheepak/lazygit.nvim") },
	{ src = gh("windwp/nvim-autopairs") },
	{ src = gh("numToStr/Comment.nvim") },
	{ src = gh("echasnovski/mini.surround"), version = vim.version.range("*") },
	{ src = gh("brenoprata10/nvim-highlight-colors") },
	{ src = gh("jiaoshijie/undotree"), name = "undotree" },
	{ src = gh("hashivim/vim-terraform") },
	{ src = gh("towolf/vim-helm") },
	{ src = gh("cuducos/yaml.nvim") },
	{ src = gh("jtprogru/pack-ui.nvim") },
}, { load = false, confirm = false })

-- ── Eager plugins ────────────────────────────────────────────────────────
-- catppuccin must be ready + colorscheme applied before lualine/bufferline.
pack.now("catppuccin", function()
	require("core.plugin_config.catppuccin")
end)
pack.now("lualine.nvim", function()
	require("core.plugin_config.lualine")
end)
pack.now("bufferline.nvim", function()
	require("core.plugin_config.bufferline")
end)
pack.now("nvim-treesitter", function()
	require("nvim-treesitter").setup({
		ensure_installed = {
			"c",
			"lua",
			"rust",
			"vim",
			"vimdoc",
			"cpp",
			"css",
			"bash",
			"python",
			"yaml",
			"json",
			"toml",
			"hcl",
			"dockerfile",
			"go",
			"javascript",
			"typescript",
			"query",
		},
		highlight = { enable = true },
		indent = { enable = true },
	})
end)
-- Mason must NOT be lazy — needs to modify $PATH at startup.
pack.now("mason.nvim", function()
	require("mason").setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})
end)
pack.now("mason-tool-installer.nvim", function()
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
		auto_update = false,
		run_on_start = true,
		debounce_hours = 24,
	})
end)
pack.now("vim-tmux-navigator")

-- ── Lazy: on first relevant buffer (read/new file) ──────────────────────
pack.on_event("indent-blankline.nvim", function()
	require("core.plugin_config.ibl")
end, buf_events)
pack.on_event("todo-comments.nvim", function()
	require("core.plugin_config.todo-comments")
end, buf_events)
pack.on_event("nvim-lspconfig", function()
	require("core.plugin_config.lsp_config")
end, buf_events)
pack.on_event("conform.nvim", function()
	require("core.plugin_config.conform")
end, buf_events)
pack.on_event("nvim-lint", function()
	require("core.plugin_config.lint")
end, buf_events)
pack.on_event("gitsigns.nvim", function()
	require("core.plugin_config.gitsigns")
end, buf_events)
pack.on_event("Comment.nvim", function()
	require("Comment").setup()
end, buf_events)
pack.on_event("nvim-highlight-colors", function()
	require("core.plugin_config.colorizer")
end, buf_events)

-- flash.nvim: whichever comes first — a buffer being read, or one of its
-- own keys being pressed on an empty/no-name buffer before that ever fires.
local flash_keys = {
	{ "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash Jump" },
	{ "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
	{ "r", function() require("flash").remote() end, mode = "o", desc = "Remote Flash" },
	{ "R", function() require("flash").treesitter_search() end, mode = { "o", "x" }, desc = "Flash Treesitter Search" },
}
pack.on_event("flash.nvim", nil, buf_events)
pack.on_keys("flash.nvim", nil, flash_keys)

-- ── Lazy: on insert ──────────────────────────────────────────────────────
pack.on_event("nvim-autopairs", function()
	require("core.plugin_config.autopairs")
end, "InsertEnter")
pack.on_event("blink.cmp", function()
	require("core.plugin_config.completions")
end, { "InsertEnter", "CmdlineEnter" })

-- ── Lazy: VeryLazy equivalent ────────────────────────────────────────────
pack.on_very_lazy("which-key.nvim", function()
	require("core.plugin_config.which-key")
end)

-- ── Lazy: on command ─────────────────────────────────────────────────────
pack.on_cmd("trouble.nvim", function()
	require("core.plugin_config.trouble")
end, { "Trouble" })

pack.on_cmd("neo-tree.nvim", function()
	require("core.plugin_config.neo-tree")
end, { "Neotree" })
pack.on_keys("neo-tree.nvim", function()
	require("core.plugin_config.neo-tree")
end, {
	{ "<leader>tr", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
	{ "<leader>tf", "<cmd>Neotree reveal<CR>", desc = "Reveal file in tree" },
	{ "<leader>tg", "<cmd>Neotree git_status<CR>", desc = "Neo-tree git status" },
	{ "<leader>tb", "<cmd>Neotree buffers reveal<CR>", desc = "Neo-tree buffers" },
})

local function telescope_config()
	require("core.plugin_config.telescope")
end
pack.on_cmd("telescope.nvim", telescope_config, { "Telescope" })
pack.on_keys("telescope.nvim", telescope_config, {
	{ "<leader>ff", nil, desc = "Find Files" },
	{ "<leader>fg", nil, desc = "Live Grep" },
	{ "<leader>fb", nil, desc = "Find Buffers" },
	{ "<leader>fh", nil, desc = "Help Tags" },
	{ "<leader>fd", nil, desc = "Diagnostics" },
	{ "<leader>fr", nil, desc = "LSP References" },
	{ "<leader>fs", nil, desc = "Document Symbols" },
	{ "<leader>fc", nil, desc = "Git Commits" },
	{ "<leader>fo", nil, desc = "Recent Files" },
	{ "<leader>fw", nil, desc = "Grep Word" },
	{ "<leader>ft", nil, desc = "Find TODOs" },
})

local function lazygit_config()
	-- lazygit.nvim needs telescope loaded first for load_extension to work.
	pack.load("telescope.nvim", telescope_config)
	require("telescope").load_extension("lazygit")
end
pack.on_cmd("lazygit.nvim", lazygit_config, {
	"LazyGit",
	"LazyGitConfig",
	"LazyGitCurrentFile",
	"LazyGitFilter",
	"LazyGitFilterCurrentFile",
})
pack.on_keys("lazygit.nvim", lazygit_config, {
	{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
})

-- ── Lazy: on keys only ───────────────────────────────────────────────────
pack.on_keys("undotree", function()
	require("core.plugin_config.undotree")
end, {
	{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle Undotree" },
})
pack.on_keys("mini.surround", function()
	require("core.plugin_config.mini-surround")
end, {
	{ "sa" }, { "sd" }, { "sr" }, { "sf" }, { "sF" }, { "sh" }, { "sn" },
})

-- ── Lazy: on filetype ────────────────────────────────────────────────────
pack.on_ft("vim-terraform", nil, { "terraform", "hcl", "tf" })
pack.on_ft("vim-helm", nil, { "helm", "yaml" })
pack.on_ft("yaml.nvim", nil, { "yaml", "yml" })

-- ── Lazy: UI for vim.pack itself (status/update dashboard) ──────────────
pack.on_cmd("pack-ui.nvim", function()
	require("pack_ui").setup()
end, { "PackStatus", "PackUpdate", "PackUpdateAll" })

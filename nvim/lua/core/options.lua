vim.g.mapleader   = ' '
vim.g.localleader = ' '

-- UI
vim.opt.termguicolors  = true
vim.opt.number         = true
vim.opt.numberwidth    = 1
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.signcolumn     = "yes"
vim.opt.wrap           = false
vim.opt.scrolloff      = 8
vim.opt.splitbelow     = true
vim.opt.splitright     = true
vim.opt.list           = true
vim.opt.listchars      = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand     = "split"    -- live preview of substitutions in a split
vim.opt.smoothscroll   = true       -- smooth scrolling through wrapped lines

-- Folding (treesitter-based)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr   = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel  = 99             -- start with everything unfolded
vim.opt.foldenable = false          -- don't auto-fold on open

-- Indentation
vim.opt.smarttab    = true
vim.opt.smartindent = true
vim.opt.expandtab   = true
vim.opt.shiftwidth  = 4
vim.opt.tabstop     = 4
vim.opt.autoindent  = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase  = true

-- Performance
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Files
vim.opt.swapfile = false
vim.opt.backup   = false
vim.opt.undofile = true
vim.opt.undodir  = vim.fn.stdpath("data") .. "/undodir"
vim.opt.isfname:append("@-@")

-- Per-project local config: if a .nvim.lua exists in the cwd, source it
vim.opt.exrc = true

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.plugins")

local ok, matugen = pcall(require, 'matugen')
if ok then matugen.setup() end

 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1a2023',
    base01 = '#2b353b',
    base02 = '#262f36',
    base03 = '#616b71',
    base04 = '#afb3b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#937ab8',
    base0A = '#7a80b8',
    base0B = '#8babc1',
    base0C = '#bbacd3',
    base0D = '#acc3d3',
    base0E = '#acb0d3',
    base0F = '#cdcfe4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#1a2023' })
  hi('TelescopeBorder',         { fg = '#616b71',             bg = '#1a2023' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#1a2023' })
  hi('TelescopePromptBorder',   { fg = '#616b71',             bg = '#1a2023' })
  hi('TelescopePromptPrefix',   { fg = '#8babc1',             bg = '#1a2023' })
  hi('TelescopePromptCounter',  { fg = '#afb3b6',  bg = '#1a2023' })
  hi('TelescopePromptTitle',    { fg = '#1a2023',             bg = '#8babc1' })
  hi('TelescopePreviewTitle',   { fg = '#1a2023',             bg = '#7a80b8' })
  hi('TelescopeResultsTitle',   { fg = '#1a2023',             bg = '#937ab8' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#262f36' })
  hi('TelescopeSelectionCaret', { fg = '#8babc1',             bg = '#262f36' })
  hi('TelescopeMatching',       { fg = '#8babc1',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#1a2023' })
  hi('MiniPickBorder',         { fg = '#616b71',             bg = '#1a2023' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#1a2023' })
  hi('MiniPickPromptPrefix',   { fg = '#8babc1',             bg = '#1a2023' })
  hi('MiniPickBorderText',    { fg = '#1a2023',             bg = '#8babc1' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#262f36' })
  hi('MiniPickPromptCaret', { fg = '#8babc1',             bg = '#262f36' })
  hi('MiniPickMatchRanges',       { fg = '#8babc1',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M

 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1a1d23',
    base01 = '#2b303b',
    base02 = '#262b36',
    base03 = '#626872',
    base04 = '#afb1b6',
    base05 = '#f2f2f3',
    base06 = '#f2f2f3',
    base07 = '#f2f2f3',
    base08 = '#fd4663',
    base09 = '#9f85ad',
    base0A = '#8981b1',
    base0B = '#8b9dc1',
    base0C = '#c4afd0',
    base0D = '#acb9d3',
    base0E = '#b4afd0',
    base0F = '#d1cde4',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#f2f2f3',          bg = '#1a1d23' })
  hi('TelescopeBorder',         { fg = '#626872',             bg = '#1a1d23' })
  hi('TelescopePromptNormal',   { fg = '#f2f2f3',          bg = '#1a1d23' })
  hi('TelescopePromptBorder',   { fg = '#626872',             bg = '#1a1d23' })
  hi('TelescopePromptPrefix',   { fg = '#8b9dc1',             bg = '#1a1d23' })
  hi('TelescopePromptCounter',  { fg = '#afb1b6',  bg = '#1a1d23' })
  hi('TelescopePromptTitle',    { fg = '#1a1d23',             bg = '#8b9dc1' })
  hi('TelescopePreviewTitle',   { fg = '#1a1d23',             bg = '#8981b1' })
  hi('TelescopeResultsTitle',   { fg = '#1a1d23',             bg = '#9f85ad' })
  hi('TelescopeSelection',      { fg = '#f2f2f3',          bg = '#262b36' })
  hi('TelescopeSelectionCaret', { fg = '#8b9dc1',             bg = '#262b36' })
  hi('TelescopeMatching',       { fg = '#8b9dc1',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#f2f2f3',          bg = '#1a1d23' })
  hi('MiniPickBorder',         { fg = '#626872',             bg = '#1a1d23' })
  hi('MiniPickPrompt',   { fg = '#f2f2f3',          bg = '#1a1d23' })
  hi('MiniPickPromptPrefix',   { fg = '#8b9dc1',             bg = '#1a1d23' })
  hi('MiniPickBorderText',    { fg = '#1a1d23',             bg = '#8b9dc1' })
  hi('MiniPickMatchCurrent',      { fg = '#f2f2f3',          bg = '#262b36' })
  hi('MiniPickPromptCaret', { fg = '#8b9dc1',             bg = '#262b36' })
  hi('MiniPickMatchRanges',       { fg = '#8b9dc1',             bold = true })
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

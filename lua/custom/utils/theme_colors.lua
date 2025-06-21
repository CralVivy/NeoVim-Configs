-- lua/custom/utils/theme_colors.lua
local M = {}

-- Get foreground color of a highlight group
function M.get_fg(group)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if hl and hl.fg then
    return string.format('#%06x', hl.fg)
  end
end

-- Get background color of a highlight group
function M.get_bg(group)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if hl and hl.bg then
    return string.format('#%06x', hl.bg)
  end
end

return M

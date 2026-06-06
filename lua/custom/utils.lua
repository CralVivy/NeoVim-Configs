-- lua/custom/utils.lua
local M = {}

-- Smart buffer deletion to preserve layout (Neo-tree stays docked)
function M.smart_buf_delete()
  local cur_buf = vim.api.nvim_get_current_buf()
  local alt_buf = vim.fn.bufnr '#'

  -- If there's no alternate buffer, go to next or create a new one
  if alt_buf < 1 or not vim.api.nvim_buf_is_loaded(alt_buf) then
    local listed = vim.fn.getbufinfo { buflisted = 1 }
    if #listed > 1 then
      vim.cmd 'bnext'
    else
      vim.cmd 'enew' -- Open [No Name] if this is the last buffer
    end
  else
    vim.cmd 'buffer #' -- Go to the alternate buffer
  end

  -- Now delete the previous buffer
  vim.api.nvim_buf_delete(cur_buf, { force = true })
end

return M

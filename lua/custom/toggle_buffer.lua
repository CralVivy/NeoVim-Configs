local M = {}

-- Track current state
local is_visible = true

-- Toggle visibility of bufferline via 'showtabline'
function M.toggle()
  if is_visible then
    vim.o.showtabline = 0 -- Hide tabline (never show)
  else
    vim.o.showtabline = 2 -- Always show
  end
  is_visible = not is_visible
end

-- Setup function: create keymap
function M.setup()
  vim.keymap.set('n', '<leader>bh', function()
    M.toggle()
  end, { noremap = true, silent = true, desc = 'Toggle BufferLine visibility' })
end

return M

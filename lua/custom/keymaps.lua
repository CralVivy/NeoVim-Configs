-- lua/custom/keymaps.lua

local map = vim.keymap.set
local utils = require 'custom.utils'

-- Buffer navigation (NvChad Style)
map('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer (NvChad)', silent = true })
map('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer (NvChad)', silent = true })

-- Smart buffer deletion (preserves layout)
map('n', '<leader>x', utils.smart_buf_delete, { desc = 'Smart close buffer (preserve layout)', silent = true })

-- New empty buffer
map('n', '<leader>bn', '<cmd>enew<CR>', { desc = 'New empty buffer', silent = true })

-- Toggle Neo-tree
map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle Neo-tree', silent = true })

-- Require the theme switcher
-- Map <leader>th to open the theme picker
-- vim.keymap.set('n', '<leader>th', function()
--   require('custom.theme_switcher').pick_theme()
-- end, { desc = 'Pick Theme', silent = true })

vim.keymap.set('n', '<leader>aa', '<Cmd>CodeCompanionChat<CR>', { desc = 'Toggle CodeCompanion Chat' })
vim.keymap.set('n', '<leader>ao', '<Cmd>CodeCompanionActions<CR>', { desc = 'Open CodeCompanion Actions' })
-- vim.keymap.set('n', '<leader>ar', '<Cmd>CodeCompanionReview<CR>', {desc = 'Review with CodeCompanion'})
-- vim.keymap.set('n', '<leader>at', '<Cmd>CodeCompanionTest<CR>', {desc = 'Test with CodeCompanion'})

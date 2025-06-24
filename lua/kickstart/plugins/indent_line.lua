-- lua/custom/plugins/indent.lua
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'VeryLazy',
    opts = {
      indent = { char = '│' },
      exclude = {
        filetypes = { 'dashboard' },
        buftypes = { 'nofile', 'terminal' },
      },
      scope = { enabled = false },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'dashboard',
        callback = function()
          -- Dashboard loaded: Force disable indent guides
          vim.b.ibl = vim.b.ibl or {}
          vim.b.ibl.disable = true
          vim.b.miniindentscope_disable = true
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'DashboardLoaded',
        callback = function()
          -- Extra insurance: force-disable indent lines when dashboard is fully drawn
          vim.b.ibl = vim.b.ibl or {}
          vim.b.ibl.disable = true
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  { 'echasnovski/mini.nvim', version = '*' },

  {
    'echasnovski/mini.indentscope',
    event = 'VeryLazy',
    opts = function()
      local scope = require 'mini.indentscope'
      return {
        symbol = '│',
        options = { try_as_border = true },
        draw = { delay = 0, animation = scope.gen_animation.none() },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'dashboard',
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'DashboardLoaded',
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}

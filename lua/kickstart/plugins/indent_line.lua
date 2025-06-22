-- lua/custom/plugins/indent.lua
return {
  -- Indent guides from indent-blankline
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│', tab_char = '│' },
      exclude = {
        filetypes = {
          'help',
          'neo-tree',
          'Trouble',
          'dashboard',
          'NvimTree',
          'packer',
          'lazy',
          'toggleterm',
        },
        buftypes = { 'terminal' },
      },
      scope = {
        enabled = false, -- We are disabling ibl scope to fully hand over to mini.indentscope
      },
    },
  },

  -- Add the base mini.nvim plugin
  { 'echasnovski/mini.nvim', version = '*' },

  -- Mini indentscope for active indent highlighting
  {
    'echasnovski/mini.indentscope',
    version = false,
    event = 'BufReadPre',
    opts = function()
      local indentscope = require('mini.indentscope')
      return {
        symbol = '│',
        options = { try_as_border = true },
        draw = {
          delay = 0,
          animation = indentscope.gen_animation.none(),
        },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'neo-tree',
          'TelescopePrompt',
          'lazy',
          'dashboard',
          'terminal',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}

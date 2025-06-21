-- lua/custom/plugins/indentline.lua
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        include = {
          node_type = {
            ['*'] = { 'block', 'function', 'table', 'if_statement', 'for_statement', 'while_statement' },
          },
        },
        highlight = { 'IndentBlanklineContextChar' },
      },
      exclude = {
        filetypes = { 'help', 'terminal', 'lazy', 'notify', 'neo-tree', 'dashboard', 'Trouble' },
        buftypes = { 'terminal', 'nofile' },
      },
      whitespace = {
        remove_blankline_trail = true,
      },
    },
    config = function(_, opts)
      local ibl = require 'ibl'
      local hooks = require 'ibl.hooks'

      -- Highlight color for the current indent scope
      vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#89b4fa', bold = true })

      -- Ensure color persists across colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#89b4fa', bold = true })
      end)

      ibl.setup(opts)
    end,
  },
}

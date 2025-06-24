return {
  {
    -- Indent guides
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'VeryLazy',
    opts = {
      indent = { char = '│' },
      exclude = {
        filetypes = {
          'dashboard', 'alpha', 'starter', 'NvimTree', 'neo-tree', 'help',
          'packer', 'lspinfo', 'checkhealth', 'man', 'gitcommit',
          'TelescopePrompt', 'TelescopeResults'
        },
        buftypes = { 'nofile', 'terminal', 'quickfix', 'prompt' },
      },
      scope = { enabled = false },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
      -- Extra protection: turn off indent guides manually for dashboard buffers
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'dashboard', 'alpha', 'starter', 'NvimTree', 'neo-tree', 'help', 'packer', 'TelescopePrompt', 'TelescopeResults' },
        callback = function()
          vim.b.indent_blankline_enabled = false
        end,
      })
    end,
  },

  {
    -- Indent scope lines
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
        pattern = { 'dashboard', 'alpha', 'starter', 'NvimTree', 'neo-tree', 'help', 'packer', 'TelescopePrompt', 'TelescopeResults' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}

-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'mfussenegger/nvim-jdtls',
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<C-\>]], -- Ctrl + \ to toggle terminal
        direction = 'horizontal', -- or 'vertical' or 'float'
      }
    end,
  },
  {
    'ThePrimeagen/vim-be-good',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = false,
    config = function()
      require('treesitter-context').setup {}
    end,
  },

  require 'custom.plugins.workspaces',

  {
    'github/copilot.vim',
    config = function()
      vim.cmd ':Copilot disable'
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {}
    end,
  },
  {
    'AlphaTechnolog/pywal.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('pywal').setup()
      -- Removed: vim.cmd 'colorscheme pywal'
      -- Theme application is now handled by custom.theme_switcher
    end,
  },
}

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
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  -- {
  --   'olimorris/codecompanion.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   opts = {
  --     -- strategies = {
  --     --   chat = { adapter = 'anthropic' }, -- or any adapter
  --     --   inline = { adapter = 'anthropic' },
  --     -- },
  --     display = {
  --       chat = {
  --         window = {
  --           width = 0.26, -- 50% of editor width (float or vsplit)
  --           height = 0.5, -- 50% of editor height
  --           layout = 'vertical', -- or "vertical" or "horizontal"
  --           border = 'single',
  --           position = 'topright',
  --         },
  --       },
  --     },
  --   },
  -- },
}

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
    'nvimdev/dashboard-nvim',
    event = 'UIEnter',
    config = function()
      return require 'custom.plugins.dashboard'
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}

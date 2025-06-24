return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  config = function()
    local dashboard = require 'dashboard'

    -- Read the neovim.txt file as header lines
    local function read_header()
      local path = vim.fn.stdpath 'config' .. '/lua/custom/ui/neovim.txt'
      local lines = {}
      for line in io.lines(path) do
        table.insert(lines, line)
      end
      return lines
    end

    dashboard.setup {
      theme = 'hyper',
      config = {
        header = read_header(),
        shortcut = {
          { desc = ' Update Plugins', group = '@property', action = 'Lazy update', key = 'u' },
          { desc = ' Load Session', group = '@property', action = 'PersistenceLoadSession', key = 's' },
          { desc = ' Load Last Session', group = '@property', action = 'PersistenceLoadLast', key = 'l' },
          { desc = ' Find Files', group = '@property', action = 'Telescope find_files', key = 'f' },
          { desc = ' Recent Files', group = '@property', action = 'Telescope oldfiles', key = 'r' },
          { desc = ' Quit Neovim', group = '@property', action = 'qa', key = 'q' },
        },
        footer = { 'Welcome to your NeoVim workspace' },
      },
    }
  end,
}

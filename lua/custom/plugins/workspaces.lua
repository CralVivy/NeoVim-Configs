-- This file configures the nvimdev/workspaces.nvim plugin.
-- It allows quick switching between project directories and integrates with Telescope.

return {
  'natecraddoock/workspaces.nvim', -- The plugin's GitHub repository
  event = 'VeryLazy', -- Load the plugin relatively late to avoid impacting startup
  dependencies = {
    'nvim-telescope/telescope.nvim', -- Required for Telescope integration
  },

  -- Options for workspaces.nvim
  opts = {
    path = vim.fn.stdpath 'data' .. '/workspaces',
    cd_type = 'global',
    sort = true,
    mru_sort = true,
    auto_open = false,
    auto_dir = false,
    notify_info = true,
    hooks = {
      add = {},
      remove = {},
      rename = {},
      open_pre = {},
      open = {},
    },
  },

  -- The 'config' function sets up the plugin with the defined options.
  config = function(_, opts)
    require('workspaces').setup(opts)

    -- Keymap for opening the workspace picker via Telescope.
    -- Using <leader>ww for "[W]orkspaces [W]orkspace Picker".
    vim.keymap.set('n', '<leader>ww', function()
      require('telescope').extensions.workspaces.workspaces {}
    end, { desc = '[W]orkspaces [W]orkspace Picker' })
  end,
}

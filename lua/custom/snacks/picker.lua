return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    picker = {
      enabled = true,
    },
  },
  keys = {
    {
      '<leader>fb',
      function() require('snacks').picker.buffers() end,
      desc = 'Buffers',
    },
    {
      '<leader>fc',
      function() require('snacks').picker.files { cwd = vim.fn.stdpath 'config' } end,
      desc = 'Find Config File',
    },
    {
      '<leader>ff',
      function() require('snacks').picker.files() end,
      desc = 'Find Files',
    },
    {
      '<leader>fg',
      function() require('snacks').picker.git_files() end,
      desc = 'Find Git Files',
    },
    {
      '<leader>fp',
      function() require('snacks').picker.projects() end,
      desc = 'Projects',
    },
    {
      '<leader>fr',
      function() require('snacks').picker.recent() end,
      desc = 'Recent',
    },
    {
      '<leader>gb',
      function() require('snacks').picker.git_branches() end,
      desc = 'Git Branches',
    },
    {
      '<leader>gl',
      function() require('snacks').picker.git_log() end,
      desc = 'Git Log',
    },
    {
      '<leader>gL',
      function() require('snacks').picker.git_log_line() end,
      desc = 'Git Log Line',
    },
    {
      '<leader>gs',
      function() require('snacks').picker.git_status() end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function() require('snacks').picker.git_stash() end,
      desc = 'Git Stash',
    },
    {
      '<leader>gd',
      function() require('snacks').picker.git_diff() end,
      desc = 'Git Diff (Hunks)',
    },
    {
      '<leader>gf',
      function() require('snacks').picker.git_log_file() end,
      desc = 'Git Log File',
    },
    {
      '<leader>sh',
      function() require('snacks').picker.help_tags() end,
      desc = 'Search Help',
    },
    {
      '<leader>sk',
      function() require('snacks').picker.keymaps() end,
      desc = 'Search Keymaps',
    },
    {
      '<leader>sf',
      function() require('snacks').picker.files() end,
      desc = 'Search Files',
    },
    {
      '<leader>sw',
      function() require('snacks').picker.grep_word() end,
      desc = 'Search current Word',
    },
    {
      '<leader>sg',
      function() require('snacks').picker.grep() end,
      desc = 'Search by Grep',
    },
    {
      '<leader>sd',
      function() require('snacks').picker.diagnostics() end,
      desc = 'Search Diagnostics',
    },
    {
      '<leader>sr',
      function() require('snacks').picker.resume() end,
      desc = 'Search Resume',
    },
    {
      '<leader>s.',
      function() require('snacks').picker.recent() end,
      desc = 'Search Recent Files',
    },
    {
      '<leader><leader>',
      function() require('snacks').picker.buffers() end,
      desc = 'Find existing buffers',
    },
    {
      '<leader>/',
      function() require('snacks').picker.lines() end,
      desc = 'Fuzzily search in current buffer',
    },
    {
      '<leader>s/',
      function() require('snacks').picker.grep { open_files = true } end,
      desc = 'Search in Open Files',
    },
    {
      '<leader>sn',
      function() require('snacks').picker.files { cwd = vim.fn.stdpath 'config' } end,
      desc = 'Search Neovim files',
    },
  },
}

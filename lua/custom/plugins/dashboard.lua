return {
  require('dashboard').setup {
    dashboard = {
      width = 72,
      sections = {
        {
          section = 'terminal',
          align = 'center',
          cmd = 'cat ' .. vim.fn.stdpath 'config' .. '/lua/custom/ui/header',
          height = 11,
          width = 72,
          padding = 1,
        },
        {
          align = 'center',
          padding = 1,
          text = {
            { '  Update ', hl = 'Label' },
            { '  Sessions ', hl = '@property' },
            { '  Last Session ', hl = 'Number' },
            { '  Files ', hl = 'DiagnosticInfo' },
            { '  Recent ', hl = '@string' },
          },
        },
        { section = 'startup', padding = 1 },
        { icon = '󰏓 ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { text = '', action = ':Lazy update', key = 'u' },
        { text = '', action = ':PersistenceLoadSession', key = 's' },
        { text = '', action = ':PersistenceLoadLast', key = 'l' },
        { text = '', action = ':Telescope find_files', key = 'f' },
        { text = '', action = ':Telescope oldfiles', key = 'r' },
      },
    },
  },
}

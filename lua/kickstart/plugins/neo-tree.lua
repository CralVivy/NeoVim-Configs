-- lua/kickstart/plugins/neo-tree.lua
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<C-n>', ':Neotree toggle<CR>', desc = 'NeoTree Toggle', silent = true },
  },
  opts = {
    hijack_netrw_behavior = 'open_current',
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      follow_current_file = {
        enabled = true,
        leave_unmodified = true,
      },
      resolve_symlinks = true,
      hide_dotfiles = false, -- These are optional but fine to keep
      hide_hidden = false, -- These are optional but fine to keep
      filtered_items = { -- <<< This is the CORRECT placement
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false, -- <<< Add this to also reveal OS-hidden files (like .DS_Store)
      },
    },
    window = {
      position = 'left',
      width = 30,
      auto_resize = false,
      mapping_options = {
        noremap = true,
        nowait = true,
        silent = true,
      },
      mappings = {
        ['<C-n>'] = 'close_window',
        ['<CR>'] = 'open_drop',
        ['S'] = 'open_split',
        ['s'] = 'open_vsplit',
        ['t'] = 'open_tabnew',
        ['p'] = 'toggle_preview',
        ['c'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['P'] = 'paste_from_clipboard',
        ['a'] = 'add',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['q'] = 'close_window',
        ['<bs>'] = 'navigate_up',
      },
    },
    buffers = {
      toggle_hidden_by_default = true,
      show_unloaded = true,
      group_empty_dirs = true,
      window = {
        mappings = {
          ['<C-n>'] = 'close_window',
          ['<CR>'] = 'open_drop',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
        },
      },
    },
    git = {
      enable = true,
      ignore_libgit_errors = true,
      auto_refresh = true,
      signs = {
        untracked = '',
        ignored = 'Ignore',
        unstaged = '󰄷',
        staged = '✓',
        deleted = '',
        renamed = '󰁕',
        unmerged = '',
      },
    },
    default_component_configs = {
      indent = {
        indent_marker = '│',
        padding = 1,
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = '',
        folder_empty_open = '',
        default = '',
      },
      git_status = {},
    },
    event_handlers = {},
  },
}

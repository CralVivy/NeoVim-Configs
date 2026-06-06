return {
  require('treesitter-context').setup {
    enable = true, -- Enable this plugin
    max_lines = 0, -- Unlimited context lines
    trim_scope = 'outer', -- Keep outer context if too large
    mode = 'cursor', -- Follows the cursor
    zindex = 20, -- Floating window stacking order
    separator = nil, -- Optional separator line between context and code
  },
}

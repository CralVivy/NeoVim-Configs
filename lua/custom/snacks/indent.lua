-- lua/custom/snacks/indent.lua
return {
  {
    'snacks.nvim',
    opts = {
      indent = {
        enabled = true,
        -- char = '│',
        -- only_scope = false,
        -- only_current = false,
        -- hl = {
        --   'SnacksIndent1',
        --   'SnacksIndent2',
        --   'SnacksIndent3',
        --   'SnacksIndent4',
        --   'SnacksIndent5',
        --   'SnacksIndent6',
        --   'SnacksIndent7',
        --   'SnacksIndent8',
        -- },
        -- priority = 1,
      },
      scope = {
        enabled = true,
        -- char = '│',
        -- only_current = false,
        -- underline = true,
        -- hl = 'SnacksIndentScope',
        -- priority = 100,
        -- animate = {
        --   enabled = false,
        -- },
      },
      chunk = {
        enabled = false,
        -- only_current = false,
        -- priority = 200,
        -- hl = 'SnacksIndentChunk',
        -- char = {
        --   corner_top = '┌',
        --   corner_bottom = '└',
        --   horizontal = '─',
        --   vertical = '│',
        --   arrow = '>',
        -- },
      },
      animate = {
        enabled = false,
        -- style = 'out',
        -- easing = 'linear',
        -- duration = { step = 0, total = 0 },
      },
    },
  },
}

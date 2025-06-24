return {
  'snacks.nvim', -- only the name of the plugin needs to be specified since it already exists
  opts = {
    indent = {
      char = '▎',
      only_current = false,
      only_scope = false,
      hl = 'SnacksIndent',
    },
    scope = {
      char = '▎',
      only_current = false,
    },
    animate = {
      enabled = false,
    },
  },
}

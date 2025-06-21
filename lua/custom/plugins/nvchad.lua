-- lua/custom/plugins/nvchad.lua
return {
  -- =================================================================
  -- FUNCTIONAL PLUGINS INSPIRED BY NVCHAD (These are generally safe to include)
  -- =================================================================

  -- REMOVE OR COMMENT OUT THIS ENTIRE BLOCK FOR "nvim-tree/nvim-tree.lua"
  -- {
  --   -- File Explorer
  --   "nvim-tree/nvim-tree.lua",
  --   keys = {
  --     { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
  --   },
  --   opts = {
  --     sort_by = "case_sensitive",
  --     view = {
  --       width = 30,
  --       side = "left",
  --     },
  --     renderer = {
  --       group_empty = true,
  --     },
  --     filters = {
  --       dotfiles = true,
  --     },
  --   },
  -- },

  {
    -- Commenting Plugin (This can remain)
    'numToStr/Comment.nvim',
    keys = {
      { 'gcc', mode = 'n', desc = 'Comment toggle current line' },
      { 'gc', mode = { 'n', 'o' }, desc = 'Comment toggle linewise' },
      { 'gc', mode = 'x', desc = 'Comment toggle linewise (visual)' },
      { 'gbc', mode = 'n', desc = 'Comment toggle current block' },
      { 'gb', mode = { 'n', 'o' }, desc = 'Comment toggle blockwise' },
      { 'gb', mode = 'x', desc = 'Comment toggle blockwise (visual)' },
    },
    opts = {},
  },
}

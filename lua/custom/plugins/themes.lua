return {
  -- Popular Neovim Themes
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    -- opts = {
    --   term_colors = true,
    --   transparent_background = true,
    --   dim_inactive = {
    --     enabled = false, -- dims the background color of inactive window
    --     shade = 'dark',
    --     percentage = 0.15, -- percentage of the shade to apply to the inactive window
    --   },
    --   integrations = {
    --     cmp = true,
    --     gitsigns = true,
    --     treesitter = true,
    --     harpoon = true,
    --     telescope = true,
    --     mason = true,
    --     noice = true,
    --     notify = true,
    --     which_key = true,
    --     fidget = true,
    --     native_lsp = {
    --       enabled = true,
    --       virtual_text = {
    --         errors = { 'italic' },
    --         hints = { 'italic' },
    --         warnings = { 'italic' },
    --         information = { 'italic' },
    --       },
    --       underlines = {
    --         errors = { 'underline' },
    --         hints = { 'underline' },
    --         warnings = { 'underline' },
    --         information = { 'underline' },
    --       },
    --       inlay_hints = {
    --         background = true,
    --       },
    --     },
    --     mini = {
    --       enabled = true,
    --       indentscope_color = '',
    --     },
    --   },
    -- },
    -- config = function(_, opts)
    --   require('catppuccin').setup(opts)
    --   vim.cmd.colorscheme 'catppuccin-macchiato'
    -- end,
  },
  { 'folke/tokyonight.nvim', priority = 1000 },
  { 'navarasu/onedark.nvim', priority = 1000 },
  { 'tiagovla/tokyodark.nvim', priority = 1000 },
  { 'EdenEast/nightfox.nvim', priority = 1000 }, -- Nightfox, Nordfox, etc.
  { 'shaunsingh/nord.nvim', priority = 1000 }, -- Classic Nord theme
  { 'rose-pine/neovim', name = 'rose-pine', priority = 1000 },
  { 'rebelot/kanagawa.nvim', priority = 1000 },
  { 'marko-cerovac/material.nvim', priority = 1000 },
  { 'nyoom-engineering/oxocarbon.nvim', priority = 1000 },
  { 'projekt0n/github-nvim-theme', priority = 1000 }, -- Multiple GitHub styles
  { 'navarasu/onedark.nvim', priority = 1000 }, -- OneDark Pro port
  { 'sainnhe/everforest', priority = 1000 },
  { 'sainnhe/gruvbox-material', priority = 1000 },
  { 'ellisonleao/gruvbox.nvim', priority = 1000 }, -- Modern Lua Gruvbox
  { 'luisiacc/gruvbox-baby', priority = 1000 },
  { 'oxfist/night-owl.nvim', priority = 1000 },
  {
    'mcchrish/zenbones.nvim',
    -- Optionally install Lush.  Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1 -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    -- config = function()
    --   vim.g.zenbones_darken_comments = 45
    --   vim.cmd.colorscheme('zenbones')
    -- end
  }, -- Zen-friendly, low-contrast
  { 'Yazeed1s/minimal.nvim', priority = 1000 }, -- Minimalist theme
  { 'Shatur/neovim-ayu', priority = 1000 }, -- Ayu Theme port
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    config = function()
      require('onedarkpro').setup {}
    end,
  }, -- Onedark Pro with variants
  { 'Mofiqul/vscode.nvim', priority = 1000 }, -- VSCode Theme port
  { 'loctvl842/monokai-pro.nvim', priority = 1000 }, -- Monokai Pro
  { 'maxmx03/fluoromachine.nvim', priority = 1000 }, -- Cyberpunk aesthetic
  { 'kaiuri/nvim-juliana', priority = 1000 }, -- Dark but warm colors
  { 'ribru17/bamboo.nvim', priority = 1000 }, -- Smooth greenish palette
  { 'aktersnurra/no-clown-fiesta.nvim', priority = 1000 }, -- Dark and minimal
  { 'askfiy/visual_studio_code', priority = 1000 }, -- VSCode accurate port
  { 'jacoborus/tender.vim', priority = 1000 }, -- Soft pastel palette
}

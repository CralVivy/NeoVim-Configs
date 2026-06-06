return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '1.*',
    dependencies = {
      'giuxtaposition/blink-cmp-copilot',
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = { 'rafamadriz/friendly-snippets' },
      },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        -- Customizing Tab to match the previous nvim-cmp behavior (jump or select)
        ['<Tab>'] = { 'select_next', 'snippet_forward' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward' },
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        -- Set to true to show documentation automatically
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        -- Ghost text for Copilot
        ghost_text = { enabled = true },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100, -- Prioritize Copilot suggestions
            async = true,
          },
        },
      },

      snippets = { preset = 'luasnip' },
    },
  },
}

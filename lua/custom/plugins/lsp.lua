-- lua/custom/plugins/lsp.lua

-- Return a list of plugin specifications
return {
  -- 1. Mason.nvim (essential for managing LSP servers and tools)
  {
    'williamboman/mason.nvim',
    -- Minimal setup for Mason itself
    config = function()
      require('mason').setup()
    end,
  },

  -- 2. Mason-Tool-Installer (for automatically installing linters, formatters, etc.)
  -- THIS IS THE KEY CHANGE: Moved to its own top-level plugin entry
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Configure mason-tool-installer to ensure tools are installed
    -- This config now runs after mason.nvim is set up.
    config = function()
      local mason_tool_installer = require 'mason-tool-installer'
      -- Define the tools you want mason-tool-installer to manage (e.g., stylua, debuggers, etc.)
      mason_tool_installer.setup {
        ensure_installed = {
          'stylua', -- For Lua formatting
          -- Add any other common tools you need installed for formatting/linting here,
          -- e.g., 'prettier', 'eslint_d', 'flake8'
        },
      }
    end,
  },

  -- 3. Mason-LSPConfig (bridges Mason with nvim-lspconfig for LSP server management)
  {
    'williamboman/mason-lspconfig.nvim',
    -- Ensure mason.nvim is set up before this runs.
    -- This plugin needs to be configured before nvim-lspconfig tries to use it.
    dependencies = {
      'williamboman/mason.nvim', -- Explicitly depend to ensure ordering if needed, though implicitly handled by list
    },
    config = function()
      local lspconfig = require 'lspconfig'
      local mason_lspconfig = require 'mason-lspconfig'
      -- mason_tool_installer is now already loaded and configured via its own plugin entry
      -- so we can safely require it here if needed, but for 'ensure_installed' it's already done.

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Define your servers list (can remain here)
      local servers = {
        html = {},
        cssls = {},
        tailwindcss = {
          filetypes = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte' },
        },
        tsserver = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- This is the new way for `mason-lspconfig.nvim` v2.0.0+ for handlers
      mason_lspconfig.setup {
        -- Configure the automatic setup for installed LSP servers
        handlers = {
          -- Default handler for any server not explicitly configured below
          function(server_name)
            local server_config = servers[server_name] or {}
            lspconfig[server_name].setup {
              capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {}),
              on_attach = function(client, bufnr)
                local map = function(keys, func, desc, mode)
                  mode = mode or 'n'
                  vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
                end

                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
                map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
                map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
                map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                local function client_supports_method(c, method, b)
                  if vim.fn.has 'nvim-0.11' == 1 then
                    return c:supports_method(method, b)
                  else
                    return c.supports_method(method, { bufnr = b })
                  end
                end

                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
                  local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = bufnr,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight,
                  })

                  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = bufnr,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references,
                  })

                  vim.api.nvim_create_autocmd('LspDetach', {
                    group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                    callback = function(event2)
                      vim.lsp.buf.clear_references()
                      vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                    end,
                  })
                end

                if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
                  map('<leader>th', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
                  end, '[T]oggle Inlay [H]ints')
                end
              end, -- End of on_attach function
              settings = server_config.settings,
              filetypes = server_config.filetypes,
              cmd = server_config.cmd,
            }
          end,
        },
        -- You can also specify specific server configurations here if they deviate from the default handler
        -- For example:
        -- lua_ls = function()
        --   lspconfig.lua_ls.setup({
        --     settings = { Lua = { completion = { callSnippet = 'Replace' } } },
        --     on_attach = on_attach, -- assuming on_attach is defined in scope or passed
        --     capabilities = capabilities,
        --   })
        -- end,
      }
    end, -- End of mason-lspconfig.nvim's config function
  },

  -- 4. nvim-lspconfig (the core LSP client plugin)
  {
    'neovim/nvim-lspconfig',
    -- nvim-lspconfig has no explicit config here because mason-lspconfig handles its setup.
    -- It just needs to be loaded so mason-lspconfig can interact with it.
    dependencies = {
      'williamboman/mason-lspconfig.nvim', -- Explicitly depend to ensure ordering
      'saghen/blink.cmp', -- For capabilities
      'j-hui/fidget.nvim', -- For LSP status
    },
    -- Diagnostic Config (moved from earlier into this plugin's scope if not global)
    config = function()
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
    end,
  },

  -- 5. Your completion plugin (moved as a separate entry for clarity)
  'saghen/blink.cmp',

  -- 6. Fidget.nvim (LSP status)
  { 'j-hui/fidget.nvim', opts = {} },
}

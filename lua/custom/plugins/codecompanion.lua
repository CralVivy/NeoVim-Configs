return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    display = {
      chat = {
        window = {
          width = 0.26,
          height = 0.5,
          layout = 'vertical',
          border = 'single',
          position = 'topright',
        },
      },
    },
  },
  config = function()
    local codecompanion = require 'codecompanion'

    -- Save chat
    vim.api.nvim_create_user_command('CodeCompanionSave', function(opts)
      local ok, chat = pcall(codecompanion.buf_get_chat, 0)
      if not ok or chat == nil then
        vim.notify('Run inside a CodeCompanion chat buffer', vim.log.levels.ERROR)
        return
      end

      local filename = table.concat(opts.fargs, '-')
      if filename == '' then
        filename = 'chat_' .. os.date '%Y-%m-%d_%H-%M-%S'
      end

      local Path = require 'plenary.path'
      local data_dir = vim.fn.stdpath 'data'
      local folder = Path:new(data_dir, 'cc_saves')
      if not folder:exists() then
        folder:mkdir { parents = true }
      end

      local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      folder:joinpath(filename .. '.md'):write(table.concat(buffer_lines, '\n'), 'w')

      vim.notify('💾 Saved chat as: ' .. filename .. '.md', vim.log.levels.INFO)
    end, { nargs = '*' })

    -- Load chat
    vim.api.nvim_create_user_command('CodeCompanionLoad', function()
      local telescope = require 'telescope.builtin'
      telescope.find_files {
        prompt_title = 'Load CodeCompanion Chat',
        cwd = vim.fn.stdpath 'data' .. '/cc_saves',
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local entry = require('telescope.actions.state').get_selected_entry()
            require('telescope.actions').close(prompt_bufnr)
            vim.cmd('edit ' .. entry.value)
          end)
          return true
        end,
      }
    end, {})

    -- Keybinds
    vim.keymap.set('n', '<leader>as', '<cmd>CodeCompanionSave<CR>', {
      desc = 'Save CodeCompanion Chat',
      noremap = true,
      silent = true,
    })

    vim.keymap.set('n', '<leader>al', '<cmd>CodeCompanionLoad<CR>', {
      desc = 'Load CodeCompanion Chat',
      noremap = true,
      silent = true,
    })

    -- Auto-save chat buffer on exit
    vim.api.nvim_create_autocmd('BufWinLeave', {
      pattern = '*',
      callback = function()
        local ok, chat = pcall(codecompanion.buf_get_chat, 0)
        if not ok or chat == nil then
          return
        end

        local Path = require 'plenary.path'
        local data_dir = vim.fn.stdpath 'data'
        local folder = Path:new(data_dir, 'cc_saves')
        if not folder:exists() then
          folder:mkdir { parents = true }
        end

        local fname = 'autosave_' .. os.date '%Y-%m-%d_%H-%M-%S' .. '.md'
        local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        folder:joinpath(fname):write(table.concat(buffer_lines, '\n'), 'w')

        vim.notify('🛑 Chat auto-saved as: ' .. fname, vim.log.levels.INFO)
      end,
    })
  end,
}

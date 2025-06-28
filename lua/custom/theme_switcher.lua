local m = {}

local theme_file = vim.fn.stdpath 'config' .. '/lua/custom/current_theme.lua'

local themes = {
  -- Your theme list
  'catppuccin',
  'tokyonight',
  'onedark',
  'tokyodark',
  'nightfox',
  'nord',
  'rose-pine',
  'kanagawa',
  'material',
  'oxocarbon',
  'github_dark',
  'github_light',
  'github_dark_default',
  'github_light_default',
  'everforest',
  'gruvbox-material',
  'gruvbox',
  'gruvbox-baby',
  'zenbones',
  'minimal',
  'ayu',
  'onedarkpro',
  'vscode',
  'monokai-pro',
  'fluoromachine',
  'juliana',
  'bamboo',
  'no-clown-fiesta',
  'visual_studio_code',
  'tender',
  'night-owl',
}

local function save_theme(theme)
  local file = io.open(theme_file, 'w')
  if file then
    file:write('return "' .. theme .. '"\n')
    file:close()
  else
    vim.notify('Error saving theme!', vim.log.levels.ERROR)
  end
end

local function restore_ui_defaults()
  -- Reload indentline
  -- require('ibl').setup {}
  -- vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#3E4452' })
  -- vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', { fg = '#ABB2BF' })

  -- Reload bufferline without overwriting highlights
  local ok, bufferline = pcall(require, 'bufferline')
  if ok then
    package.loaded['custom.configs.bufferline'] = nil
    local opts = require 'custom.configs.bufferline'
    bufferline.setup(opts)
  end
end

function m.load_last_theme()
  local ok, last_theme = pcall(dofile, theme_file)
  if ok and last_theme then
    vim.cmd('colorscheme ' .. last_theme)
  else
    vim.cmd 'colorscheme default'
  end
  restore_ui_defaults()
end

m.load_theme = function(theme)
  vim.cmd('colorscheme ' .. theme)
  vim.notify('Loaded theme: ' .. theme, vim.log.levels.INFO, { title = 'Theme Switcher' })
  save_theme(theme)
  restore_ui_defaults()
end

m.pick_theme = function()
  local ok, telescope = pcall(require, 'telescope')
  if not ok then
    vim.notify('Telescope not found!', vim.log.levels.ERROR)
    return
  end
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local conf = require('telescope.config').values

  pickers
    .new({}, {
      prompt_title = 'Select Theme',
      finder = finders.new_table { results = themes },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          m.load_theme(selection[1])
        end)
        return true
      end,
    })
    :find()
end

return m

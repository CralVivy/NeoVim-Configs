-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
--
return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python', -- For Python
    'mxsdev/nvim-dap-vscode-js', -- For JS/TS
    -- IMPORTANT: For C#, Java, PHP, Ruby etc., you might need dedicated
    -- nvim-dap-* plugins or manual configuration if mason-nvim-dap
    -- doesn't provide sufficient default handlers.
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end, -- This was the misplaced '}'
      desc = 'Debug: Step Out',
    },
    -- Added <F6> for stopping debugging
    {
      '<F6>',
      function()
        require('dap').terminate()
        require('dapui').close()
      end,
      desc = 'Debug: Stop',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {}, -- Keep this empty if mason-nvim-dap is providing default configs

      ensure_installed = {
        'delve',
        'codelldb', -- For C/C++/Rust
        'java-debug-adapter',
        'js-debug-adapter',
        'debugpy', -- For Python
        'netcoredbg',
        'php-debug-adapter',
        'rdbg',
      },
    }

    -- Dap UI setup
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Custom breakpoint icons and colors
    vim.api.nvim_set_hl(0, 'DapBreakpointRed', { fg = '#E51400', bold = true })
    vim.api.nvim_set_hl(0, 'DapStoppedGreen', { fg = '#00FF00', bold = true })
    vim.api.nvim_set_hl(0, 'DapBreakpointGrey', { fg = '#808080', bold = true })

    vim.fn.sign_define('DapBreakpoint', { text = '•', texthl = 'DapBreakpointRed', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '•', texthl = 'DapBreakpointRed', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = 'x', texthl = 'DapBreakpointGrey', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '•', texthl = 'DapBreakpointGrey', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStoppedGreen', linehl = 'DapStoppedLine', numhl = 'DapStoppedLine' })
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#3C3F41' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- IMPORTANT: Call setup() for each language-specific DAP plugin you installed!

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        detached = vim.fn.has 'win32' == 0,
      },
      -- Example: Add the following if you want an integrated terminal for Go input
      -- configurations = {
      --   {
      --     type = "go",
      --     name = "Launch file",
      --     request = "launch",
      --     program = "${file}",
      --     console = "integratedTerminal",
      --   }
      -- }
    }

    -- Python specific config
    require('dap-python').setup {
      -- Specify Python executable path. Mason installs debugpy in its venv.
      python_path = function()
        return require('mason-core.path').bin_dir .. '/debugpy/venv/bin/python'
      end,
      -- Optional: Add specific configurations here for Python, e.g., to force terminal input
      -- configurations = {
      --   {
      --     type = "python",
      --     request = "launch",
      --     name = "Launch file",
      --     program = "${file}",
      --     console = "integratedTerminal",
      --   },
      -- },
    }

    -- JavaScript/TypeScript specific config
    require('dap-vscode-js').setup {
      -- Path to the js-debug-adapter installed by Mason
      debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter',
      -- You might need to specify the node path if it's not in your PATH
      -- node_path = 'node',
      -- Optional: Add specific configurations for JS/TS here, e.g., to force terminal input
      -- configurations = {
      --   {
      --     type = "pwa-node", -- or "pwa-chrome", "pwa-msedge"
      --     request = "launch",
      --     name = "Launch file",
      --     program = "${file}",
      --     cwd = "${workspaceFolder}",
      --     console = "integratedTerminal",
      --   },
      -- },
    }

    -- If you want C# (netcoredbg), Java (java-debug-adapter), PHP (php-debug-adapter), Ruby (rdbg)
    -- to be directly usable via `dap.configurations`, and there's no dedicated `nvim-dap-*` plugin
    -- for them, you might need to manually set up `dap.adapters` and `dap.configurations`.
    -- mason-nvim-dap's default handlers *might* provide basic configurations,
    -- but if not, you'd add something like:

    -- Example for C# (netcoredbg) if mason-nvim-dap's handler isn't sufficient
    -- dap.adapters.coreclr = {
    --   type = 'executable',
    --   command = vim.fn.stdpath('data') .. '/mason/packages/netcoredbg/netcoredbg',
    --   args = { '--interpreter=vscode' },
    -- }
    -- dap.configurations.cs = {
    --   {
    --     type = 'coreclr',
    --     name = 'Launch .NET Core',
    --     request = 'launch',
    --     program = function()
    --       return vim.fn.input('Path to .dll or .exe: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/YourProject.dll', 'file')
    --     end,
    --     cwd = '${workspaceFolder}',
    --     console = "integratedTerminal",
    --   },
    -- }

    -- Example for Java (java-debug-adapter) - this is complex and often needs a dedicated LSP config
    -- dap.adapters.java = {
    --   type = 'server',
    --   port = 5005,
    --   host = '127.0.0.1',
    --   executable = {
    --     command = 'java',
    --     args = {
    --       '-jar',
    --       vim.fn.glob(vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.dist/target/com.microsoft.java.debug.dist-*.jar'),
    --     },
    --   },
    -- }
    -- dap.configurations.java = {
    --   {
    --     type = 'java',
    --     request = 'launch',
    --     name = 'Launch Current File',
    --     mainClass = '${file_basename}', -- Needs full class name e.g., 'com.example.Main'
    --     projectName = '${workspaceFolderBasename}',
    --     cwd = '${workspaceFolder}',
    --     console = "integratedTerminal",
    --   },
    -- }
  end,
}

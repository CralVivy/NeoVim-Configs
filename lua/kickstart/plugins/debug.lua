return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
    'mxsdev/nvim-dap-vscode-js',
  },
  keys = {
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
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<F6>',
      function()
        require('dap').terminate()
        require('dapui').close()
      end,
      desc = 'Debug: Stop',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
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
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'delve',
        'codelldb',
        'js-debug-adapter',
        'debugpy',
        'netcoredbg',
        'php-debug-adapter',
        'rdbg',
        'java-debug-adapter',
      },
    }

    dapui.setup()

    vim.fn.sign_define('DapBreakpoint', { text = '•', texthl = 'DapBreakpointRed' })
    vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStoppedGreen' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-go').setup {
      delve = { detached = vim.fn.has 'win32' == 0 },
    }

    require('dap-python').setup {
      python_path = function()
        return require('mason-core.path').bin_dir .. '/debugpy/venv/bin/python'
      end,
    }

    require('dap-vscode-js').setup {
      debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter',
    }

    -- Java Adapter (assumes java-debug-adapter installed)
    dap.adapters.java = function(callback)
      callback {
        type = 'server',
        host = '127.0.0.1',
        port = '5005',
      }
    end

    dap.configurations.java = {
      {
        type = 'java',
        request = 'attach',
        name = 'Debug (Attach) - Remote',
        hostName = '127.0.0.1',
        port = 5005,
      },
    }

    dap.configurations.java = {
      {
        -- You need to extend the classPath to list your dependencies.
        -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
        classPaths = {},

        -- If using multi-module projects, remove otherwise.
        projectName = 'yourProjectName',

        javaExec = '~/.sdkman/candidates/java/21.0.2-open',
        mainClass = 'your.package.name.MainClassName',

        -- If using the JDK9+ module system, this needs to be extended
        -- `nvim-jdtls` would automatically populate this property
        modulePaths = {},
        name = 'Launch YourClassName',
        request = 'launch',
        type = 'java',
      },
    }
  end,
}

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
    -- Add any other dap-related dependencies here if needed, e.g., for C/C++ (nvim-dap-cxx)
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

    -- Setup mason-nvim-dap for automatic debugger installation
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'delve', -- Go debugger
        'codelldb', -- C/C++/Rust debugger
        'js-debug-adapter', -- JavaScript/TypeScript debugger
        'debugpy', -- Python debugger
        'netcoredbg', -- .NET Core debugger
        'php-debug-adapter', -- PHP debugger
        'rdbg', -- Ruby debugger
        'java-debug-adapter', -- Java debugger
        -- Add other debuggers as needed
      },
    }

    -- Setup dapui for the debug user interface
    dapui.setup()

    -- Define signs for breakpoints and stopped lines
    vim.fn.sign_define('DapBreakpoint', { text = '•', texthl = 'DapBreakpointRed' })
    vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStoppedGreen' })

    -- Automatically open/close dapui on debug events
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Go Debugger Setup
    require('dap-go').setup {
      delve = { detached = vim.fn.has 'win32' == 0 },
    }

    -- Python Debugger Setup (using debugpy installed by Mason)
    -- This explicitly sets the path to debugpy's python executable
    require('dap-python').setup(vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python')

    -- JavaScript/TypeScript Debugger Setup (using js-debug-adapter installed by Mason)
    require('dap-vscode-js').setup {
      debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge' },
    }

    -- Java Debugger Adapter Definition (connects to java-debug-adapter)
    -- This assumes 'java-debug-adapter' is installed via Mason
    dap.adapters.java = function(callback)
      callback {
        type = 'server',
        host = '127.0.0.1',
        port = '5005',
      }
    end

    -- Java Debug Configurations
    dap.configurations.java = {
      -- Attach to a running Java process
      {
        type = 'java',
        request = 'attach',
        name = 'Debug (Attach) - Remote',
        hostName = '127.0.0.1',
        port = 5005,
      },
      -- Launch a Java application
      {
        -- You need to extend the classPath to list your dependencies.
        -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
        classPaths = {},

        -- If using multi-module projects, remove otherwise.
        -- **IMPORTANT**: Replace 'yourProjectName' with the actual name of your project or module.
        projectName = 'yourProjectName',

        -- Path to your Java executable (e.g., from SDKMAN or system install)
        -- **IMPORTANT**: Adjust this path to your specific Java installation.
        javaExec = '~/.sdkman/candidates/java/21.0.2-open',

        -- The fully qualified name of your main class (e.g., 'com.example.MainClass')
        -- **IMPORTANT**: Replace 'your.package.name.MainClassName' with your actual main class.
        mainClass = 'your.package.name.MainClassName',

        -- If using the JDK9+ module system, this needs to be extended
        -- `nvim-jdtls` would automatically populate this property
        modulePaths = {},
        name = 'Launch YourClassName',
        request = 'launch',
        type = 'java',
      },
    }

    -- You can add configurations for other languages here as well
    -- e.g., for C/C++ with CodeLLDB
    -- dap.configurations.cpp = {
    --   {
    --     name = "Launch file",
    --     type = "codelldb",
    --     request = "launch",
    --     program = function()
    --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --     end,
    --     cwd = '${workspaceFolder}',
    --     stopOnEntry = true,
    --   },
    -- }
  end,
}

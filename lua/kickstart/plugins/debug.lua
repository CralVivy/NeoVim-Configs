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
    -- 'java-debug-adapter' is explicitly managed by JDTLS, so it's removed here
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
      desc = 'Debug: Toggle UI',
    },
    {
      '<leader>bb',
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
      desc = 'Debug: Conditional Breakpoint',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Mason-DAP setup
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {
        -- This default_setup handles all Mason-installed DAP servers for which it has defaults.
        -- Java is *not* handled here, as JDTLS will provide it.
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
      },
      ensure_installed = {
        'delve', -- Go debugger
        'codelldb', -- C/C++/Rust debugger
        'js-debug-adapter', -- JavaScript/TypeScript debugger
        'debugpy', -- Python debugger
        'netcoredbg', -- .NET debugger
        'php-debug-adapter', -- PHP debugger
        'rdbg', -- Ruby debugger
        -- 'java-debug-adapter' is removed from here. JDTLS is responsible for it.
      },
    }

    -- DAP UI setup
    dapui.setup()

    -- Sign definitions for breakpoints in the Neovim gutter
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpointRed', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointRed', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DapBreakpointGreen', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DapStoppedGreen', numhl = '' })

    -- Auto open/close DAP UI based on debug events
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Go language specific setup
    require('dap-go').setup {
      delve = { detached = vim.fn.has 'win32' == 0 }, -- Use detached mode for Windows
    }

    -- Python language specific setup
    require('dap-python').setup(vim.fn.stdpath 'data' .. '/mason/packages/debugpy/venv/bin/python')

    -- JavaScript/TypeScript language specific setup
    require('dap-vscode-js').setup {
      debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge' },
    }

    -- Java configurations (these configurations will now use the adapter defined by JDTLS)
    local get_java_main_class = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      for _, line in ipairs(lines) do
        if line:find 'public%s+static%s+void%s+main' then
          local package_name = ''
          for _, pkg_line in ipairs(lines) do
            local found_pkg = pkg_line:match '^%s*package%s+([a-zA-Z0-9_.]+);'
            if found_pkg then
              package_name = found_pkg .. '.'
              break
            end
          end
          -- Corrected function name
          local file_name = vim.fn.fnamemodify(vim.fn.expand '%', ':t:r')
          return package_name .. file_name
        end
      end
      return vim.fn.input 'Enter Main Class (e.g., com.example.Main): '
    end

    local get_java_project_name = function()
      -- Corrected function name
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      return vim.fn.input('Enter Project Name: ', project_name)
    end

    dap.configurations.java = {
      {
        type = 'java',
        request = 'attach',
        name = 'Debug (Attach) - Remote',
        hostName = '127.0.0.1',
        port = 5005,
      },
      {
        name = 'Launch Java App',
        type = 'java', -- This 'type' will now be fulfilled by JDTLS's DAP registration
        request = 'launch',
        mainClass = get_java_main_class,
        projectName = get_java_project_name,
        javaExec = '~/.sdkman/candidates/java/current/bin/java', -- Path to your Java executable
        classPaths = {},
        modulePaths = {},
        externalConsole = true,
      },
    }

    -- C, C++, Rust (CodeLLDB) configurations
    dap.configurations.cpp = {
      {
        name = 'Launch file (and compile)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          local file = vim.fn.expand '%:p'
          -- Corrected function name
          local output = '/tmp/' .. vim.fn.fnamemodify(file, ':t:r') .. '.out'
          local compiler = vim.fn.input('Compiler (e.g., g++): ', 'g++')

          local cmd = string.format('%s -g -o %s %s', compiler, output, file)

          vim.notify('Compiling with: ' .. cmd, vim.log.levels.INFO)
          local success = vim.fn.system(cmd)

          if vim.v.shell_error ~= 0 then
            vim.notify('Compilation failed with errors: ' .. success, vim.log.levels.ERROR)
            return nil
          end

          vim.notify('Compilation successful!', vim.log.levels.INFO)
          return output
        end,
        args = function()
          local args_str = vim.fn.input 'Enter command-line arguments (space-separated): '
          local args = {}
          for arg in args_str:gmatch '%S+' do
            table.insert(args, arg)
          end
          return args
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        externalConsole = true,
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end,
}

return {
  {
    'https://github.com/mfussenegger/nvim-dap',
    cmd = { 'DapContinue', 'DapStepOver', 'DapStepInto', 'DapStepOut', 'DapToggleBreakpoint', },
    keys = {
      { '<leader>dc', '<CMD>DapContinue<CR>',                   desc = 'Continue' },
      { '<leader>do', '<CMD>DapStepOver<CR>',                   desc = 'Step Over' },
      { '<leader>di', '<CMD>DapStepInto<CR>',                   desc = 'Step Into' },
      { '<leader>du', '<CMD>DapStepOut<CR>',                    desc = 'Step Out' },
      { '<leader>dx', '<CMD>DapTerminate<CR>',                  desc = 'Terminate' },
      { '<leader>db', '<CMD>DapToggleBreakpoint<CR>',           desc = 'Toggle Breakpoint' },
      { '<leader>dt', '<CMD>lua require("dapui").toggle()<CR>', desc = 'Toggle DAP UI' },
    },
    dependencies = {
      { 'https://github.com/theHamsta/nvim-dap-virtual-text' },
      { 'https://github.com/rcarriga/nvim-dap-ui' },
    },
    config = function()
      local dap = require('dap')

      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          }
        }
      end

      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
      dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
          ---@diagnostic disable-next-line: undefined-field
          local port = (config.connect or config).port
          ---@diagnostic disable-next-line: undefined-field
          local host = (config.connect or config).host or '127.0.0.1'
          cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
              source_filetype = 'python',
            },
          })
        else
          cb({
            type = 'executable',
            command = 'venv/bin/python',
            args = { '-m', 'debugpy.adapter' },
            options = {
              source_filetype = 'python',
            },
          })
        end
      end

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = 'launch';
          name = 'Launch file';

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = '${file}'; -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            else
              return 'python'
            end
          end;
        },
      }


      require('nvim-dap-virtual-text').setup()


      local dapui = require('dapui')
      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  -- DAP for java
  -- TODO: lazy
  { 'https://github.com/mfussenegger/nvim-jdtls' },

  -- DAP for JS
  -- TODO: lazy
  {
    'https://github.com/mxsdev/nvim-dap-vscode-js',
    config = {
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
    }
  },
}

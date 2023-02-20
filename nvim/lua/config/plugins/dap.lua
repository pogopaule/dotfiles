return {
  {
    'https://github.com/mfussenegger/nvim-dap',
    cmd = { 'DapContinue', 'DapStepOver', 'DapStepInto', 'DapStepOut', 'DapToggleBreakpoint', },
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

      dap.adapters.python = {
        type = 'executable';
        command = 'python';
        args = { '-m', 'debugpy.adapter' };
      }

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = 'launch';
          name = 'Launch current file';

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

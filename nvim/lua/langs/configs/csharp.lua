return {
  csharp = {
    filetypes = { 'cs' },
    language = {
      syntax = { 'c_sharp' },
      servers = {
        omnisharp = {},
      },
    },
    debuggers = {
      {
        name = 'coreclr',
        fn = function(dap)
          dap.adapters.coreclr = {
            type = 'executable',
            command = vim.fn.stdpath 'data' .. '/mason/bin/netcoredbg',
            args = { '--interpreter=vscode' },
          }

          dap.configurations.cs = {
            {
              type = 'coreclr',
              name = 'launch - netcoredbg',
              request = 'launch',
              program = function()
                ---@diagnostic disable-next-line: redundant-parameter
                return vim.fn.input('DLL Location: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
              end,
            },
            {
              type = 'coreclr',
              name = 'attach - netcoredbg',
              request = 'attach',
              processId = require('dap.utils').pick_process,
            },
          }
        end,
      },
    },
  },
}

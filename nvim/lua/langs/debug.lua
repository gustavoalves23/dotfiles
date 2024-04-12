local node2 = function(dap)
  dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = { vim.fn.stdpath 'data' .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' },
  }
  dap.configurations.javascript = {
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      program = '${file}',
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require('dap.utils').pick_process,
    },
  }
end

local netcoredbg = function(dap)
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
end

return {
  node2 = node2,
  netcoredbg = netcoredbg,
}

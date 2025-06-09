local langs = require 'langs'
return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  keys = {
    { '<F5>', desc = 'Start Debugger/Continue' },
    { '<F10>', desc = 'Step Over' },
    { '<F11>', desc = 'Step Into' },
    { '<F12>', desc = 'Step Out' },
    { '<Leader>b', desc = 'Toggle Breakpoint' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    vim.keymap.set('n', '<F5>', function()
      dap.continue()
    end, {
      desc = 'Start Debugger/Continue',
    })
    vim.keymap.set('n', '<F10>', function()
      dap.step_over()
    end, {
      desc = 'Step Over',
    })
    vim.keymap.set('n', '<F11>', function()
      dap.step_into()
    end, {
      desc = 'Step Into',
    })
    vim.keymap.set('n', '<F12>', function()
      dap.step_out()
    end, {
      desc = 'Step Out',
    })
    vim.keymap.set('n', '<Leader>b', function()
      dap.toggle_breakpoint()
    end, {
      desc = 'Toggle Breakpoint',
    })
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    for _, value in pairs(langs) do
      local debuggers = value.debuggers
      if debuggers then
        for _, debugger in pairs(debuggers) do
          debugger.fn(dap)
        end
      end
    end
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup {}
  end,
}

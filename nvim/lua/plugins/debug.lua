local langs = require 'langs'
return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  keys = {
    { '<F5>' },
    { '<F10>' },
    { '<F11>' },
    { '<F12>' },
    { '<Leader>b' },
    { '<Leader>B' },
    { '<F7>' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    vim.keymap.set('n', '<F5>', function()
      dap.continue()
    end)
    vim.keymap.set('n', '<F10>', function()
      dap.step_over()
    end)
    vim.keymap.set('n', '<F11>', function()
      dap.step_into()
    end)
    vim.keymap.set('n', '<F12>', function()
      dap.step_out()
    end)
    vim.keymap.set('n', '<Leader>b', function()
      dap.toggle_breakpoint()
    end)
    vim.keymap.set('n', '<Leader>B', function()
      dap.set_breakpoint()
    end)

    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

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

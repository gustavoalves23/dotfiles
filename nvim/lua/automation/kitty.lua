local function get_config()
  local str = vim.fn.system 'kitty @ ls'
  return vim.json.decode(str)
end
local function add_padding()
  vim.fn.system 'kitten @ set-spacing padding=0'
  vim.fn.system 'kitten @ set-background-opacity 1'
end

local function reset_config()
  vim.fn.system 'kitten @ set-spacing padding=16'
  local config = get_config()
  local my_id = tonumber(vim.env.KITTY_WINDOW_ID)

  -- Opacity is per OS window: only restore it when this is the last nvim in it.
  local windows_running_vim = 0
  for _, os_window in pairs(config) do
    local contains_me = false
    local count = 0
    for _, tab in pairs(os_window.tabs) do
      for _, window in pairs(tab.windows) do
        if window.id == my_id then
          contains_me = true
        end
        for _, process in pairs(window.foreground_processes) do
          if process.cmdline[1] == 'nvim' or process.cmdline[1] == 'sudoedit' then
            count = count + 1
          end
        end
      end
    end
    if contains_me then
      windows_running_vim = count
    end
  end

  if windows_running_vim <= 1 then
    vim.fn.system 'kitten @ set-background-opacity 0.9'
  end
end

local _kitty_au = vim.api.nvim_create_augroup('kitty_padding_au', {
  clear = true,
})

vim.api.nvim_create_user_command('Padding', add_padding, {})
vim.api.nvim_create_user_command('Reset', reset_config, {})
vim.api.nvim_create_autocmd('VimEnter', {
  group = _kitty_au,
  callback = function()
    vim.schedule(function()
      pcall(add_padding)
    end)
  end,
  once = true,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = _kitty_au,
  callback = function()
    pcall(reset_config)
  end,
  once = true,
})

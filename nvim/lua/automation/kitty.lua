local function get_config()
  local str = vim.fn.system 'kitty @ ls'
  return vim.json.decode(str)
end
local function add_padding()
  vim.fn.system 'kitten @ set-spacing padding=0'
  vim.fn.system 'kitten @ set-background-opacity 1'
end

local function reset_config()
  vim.fn.system 'kitten @ set-spacing padding=14'
  local config = get_config()

  local windows_running_vim = 0

  for _, tab in pairs(config[1].tabs) do
    for _, window in pairs(tab.windows) do
      for _, process in pairs(window.foreground_processes) do
        if process.cmdline[1] == 'nvim' then
          windows_running_vim = windows_running_vim + 1
        end
      end
    end
  end

  if windows_running_vim <= 1 then
    vim.fn.system 'kitten @ load-config'
  end
end

local _kitty_au = vim.api.nvim_create_augroup('kitty_padding_au', {
  clear = true,
})

vim.api.nvim_create_user_command('Padding', add_padding, {})
vim.api.nvim_create_user_command('Reset', reset_config, {})
vim.api.nvim_create_autocmd('VimEnter', {
  group = _kitty_au,
  callback = add_padding,
  once = true,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = _kitty_au,
  callback = reset_config,
  once = true,
})

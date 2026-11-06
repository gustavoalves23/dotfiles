local _is_tmux = vim.env.TMUX ~= nil

local _bin = vim.fn.executable 'alacritty' == 1 and 'alacritty'
  or '/Applications/Alacritty.app/Contents/MacOS/alacritty'

local _get_true_alacritty_variables = function()
  if not _is_tmux then
    return { vim.env.ALACRITTY_SOCKET, vim.env.ALACRITTY_WINDOW_ID }
  end

  local json = vim.fn.system(vim.fn.stdpath 'config' .. '/lua/automation/scripts/tmux_get_true_alacritty_variables.sh')
  local trimmed = vim.fn.trim(json)
  local decoded = vim.json.decode(trimmed)
  return { decoded.alacritty_socket, decoded.alacritty_window_id }
end

local function add_padding()
  local vars = _get_true_alacritty_variables()

  -- Async so the alacritty IPC round-trip doesn't block startup.
  vim.system({
    _bin, 'msg', '--socket', vars[1], 'config', '-w', vars[2],
    'window.padding.x=0', 'window.padding.y=0', 'window.dynamic_padding=false',
  })
end

local _alacritty_au = vim.api.nvim_create_augroup('alacritty_padding_au', {
  clear = true,
})

vim.api.nvim_create_user_command('Padding', add_padding, {})
vim.api.nvim_create_autocmd('VimEnter', {
  group = _alacritty_au,
  callback = add_padding,
  once = true,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = _alacritty_au,
  callback = function()
    local function run()
      local vars = _get_true_alacritty_variables()
      -- Detached shell: the (slow) check for other nvim panes and the alacritty
      -- IPC run after nvim has exited, so quitting doesn't wait on them.
      local check = _is_tmux
          and ('n=$(sh "' .. vim.fn.stdpath 'config' .. '/lua/automation/scripts/tmux_nvim_sessions.sh" ' .. vim.uv.os_getpid() .. '); [ "${n:-0}" -eq 0 ] || exit 0; ')
        or ''
      vim.system({
        'sh', '-c', check .. 'exec "$0" msg --socket "$1" config -w "$2" -r',
        _bin, vars[1], vars[2],
      }, { detach = true })
    end
    pcall(run)
  end,
  once = true,
})

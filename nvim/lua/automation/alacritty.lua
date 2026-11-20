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

local _padding_job = nil

local function add_padding()
  local vars = _get_true_alacritty_variables()

  -- `alacritty msg` fails transiently (EPIPE / ENOTCONN) ~1-2% of the time, so retry.
  _padding_job = vim.system({
    'sh', '-c',
    'for i in 1 2 3 4 5; do "$0" msg --socket "$1" config -w "$2" '
      .. "'window.padding.x=0' 'window.padding.y=0' 'window.dynamic_padding=false' "
      .. '2>/dev/null && exit 0; sleep 0.05; done; exit 1',
    _bin, vars[1], vars[2],
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
      -- Must finish before nvim exits (and before the next nvim starts), otherwise a late reset
      -- can overwrite the next instance's padding removal.
      if _padding_job then
        _padding_job:wait(2000)
      end

      local vars = _get_true_alacritty_variables()
      local check = _is_tmux
          and ('n=$(sh "' .. vim.fn.stdpath 'config' .. '/lua/automation/scripts/tmux_nvim_sessions.sh" ' .. vim.uv.os_getpid() .. '); [ "${n:-0}" -eq 0 ] || exit 0; ')
        or ''
      vim.system({
        'sh', '-c',
        check .. 'for i in 1 2 3 4 5; do "$0" msg --socket "$1" config -w "$2" -r 2>/dev/null && exit 0; sleep 0.05; done',
        _bin, vars[1], vars[2],
      }):wait(2000)
    end
    pcall(run)
  end,
  once = true,
})

local _is_tmux = vim.env.TMUX ~= nil

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

  vim.fn.system(
    'alacritty msg --socket '
      .. vars[1]
      .. ' config -w '
      .. vars[2]
      .. " options 'window.padding.x=0' 'window.padding.y=0' 'window.dynamic_padding=false'"
  )
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
      if _is_tmux then
        local nvim_session_count = vim.fn.system(vim.fn.stdpath 'config' .. '/lua/automation/scripts/tmux_nvim_sessions.sh')
        if tonumber(nvim_session_count) > 1 then
          return
        end
      end

      local vars = _get_true_alacritty_variables()
      vim.fn.system('alacritty msg --socket ' .. vars[1] .. ' config -w ' .. vars[2] .. ' -r')
    end
    pcall(run)
  end,
  once = true,
})

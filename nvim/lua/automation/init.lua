local _is_alacritty = vim.env.ALACRITTY_WINDOW_ID ~= nil
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

if _is_alacritty then
  local _alacritty_au = vim.api.nvim_create_augroup('alacritty_padding_au', {
    clear = true,
  })

  local function add_padding()
    local vars = _get_true_alacritty_variables()

    vim.fn.system(
      'alacritty msg --socket ' .. vars[1] .. ' config -w ' .. vars[2] .. " options 'window.padding.x=0' 'window.padding.y=0' 'window.dynamic_padding=false'"
    )
  end

  vim.api.nvim_create_user_command('AlacrittyPadding', add_padding, {})
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
        vim.fn.jobstart('alacritty msg --socket ' .. vars[1] .. ' config -w ' .. vars[2] .. ' -r', { detach = true })
      end
      pcall(run)
    end,
    once = true,
  })
end

--Set filetype to groovy for jenkinsfiles
vim.filetype.add {
  filename = {
    ['Jenkinsfile'] = 'groovy',
  },
}

--Auto refresh file changes outside nvim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  command = 'checktime',
})

--  Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local relative_number_group = vim.api.nvim_create_augroup('RelativeNumber', { clear = true })

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  command = 'set norelativenumber',
  group = relative_number_group,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set relativenumber',
  group = relative_number_group,
})

local disable_new_line_comment_group = vim.api.nvim_create_augroup('DisableNewLineComment', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
  group = disable_new_line_comment_group,
  desc = 'Disable New Line Comment',
})

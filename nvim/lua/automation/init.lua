local _is_alacritty = vim.env.ALACRITTY_WINDOW_ID ~= nil

local _alacritty_au = vim.api.nvim_create_augroup('alacritty_padding_au', {
  clear = true,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = _alacritty_au,
  callback = function()
    if not _is_alacritty then
      return
    end
    vim.fn.system "alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID options 'window.padding.x=0' 'window.padding.y=0' 'window.dynamic_padding=false'"
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = _alacritty_au,
  callback = function()
    if not _is_alacritty then
      return
    end
    if vim.env.TMUX then
      local nvim_session_count = vim.fn.system(vim.fn.stdpath 'config' .. '/lua/automation/scripts/tmux_nvim_sessions.sh')
      if tonumber(nvim_session_count) > 1 then
        return
      end
    end

    vim.fn.jobstart('alacritty msg --socket $ALACRITTY_SOCKET config -w $ALACRITTY_WINDOW_ID -r', { detach = true })
  end,
})

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

-- remove background color when on WrapTerminal
if vim.env.TERM_PROGRAM == 'WarpTerminal' then
  vim.api.nvim_set_hl(0, 'Normal', { foreground = 'NONE', background = 'NONE' })
end

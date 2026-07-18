local ok_to, textobjects = pcall(require, 'nvim-treesitter-textobjects')
if ok_to then
  textobjects.setup {
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  }

  local select = require 'nvim-treesitter-textobjects.select'
  local move = require 'nvim-treesitter-textobjects.move'

  local select_map = function(lhs, capture, desc)
    vim.keymap.set({ 'x', 'o' }, lhs, function()
      select.select_textobject(capture, 'textobjects')
    end, { desc = desc })
  end

  select_map('af', '@function.outer', 'Select outer function')
  select_map('if', '@function.inner', 'Select inner function')
  select_map('ac', '@class.outer', 'Select outer class')
  select_map('ic', '@class.inner', 'Select inner class')

  local move_map = function(lhs, fn, capture, desc)
    vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
      fn(capture, 'textobjects')
    end, { desc = desc })
  end

  move_map(']m', move.goto_next_start, '@function.outer', 'Next function start')
  move_map(']M', move.goto_next_end, '@function.outer', 'Next function end')
  move_map('[m', move.goto_previous_start, '@function.outer', 'Previous function start')
  move_map('[M', move.goto_previous_end, '@function.outer', 'Previous function end')
end

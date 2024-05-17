local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local langs = require 'langs'

local extra_lib = {}

for _, lang in pairs(langs) do
  if lang.extra_lib then
    table.insert(extra_lib, lang.extra_lib)
  end
end

require('lazy').setup({
  "tjdevries/lazy-require.nvim",
  { import = 'plugins' }, { extra_lib } }, {
  checker = {
    enabled = true,
  },
})

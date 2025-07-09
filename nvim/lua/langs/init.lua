return vim.tbl_extend(
  'force',
  {},
  require 'langs.configs.go',
  require 'langs.configs.sql',
  require 'langs.configs.lua',
  require 'langs.configs.rust',
  require 'langs.configs.react',
  require 'langs.configs.csharp',
  require 'langs.configs.svelte',
  require 'langs.configs.aspvbs',
  require 'langs.configs.python',
  require 'langs.configs.generic',
  require 'langs.configs.javascript',
  require 'langs.configs.handlebars'
)

return vim.tbl_extend(
  'force',
  {},
  require 'langs.configs.lua',
  require 'langs.configs.rust',
  require 'langs.configs.react',
  require 'langs.configs.svelte',
  require 'langs.configs.python',
  require 'langs.configs.csharp',
  require 'langs.configs.aspvbs',
  require 'langs.configs.generic',
  require 'langs.configs.javascript',
  require 'langs.configs.handlebars'
)

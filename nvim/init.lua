vim.g.mapleader = ' '

-- Initialize lazy.nvim and load the plugins
require 'bootstrap'
-- Define settings and keymaps for nvim and plugins
require 'settings'
-- Configure language specific definitions and capabilities
require 'langs.syntax_highlight'
require 'langs.language_server'
require 'styles'
-- Configure custom automations
require 'automation'

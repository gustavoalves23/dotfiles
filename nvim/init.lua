vim.g.mapleader = ' '

-- Initialize lazy.nvim and load the plugins
require 'bootstrap'
-- Define native nvim and plugins settings and keymaps
require 'settings'
-- Configure language specific definitions and capabilities
require 'langs.syntax_highlight'
require 'langs.language_server'
require 'langs.completion'
require 'langs.lint'
require 'langs.debug'
-- Configure custom automations
require 'automation'

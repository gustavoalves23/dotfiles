vim.g.mapleader = ' '

-- Initialize lazy.nvim and load the plugins
require 'bootstrap'
-- Define settings and keymaps for nvim and plugins
require 'settings'
-- Configure language specific definitions and capabilities
require 'langs.syntax_highlight'
require 'langs.language_server'
require 'langs.completion'
require 'langs.lint'
require 'langs.debug'
-- Configure custom automations
require 'automation'

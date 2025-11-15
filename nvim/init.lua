-- Enable Neovim's Lua module cache (:h vim.loader)
vim.loader.enable()

require('settings')
require('keymaps')
require('ui')
require('autocmds')

require('plugins')

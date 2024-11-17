-- General settings
vim.o.scrolloff = 8
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.foldmethod = 'indent'
vim.o.statusline = ""
vim.o.statusline = vim.o.statusline .. "%#LineNr#"
vim.o.statusline = vim.o.statusline .. " %f"

vim.api.nvim_exec('language en_US', true)

-- Set leader key
vim.g.mapleader = " "

-- Key mappings
-- vim.api.nvim_set_keymap = vim.keymap.set
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<leader>pv', ':Vex<CR>', opts)
map('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>', opts)
map('n', '<C-p>', ':GFiles<CR>', opts)
map('n', '<leader>pf', ':Files<CR>', opts)
map('n', '<C-k>', ':cnext<CR>', opts)
map('n', '<C-j>', ':cprev<CR>', opts)
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
map('v', '<leader>p', '"_dP', opts)

-- Yank to system clipboard
map('v', '<leader>y', '"*y', opts)
map('n', '<leader>y', '"*y', opts)
map('n', '<leader>Y', 'magg"*yG`a', opts)

-- Misc key mappings
map('n', '<leader>nh', ':nohl<CR>', { noremap = true, silent = true })
map('n', '<leader>\'', '<C-^>', { noremap = true })

-- Set colorscheme
vim.cmd('colorscheme codedark')

-- Load Lua files
require('plugins')


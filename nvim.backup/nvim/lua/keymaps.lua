-- keymaps.lua
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- General mappings
map('n', '<leader>pv', ':Vex<CR>', opts)
map('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>:lua print("Nvim config reloaded")<CR>', opts)
-- map('n', '<C-p>', ':GFiles<CR>', opts)
-- map('n', '<leader>pf', ':Files<CR>', opts)

-- Motions
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
map('n', '<leader>nh', ':nohl<CR>', opts)
map('n', '<leader>\'', '<C-^>', opts)

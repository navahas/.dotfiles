-- keymaps.lua
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- General mappings
map('n', '<leader>pv', ':Ex<CR>', opts)
map('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>:lua print(" Nvim: source reloaded")<CR>', opts)

-- Motions
-- Scroll down a quarter screen and center
vim.keymap.set("n", "<C-f>", function()
  vim.cmd("normal! " .. math.floor(vim.api.nvim_win_get_height(0) / 6) .. "j")
end, { noremap = true })

-- Scroll up a quarter screen and center
vim.keymap.set("n", "<C-i>", function()
  vim.cmd("normal! " .. math.floor(vim.api.nvim_win_get_height(0) / 6) .. "k")
end, { noremap = true })

map('n', '<c-k>', ':cnext<cr>', opts)
map('n', '<C-j>', ':cprev<CR>', opts)
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
map('n', 'J', 'mzJ`z', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', '<C-d>', '<C-d>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('v', '<leader>p', '"_dP', opts)

-- Yank to system clipboard
map('v', '<leader>y', '"*y', opts)
map('n', '<leader>y', '"*y', opts)
map('n', '<leader>Y', 'magg"*yG`a', opts)

-- Misc key mappings
map('n', '<leader>nh', ':nohl<CR>', opts)
map('n', '<leader>nw', ':set wrap!<CR>', opts)
map('n', '<leader>\'', '<C-^>', opts)

-- Custom Commands
vim.keymap.set('n', '<C-Space>', ':ToggleDiagnostics<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>hn', ':ToggleColorizer<CR>', { noremap = true, silent = true })

-- Wrapped lines
vim.keymap.set({'n', 'v'}, 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, {expr = true})

vim.keymap.set({'n', 'v'}, 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, {expr = true})

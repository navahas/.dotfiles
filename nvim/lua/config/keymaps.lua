-- keymaps.lua
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- General mappings
map('n', '<leader>pv', ':Ex<CR>', opts)
map('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>:lua print(" Nvim: source reloaded")<CR>', opts)

-- Motions
-- Scroll down a quarter screen and center
local function scroll_down_small()
  vim.cmd("normal! " .. math.floor(vim.api.nvim_win_get_height(0) / 6) .. "j")
end

-- Scroll up a quarter screen and center
local function scroll_up_small()
  vim.cmd("normal! " .. math.floor(vim.api.nvim_win_get_height(0) / 6) .. "k")
end

vim.keymap.set({"n", "v"}, "<C-j>", scroll_down_small, { noremap = true })
vim.keymap.set({"n", "v"}, "<C-k>", scroll_up_small, { noremap = true })

map('n', '<C-l>', ':cnext<CR>', opts)
map('n', '<C-h>', ':cprev<CR>', opts)
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
-- vim.keymap.set('n', '<C-Space>', ':ToggleDiagnostics<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Space>', ':ShowDiagnostics<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>hn', ':ToggleColorizer<CR>', { noremap = true, silent = true })

-- Wrapped lines
vim.keymap.set({'n', 'v'}, 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, {expr = true})

vim.keymap.set({'n', 'v'}, 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, {expr = true})


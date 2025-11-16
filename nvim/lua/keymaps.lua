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

vim.keymap.set({ "n", "v" }, "<C-j>", scroll_down_small, { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-k>", scroll_up_small, { noremap = true })

map('n', '<C-l>', ':cnext<CR>', opts)
map('n', '<C-h>', ':cprev<CR>', opts)
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
map('n', 'J', 'mzJ`z', opts)
-- map('n', '<C-u>', '<C-u>zz', opts)
-- map('n', '<C-d>', '<C-d>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('v', '<leader>p', '"_dP', opts)

-- Basic autopairing with smart closing
map('i', '(', '()<Left>', opts)
map('i', '{', '{}<Left>', opts)
map('i', '[', '[]<Left>', opts)
map('i', '"', '""<Left>', opts)
map('i', '\'', '\'\'<Left>', opts)

-- Smart closing: skip over closing character if it's already there
local function smart_close(char, is_quote)
    return function()
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local next_char = line:sub(col + 1, col + 1)

        if next_char == char then
            -- Skip over the existing closing character
            return '<Right>'
        elseif is_quote then
            -- For quotes, insert the pair
            return char .. char .. '<Left>'
        else
            -- For brackets/parens, just insert the closing character
            return char
        end
    end
end

vim.keymap.set('i', ')', smart_close(')', false), { noremap = true, expr = true })
vim.keymap.set('i', '}', smart_close('}', false), { noremap = true, expr = true })
vim.keymap.set('i', ']', smart_close(']', false), { noremap = true, expr = true })
vim.keymap.set('i', '"', smart_close('"', true), { noremap = true, expr = true })
vim.keymap.set('i', '\'', smart_close('\'', true), { noremap = true, expr = true })

-- Smart newline indentation
vim.keymap.set('i', '<CR>', function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local before = col > 0 and line:sub(col, col) or ''
    local after = line:sub(col + 1, col + 1)

    -- Check if cursor is between matching pairs
    local pairs = {
        ['{'] = '}',
        ['('] = ')',
        ['['] = ']',
        ['"'] = '"',
        ["'"] = "'"
    }

    if pairs[before] == after then
        return '<CR><C-o>O'
    end
    return '<CR>'
end, { noremap = true, expr = true })

-- Yank to system clipboard
map('v', '<leader>y', '"*y', opts)
map('n', '<leader>y', '"*y', opts)
map('n', '<leader>Y', 'magg"*yG`a', opts)

-- Misc key mappings
map('n', '<leader>nh', ':nohl<CR>', opts)
map('n', '<leader>nw', ':set wrap!<CR>', opts)
map('n', '<leader>\'', '<C-^>', opts)
-- map('n', '<C-F>', 'magg=G`a', opts)

-- Wrapped lines
vim.keymap.set({ 'n', 'v' }, 'j', function()
    return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true })

vim.keymap.set({ 'n', 'v' }, 'k', function()
    return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

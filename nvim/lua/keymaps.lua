-- keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General mappings
map('n', '<leader>pv', ':Ex<CR>', opts)
map('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>:lua print(" Nvim: source reloaded")<CR>', opts)

-- Motions
local function scroll_down_small()
    vim.cmd("normal! " .. math.floor(vim.api.nvim_win_get_height(0) / 6) .. "j")
end

local function scroll_up_small()
    vim.cmd("normal! " .. math.floor(vim.api.nvim_win_get_height(0) / 6) .. "k")
end

map({ "n", "v" }, "<C-j>", scroll_down_small, { noremap = true })
map({ "n", "v" }, "<C-k>", scroll_up_small, { noremap = true })

map("n", "<C-F>", function()
    if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
        vim.lsp.buf.format({ async = true })
    else
        vim.cmd("normal! mzvap=`z")
    end
end, opts)

map('n', '<C-l>', ':cnext<CR>', opts)
map('n', '<C-h>', ':cprev<CR>', opts)

map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
map('n', 'J', 'mzJ`z', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('v', '<leader>p', '"_dP', opts)

map('n', '<Space>]', ']<Space>', { silent = true })
map('n', '<Space>[', '[<Space>', { silent = true })

-- Autopairing
local function auto_pair(open_char, close_char)
    return function()
        return open_char .. close_char .. '<Left>'
    end
end

map('i', '(', auto_pair('(', ')'), { noremap = true, expr = true })
map('i', '{', auto_pair('{', '}'), { noremap = true, expr = true })
map('i', '[', auto_pair('[', ']'), { noremap = true, expr = true })
map('i', '"', auto_pair('"', '"'), { noremap = true, expr = true })
map('i', "'", auto_pair("'", "'"), { noremap = true, expr = true })

-- Smart newline indentation
map('i', '<CR>', function()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local before = col > 0 and line:sub(col, col) or ''
    local after = line:sub(col + 1, col + 1)

    local pairs = { ['{'] = '}', ['('] = ')', ['['] = ']', ['"'] = '"', ["'"] = "'" }

    if pairs[before] == after then
        return '<CR><C-o>O'
    end
    return '<CR>'
end, { noremap = true, expr = true })

-- Yank to system clipboard
map({ 'v', 'n' }, '<leader>y', '"*y', opts)
map('n', '<leader>Y', 'magg"*yG`a', opts)

-- Marks: swap ' and ` (' jumps to line+column, ` jumps to line only)
map('n', "'", '`', opts)
map('n', '`', "'", opts)

-- Misc
map('n', '<leader>nh', ':nohl<CR>', opts)
map('n', '<leader>nw', ':set wrap!<CR>', opts)
map('n', "<leader>'", '<C-^>', opts)

-- Wrapped lines
map({ 'n', 'v' }, 'j', function() return vim.v.count == 0 and 'gj' or 'j' end, { expr = true })
map({ 'n', 'v' }, 'k', function() return vim.v.count == 0 and 'gk' or 'k' end, { expr = true })

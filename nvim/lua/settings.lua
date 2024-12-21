-- Initial Settings
-- Custom mode display for fun
vim.opt.showmode = false
local mode_map = {
    n = "",
    i = " ──> INSERT",
    v = " ──> VISUAL",
    V = " ──> VISUAL LINE",
    ["\22"] = " ──> VISUAL BLOCK",
    c = " ──> COMMAND",
    s = " ──> SELECT",
    t = " ──> TERMINAL",
}

-- Custom mode display in the command area
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        local mode = vim.fn.mode()
        local msg = mode_map[mode] or " ── UNKNOWN ──"
        vim.cmd("echomsg '" .. msg .. "'")
    end,
})

-- settings.lua
vim.o.mouse = 'n'
vim.o.scrolloff = 8
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.foldmethod = 'indent'
vim.o.foldlevelstart = 99  -- Open all folds by default
vim.api.nvim_exec2('language en_US', { output = true })

-- Leader key
vim.g.mapleader = " "
vim.g.netrw_banner = 0

-- Status Line
vim.o.statusline = ""
vim.o.statusline = vim.o.statusline .. "%#LineNr#" -- Highlight group
vim.o.statusline = vim.o.statusline .. " %f" -- File name
vim.o.statusline = vim.o.statusline .. " %{&fileencoding?&fileencoding:&encoding}" -- File encoding (e.g., UTF-8)
vim.o.statusline = vim.o.statusline .. " %= "      -- Right-align the rest
vim.o.statusline = vim.o.statusline .. " %l:%c"    -- Line and column
vim.o.statusline = vim.o.statusline .. " %p%%"     -- Percentage through the file

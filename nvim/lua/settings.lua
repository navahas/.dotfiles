-- Initial Settings
-- Custom mode display for fun
vim.opt.showmode = false
local mode_map = {
    n = "",
    i = " ── INSERT ──",
    v = " ── VISUAL ──",
    V = " ── VISUAL LINE ──",
    ["\22"] = " ── VISUAL BLOCK ──",
    c = " ── COMMAND ──",
    s = " ── SELECT ──",
    t = " ── TERMINAL ──",
}

-- Custom mode display in the command area
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        local mode = vim.fn.mode()
        local msg = mode_map[mode] or " ── UNKNOWN ──"
        vim.cmd("echohl ModeMsg | echom '" .. msg .. "' | echohl None")
    end,
})

-- settings.lua
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

-- Status Line
vim.o.statusline = ""
vim.o.statusline = vim.o.statusline .. "%#LineNr#"
vim.o.statusline = vim.o.statusline .. " %f"

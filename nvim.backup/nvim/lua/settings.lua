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
vim.api.nvim_exec2('language en_US', { output = true })

-- Leader key
vim.g.mapleader = " "

-- Status Line
vim.o.statusline = ""
vim.o.statusline = vim.o.statusline .. "%#LineNr#"
vim.o.statusline = vim.o.statusline .. " %f"

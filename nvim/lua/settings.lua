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
vim.o.winborder = "rounded"

vim.cmd([[
  cnoreabbrev W w
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
]])

-- Leader key & netrw
vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = 'noma nomod nobl nowrap ro nu rnu'

vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false   -- Disable backups
vim.opt.undofile = true  -- Enable persistent undo

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

vim.cmd([[
  cnoreabbrev W w
  cnoreabbrev Wq wq
  cnoreabbrev WQ wq
]])

_G.mystatus = {}
_G.mystatus.getPath = function()
  local filename = vim.fn.expand('%:t')  -- Get the filename (tail)
  if filename == '' or filename == '[No Name]' then
    -- Return the current directory, replacing the home directory with ~
    -- return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
    return ''
  else
    -- Return the file path, replacing the home directory with ~
    return vim.fn.fnamemodify(vim.fn.expand('%:p'), ':~')
  end
end

_G.mystatus.getStatusString = function()
    local path = _G.mystatus.getPath()
    if path == '' then
        return ''
    else
        return path .. " %{&fileencoding?&fileencoding:&encoding} %= %l:%c  %p%%  "
    end
end

-- Leader key & netrw
vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = 'noma nomod nobl nowrap ro nu rnu'

-- Status Line
vim.cmd([[
  highlight MyStatusLine guibg=NONE guifg=#5A5A5A
]])
vim.o.statusline = "%#MyStatusLine# %{%v:lua.mystatus.getStatusString()%}"
-- vim.o.statusline = vim.o.statusline .. " %f" -- File name

vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false   -- Disable backups
vim.opt.undofile = true  -- Enable persistent undo

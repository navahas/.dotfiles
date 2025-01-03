-- Initial Settings
-- Custom mode display for fun
vim.opt.showmode = false
local mode_map = {
    n = "",
    i = " ──> INSERT",
    v = " ──> VISUAL",
    V = " ──> VISUAL LINE",
    ["\22"] = " ──> VISUAL BLOCK",
    s = " ──> SELECT",
    c = ""
    -- t = " ──> TERMINAL",
}

local function update_mode_display()
    local current_mode = vim.api.nvim_get_mode().mode
    local msg = mode_map[current_mode] or ""
    vim.api.nvim_echo({{msg, "ModeMsg"}}, false, {})
end

vim.api.nvim_create_autocmd({"ModeChanged", "CmdlineEnter", "CmdlineLeave"}, {
    pattern = "*",
    callback = update_mode_display
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

-- Leader key & netrw
vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_bufsettings = 'noma nomod nobl nowrap ro nu rnu'
-- Status Line
vim.o.statusline = ""
vim.o.statusline = vim.o.statusline .. "%#LineNr#" -- Highlight group
vim.o.statusline = vim.o.statusline .. " %f" -- File name
vim.o.statusline = vim.o.statusline .. " %{&fileencoding?&fileencoding:&encoding}" -- File encoding (e.g., UTF-8)
vim.o.statusline = vim.o.statusline .. " %= "      -- Right-align the rest
vim.o.statusline = vim.o.statusline .. " %l:%c"    -- Line and column
vim.o.statusline = vim.o.statusline .. " %p%%"     -- Percentage through the file

vim.opt.swapfile = false -- Disable swap files
vim.opt.backup = false   -- Disable backups
vim.opt.undofile = true  -- Enable persistent undo


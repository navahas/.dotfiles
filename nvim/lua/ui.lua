-- ============================================
-- STATUSLINE
-- ============================================

local function getPath()
    local filename = vim.fn.expand('%:t')
    if filename == '' or filename == '[No Name]' then
        return ''
    end
    return vim.fn.fnamemodify(vim.fn.expand('%:p'), ':~')
end

_G.getStatusString = function()
    local path = getPath()
    if path == '' then return '' end
    return path .. " %{&fileencoding?&fileencoding:&encoding} %= %l:%c  %p%%  "
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#5A5A5A" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#3A3A3A" })
    end,
})

vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#5A5A5A" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#3A3A3A" })
vim.o.statusline = "%#MyStatusLine# %{%v:lua.getStatusString()%}"

-- ============================================
-- CUSTOM MODE DISPLAY
-- ============================================

local mode_display_enabled = true

vim.opt.showmode = false

local style_operator = "-->"
local mode_map = {
    n    = " ",
    v    = " " .. style_operator .. " VISUAL",
    V    = " " .. style_operator .. " VISUAL LINE",
    ["\22"] = " " .. style_operator .. " VISUAL BLOCK",
    s    = " " .. style_operator .. " SELECT",
    i    = " " .. style_operator .. " INSERT",
    ic   = " " .. style_operator .. " INSERT (completion)",
    R    = " " .. style_operator .. " REPLACE",
    Rv   = " " .. style_operator .. " VIRTUAL REPLACE",
    cv   = " " .. style_operator .. " EX",
    no   = " " .. style_operator .. " OPERATOR-PENDING",
}

local function toggle_mode_display()
    mode_display_enabled = not mode_display_enabled
    vim.opt.showmode = not mode_display_enabled
    if mode_display_enabled then
        print("Custom mode display enabled")
    else
        print("Default mode display enabled")
    end
end

vim.api.nvim_create_user_command('ToggleModeDisplay', toggle_mode_display, {})

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        if not mode_display_enabled then return end
        local msg = mode_map[vim.fn.mode()]
        if not msg or msg == "" then return end
        vim.api.nvim_echo({ { msg } }, false, {})
    end,
})

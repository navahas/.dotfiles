-- ╭──────────────────────────────────────────────╮
-- │ UI: VISUAL ELEMENTS & STATUSLINE             │
-- ╰──────────────────────────────────────────────╯

-- ============================================
-- STATUSLINE
-- ============================================

local getPath = function()
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

_G.getStatusString = _G.getStatusString or function()
    local path = getPath()
    if path == '' then
        return ''
    else
        return path .. " %{&fileencoding?&fileencoding:&encoding} %= %l:%c  %p%%  "
    end
end

-- StatusLine highlight colors
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

local mode_map = {
    n = " ",
    i = " ——> INSERT",
    v = " ——> VISUAL",
    V = " ——> VISUAL LINE",
    ["\22"] = " ——> VISUAL BLOCK",
    s = " ——> SELECT",
    t = " ——> TERMINAL",
}

-- Toggle function for mode display
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

-- Custom mode display in the command area
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        if not mode_display_enabled then
            return
        end
        local mode = vim.fn.mode()
        local msg = mode_map[mode]
        if not msg then return end
        if msg == "" then return end
        vim.cmd("echomsg '" .. msg .. "'")

    end,
})

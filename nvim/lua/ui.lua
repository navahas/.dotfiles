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

local style_operator = "——>"
local mode_map = {
    -- Normal modes
    n = " ",
    no = " " .. style_operator .. " OPERATOR-PENDING",
    nov = " " .. style_operator .. " OPERATOR-PENDING (charwise)",
    noV = " " .. style_operator .. " OPERATOR-PENDING (linewise)",
    ["\22"] = " " .. style_operator .. " VISUAL BLOCK",  -- CTRL-V
    ["no\22"] = " " .. style_operator .. " OPERATOR-PENDING (blockwise)",
    niI = " " .. style_operator .. " NORMAL (insert)",
    niR = " " .. style_operator .. " NORMAL (replace)",
    niV = " " .. style_operator .. " NORMAL (virtual replace)",
    nt = " " .. style_operator .. " NORMAL (terminal)",
    ntT = " " .. style_operator .. " NORMAL (terminal ctrl-o)",

    -- Visual modes
    v = " " .. style_operator .. " VISUAL",
    vs = " " .. style_operator .. " VISUAL (select)",
    V = " " .. style_operator .. " VISUAL LINE",
    Vs = " " .. style_operator .. " VISUAL LINE (select)",
    ["\22s"] = " " .. style_operator .. " VISUAL BLOCK (select)",  -- CTRL-Vs

    -- Select modes
    s = " " .. style_operator .. " SELECT",
    S = " " .. style_operator .. " SELECT LINE",
    ["\19"] = " " .. style_operator .. " SELECT BLOCK",  -- CTRL-S

    -- Insert modes
    i = " " .. style_operator .. " INSERT",
    ic = " " .. style_operator .. " INSERT (completion)",
    ix = " " .. style_operator .. " INSERT (ctrl-x completion)",

    -- Replace modes
    R = " " .. style_operator .. " REPLACE",
    Rc = " " .. style_operator .. " REPLACE (completion)",
    Rx = " " .. style_operator .. " REPLACE (ctrl-x completion)",
    Rv = " " .. style_operator .. " VIRTUAL REPLACE",
    Rvc = " " .. style_operator .. " VIRTUAL REPLACE (completion)",
    Rvx = " " .. style_operator .. " VIRTUAL REPLACE (ctrl-x completion)",

    -- Command-line modes
    -- c = " " .. style_operator .. " COMMAND",
    -- cr = " " .. style_operator .. " COMMAND (overstrike)",
    cv = " " .. style_operator .. " EX",
    cvr = " " .. style_operator .. " EX (overstrike)",

    -- Prompt modes
    -- r = " " .. style_operator .. " HIT-ENTER",
    -- rm = " " .. style_operator .. " MORE",
    -- ["r?"] = " " .. style_operator .. " CONFIRM",

    -- Other
    -- ["!"] = " " .. style_operator .. " SHELL",
    -- t = " " .. style_operator .. " TERMINAL",
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

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


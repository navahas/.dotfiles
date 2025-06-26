-- ╭──────────────────────────────────────────────╮
-- │ LSP DIAGNOSTICS                              │
-- ╰──────────────────────────────────────────────╯
vim.g.diagnostics_visible = true
vim.api.nvim_create_user_command('ShowDiagnostics', function()
    if vim.g.diagnostics_visible then
        vim.api.nvim_echo({{ " ——> LSP diagnostics are visible", "" }}, true, {});
    else
        vim.api.nvim_echo({{ " ——> LSP diagnostics are hidden", "DiagnosticHint" }}, true, {});
    end
end, {})

vim.api.nvim_create_user_command('ToggleDiagnostics', function()
    if vim.g.diagnostics_visible then
        vim.diagnostic.enable(false)
        vim.g.diagnostics_visible = false
    else
        vim.diagnostic.enable(true)
        vim.g.diagnostics_visible = true
    end
end, {})

-- ╭──────────────────────────────────────────────╮
-- │ COLORIZER                                    │
-- ╰──────────────────────────────────────────────╯
vim.g.colorizer_on = false
vim.api.nvim_create_user_command('ToggleColorizer', function()
    if vim.g.colorizer_on then
        vim.cmd('ColorizerDetachFromBuffer')
        vim.g.colorizer_on = false
    else
        vim.cmd('ColorizerAttachToBuffer')
        vim.g.colorizer_on = true
    end
end, {})


-- ╭──────────────────────────────────────────────╮
-- │ SUPERMAVEN                                   │
-- ╰──────────────────────────────────────────────╯
vim.api.nvim_create_user_command("ToggleSupermaven", function()
    local supermaven_api = require("supermaven-nvim.api")
    if supermaven_api.is_running() then
        supermaven_api.stop()
        print("Supermaven: OFF.")
    else
        supermaven_api.start()
        print("Supermaven: ON.")
    end
end, {})
vim.keymap.set("n", "<Tab>o", "<cmd>ToggleSupermaven<CR>", {
  desc = "Toggle Supermaven",
})

-- ╭──────────────────────────────────────────────╮
-- │ MACROS: AUTO FILETYPE SETUP                  │
-- ╰──────────────────────────────────────────────╯
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.api.nvim_create_augroup('@RustPrint', { clear = true })
vim.api.nvim_create_augroup('@TypeScriptPrint', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    group = '@RustPrint',
    pattern = { 'rust' },
    callback = function()
        local macro = 'yo' .. 'println!("@ ----> {}", ' .. esc .. 'pa);' .. esc
        vim.fn.setreg("l", macro)
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = '@TypeScriptPrint',
    pattern = { 'javascript', 'typescript' },
    callback = function()
        local macro = 'yo' .. 'console.log("@ ----> ", ' .. esc .. 'pa);' .. esc
        vim.fn.setreg("l", macro)
    end
})

-- ╭──────────────────────────────────────────────╮
-- │ GIT FILE HISTORY                             │
-- ╰──────────────────────────────────────────────╯
-- Open last N commits of the current file in quickfix list
-- Call with number of versions you want
-- :lua OpenFileHistoryInQuickfix(5)
function OpenFileHistoryInQuickfix(n)
    local file = vim.fn.expand('%')
    local commits = vim.fn.systemlist("git log -n " .. n .. " --pretty=format:%H -- " .. file)
    local qf_entries = {}

    for _, sha in ipairs(commits) do
        local temp_path = "/tmp/" .. sha .. "_" .. vim.fn.fnamemodify(file, ":t")
        vim.fn.system("git show " .. sha .. ":" .. file .. " > " .. temp_path)
        table.insert(qf_entries, {
            filename = temp_path,
            lnum = 1,
            col = 1,
            text = "Commit: " .. sha
        })
    end

    vim.fn.setqflist(qf_entries, 'r')
    vim.cmd("copen")
end


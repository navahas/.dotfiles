-- Create command to toggle lsp diagnostics

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

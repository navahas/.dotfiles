-- Create command to toggle lsp diagnostics

vim.g.diagnostics_visible = true

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

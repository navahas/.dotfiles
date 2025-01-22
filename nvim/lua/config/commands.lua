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

vim.keymap.set('n', '<C-Space>', ':ToggleDiagnostics<CR>', { noremap = true, silent = true })

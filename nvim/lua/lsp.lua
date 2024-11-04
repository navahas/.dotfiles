local lspconfig = require('lspconfig')

lspconfig.ts_ls.setup({
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
    on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap = true, silent = true }

        -- Key mappings for LSP
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

        client.server_capabilities.documentFormattingProvider = false
   end,

   -- This ensures tsserver works for TypeScript and JavaScript
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    -- Command to run the TypeScript language server
    cmd = { "typescript-language-server", "--stdio" }
})


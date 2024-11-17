-- lsp.lua
local lspconfig = require('lspconfig')

-- Setup mason
require('mason').setup()

-- Setup mason-lspconfig
require('mason-lspconfig').setup({
    ensure_installed = { "ts_ls", "lua_ls" },
    automatic_installation = true,
})

-- Function for common keymaps for LSP servers
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- Common LSP Keybindings
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    -- Disable document formatting for ts_ls
    if client.name == "ts_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end
end

-- TypeScript server setup
lspconfig.ts_ls.setup({
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    cmd = { "typescript-language-server", "--stdio" }
})

-- Lua language server setup
lspconfig.lua_ls.setup({
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                return
            end
        end
        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME }
            }
        })
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        return true
    end,
    on_attach = on_attach, -- Add this line
    settings = {
        Lua = {}
    }
})


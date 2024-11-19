-- lsp.lua
local lspconfig = require('lspconfig')

-- Global diagnostic configuration
vim.diagnostic.config({
    virtual_text = true, -- Show diagnostics inline
    signs = true,        -- Show signs in the sign column
    underline = true,    -- Underline diagnostic issues
    update_in_insert = true, -- Don't update diagnostics while typing
    severity_sort = true, -- Sort diagnostics by severity
    float = {
        source = true, -- Show the source of diagnostics (e.g., "eslint")
        border = "rounded", -- Rounded border for floating windows
    },
})

-- Setup mason & mason-lspconfig
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { "ts_ls", "lua_ls" },
    automatic_installation = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
    -- Extra
    buf_set_keymap('n', '<leader>vws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    buf_set_keymap('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- Disable document formatting for ts_ls
    if client.name == "ts_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end
end

-- TypeScript server setup
lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    cmd = { "typescript-language-server", "--stdio" },
    flags = {
        debounce_text_changes = 150, -- Avoid frequent updates
    },
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
            },
        },
    }
})

-- Lua language server setup
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
    settings = {
        Lua = {}
    }
})


-- lsp.lua
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

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

-- Capabilities setup with cmp_nvim_lsp
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion = {
    completionItem = {
        snippetSupport = true,
    },
    triggerCharacters = {}, -- Disable automatic triggers globally
}

local max_file_size = 100 * 1024 -- 100 KB limit

-- Function for common keymaps for LSP servers
local on_attach = function(client, bufnr)
    -- Disable auto-trigger for completions (safety net)
    if client.server_capabilities.completionProvider then
        client.server_capabilities.completionProvider.triggerCharacters = {}
    end

    local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
    if file_size > max_file_size then
        vim.notify(
          string.format(
            "LSP disabled for %s (file size %d KB exceeds limit)",
            vim.api.nvim_buf_get_name(bufnr),
            file_size / 1024
          ),
          vim.log.levels.WARN
        )
        vim.lsp.stop_client(client.id)
        return
    end

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
end

-- TypeScript server setup
lspconfig.ts_ls.setup({
    capabalities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Disable formatting for tsserver
        client.server_capabilities.documentFormattingProvider = false
    end,
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


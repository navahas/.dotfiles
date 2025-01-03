return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = true,
            severity_sort = true,
            float = {
                source = true,
                border = "rounded",
            },
        })

        -- Setup Mason and Mason-LSPConfig
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "ts_ls", "lua_ls", "zls" },
            automatic_installation = true,
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        -- Common on_attach function
        local on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, bufopts)

            -- Extra
            vim.keymap.set('n', '<leader>vws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', bufopts)
            vim.keymap.set('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
            vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<CR>', bufopts)
            vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', bufopts)
            vim.keymap.set('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufopts)
            vim.keymap.set('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)
            vim.keymap.set('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
            vim.keymap.set('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopts)
        end

        -- TypeScript Server
        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = lspconfig.util.root_pattern("package.json"),
            filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        })

        -- Lua Server
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })

        -- Zig Server
        lspconfig.zls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}

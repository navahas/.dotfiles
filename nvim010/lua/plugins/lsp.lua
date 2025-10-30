return {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
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
        -- Ensure rounded borders for hover, signature help, and diagnostics
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "rounded" }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "rounded" }
        )

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            { float = { border = "rounded" } }
        )

        -- Setup Mason and Mason-LSPConfig
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "ts_ls",
                "denols",
                "lua_ls",
                "rust_analyzer",
                "zls"
            },
            automatic_installation = true,
            automatic_enable = false
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        -- Common on_attach function
        local on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, bufopts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "<C-F>", function()
                vim.lsp.buf.format({ async = true })
            end, bufopts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next, bufopts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, bufopts)

            -- vim.keymap.set('n', '<leader>vws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', bufopts)
            -- vim.keymap.set('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', bufopts)
            -- vim.keymap.set('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopts)
            -- vim.keymap.set('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopts)
        end

        -- TypeScript Server
        local ts_ls = function()
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern("package.json"),
                -- filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
            })
        end

        -- Deno Typescript Server
        local deno_ls = function()
            lspconfig.denols.setup({
                capabilities = capabilities,
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            })
        end

        local tslsp = function ()
            local cwd = vim.fn.getcwd()
            if lspconfig.util.root_pattern("package.json")(cwd) then
                ts_ls()
            elseif lspconfig.util.root_pattern("deno.json", "deno.jsonc")(cwd) then
                deno_ls()
            end
        end
        tslsp()

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

        -- Rust Server
        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                ["rust-analyzer"] = {
                    rustfmt = {
                        enable = true,
                    }
                }
            }
        })

        -- Zig Server
        lspconfig.zls.setup({
            capabilities = capabilities,
            on_attach = on_attach,

        })

        -- C server
        lspconfig.clangd.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Nix server
        lspconfig.nixd.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}

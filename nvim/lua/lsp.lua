-- Native LSP Configuration for Neovim 0.11+
-- Uses vim.lsp.config() and vim.lsp.enable() instead of nvim-lspconfig

-- Configure completion popup
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10  -- Max items in popup
vim.opt.pumblend = 0    -- No transparency

-- Set up keymaps when LSP attaches to buffer
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<C-F>", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
        vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_prev, opts)
    end,
})

-- Enable LSP servers
-- Note: Server configs are automatically loaded from ~/.config/nvim/lsp/*.lua
vim.lsp.enable({
    'lua_ls',
    'rust_analyzer',
    'zls',
    'clangd',
})

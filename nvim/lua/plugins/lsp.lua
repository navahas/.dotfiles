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
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
    end,
})

-- Mason installs LSP binaries
require("mason").setup({})
local mason_lspconfig = require("mason-lspconfig")

local servers = {
    "lua_ls",
    "rust_analyzer",
    "ts_ls",
    "clangd",
    "zls",
}

mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

-- Load nvim-lspconfig for commands (:LspStart, :LspStop, etc.)
-- But use vim.lsp.config for actual configuration (nvim 0.11+)
require("lspconfig")

-- Load custom LSP configurations from lsp/*.lua directory into vim.lsp.config
local lsp_config_dir = vim.fn.stdpath('config') .. '/lsp'

if vim.fn.isdirectory(lsp_config_dir) == 1 then
    for _, file in ipairs(vim.fn.glob(lsp_config_dir .. '/*.lua', false, true)) do
        local server_name = vim.fn.fnamemodify(file, ':t:r')
        local ok, config = pcall(dofile, file)
        if ok and type(config) == 'table' then
            vim.lsp.config[server_name] = config
        end
    end
end

-- Enable LSP servers
vim.lsp.enable(servers)

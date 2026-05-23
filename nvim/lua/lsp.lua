-- Configure completion popup
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10 -- Max items in popup
vim.opt.pumblend = 0   -- No transparency

-- Set up keymaps when LSP attaches to buffer
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local opts = { buffer = args.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
        vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, { desc = "Document symbols (loclist)" })

        vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
            autotrigger = false,
            convert = function(item) return { abbr = item.label:gsub('%b()', ''), menu = '' } end,
        })
        vim.keymap.set('i', '<C-Space>', function() vim.lsp.completion.get() end, opts)
    end,
})

require("mason").setup({})

local servers = {
    "lua_ls",
    "rust_analyzer",
    "ts_ls",
    "clangd",
    "zls",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

local lsp_config_dir = vim.fn.stdpath('config') .. '/lsp'
if vim.fn.isdirectory(lsp_config_dir) == 1 then
    for _, file in ipairs(vim.fn.glob(lsp_config_dir .. '/*.lua', false, true)) do
        local server_name = vim.fn.fnamemodify(file, ':t:r')
        local ok, config = pcall(dofile, file)
        if ok and type(config) == 'table' then
            config.capabilities = capabilities
            vim.lsp.config[server_name] = config
        end
    end
end

vim.lsp.enable(servers)

local function buf_client_names()
    return vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 }))
end

vim.api.nvim_create_user_command('LspStatus', function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        print("No LSP clients attached to this buffer")
        return
    end
    for _, c in ipairs(clients) do
        print(string.format("[%d] %s — %s", c.id, c.name, c.root_dir or "no root"))
    end
end, {})

vim.api.nvim_create_user_command('LspStop', function(opts)
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if opts.args ~= '' then
        clients = vim.tbl_filter(function(c) return c.name == opts.args end, clients)
    end
    for _, c in ipairs(clients) do
        c:stop()
        print("Stopped: " .. c.name)
    end
end, {
    nargs = '?',
    complete = buf_client_names,
})

vim.api.nvim_create_user_command('LspRestart', function(opts)
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if opts.args ~= '' then
        clients = vim.tbl_filter(function(c) return c.name == opts.args end, clients)
    end
    for _, c in ipairs(clients) do
        local name = c.name
        c:stop()
        vim.defer_fn(function() vim.lsp.enable(name) end, 500)
        print("Restarting: " .. name)
    end
end, {
    nargs = '?',
    complete = buf_client_names,
})

require("mason").setup({})
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ts_ls",
        "clangd",
        "zls",
    },
    automatic_installation = true,
})

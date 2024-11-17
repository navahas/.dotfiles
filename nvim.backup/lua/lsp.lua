local lspconfig = require('lspconfig')

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

    -- Disable document formatting for tsserver
    if client.name == "ts_ls" then
        client.server_capabilities.documentFormattingProvider = false
    end
end

lspconfig.ts_ls.setup({
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    cmd = { "typescript-language-server", "--stdio" }
})

lspconfig.lua_ls.setup{
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  },
  on_attach
}

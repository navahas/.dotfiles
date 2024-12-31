local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup Lazy.nvim to load all plugin specs from `lua/plugins/`
require("lazy").setup({
    spec = {
        { import = "plugins" }, -- Import all files from `lua/plugins/`
    },
    defaults = {
        lazy = true, -- All plugins lazy-loaded by default
    },
    install = {
        colorscheme = { "codedark", "vscode" },
    },
    ui = {
        border = "rounded",
    },
})


-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim
require("lazy").setup({
    -- Themes
    { "tomasiser/vim-code-dark" },
    { "Mofiqul/vscode.nvim" },

    -- Icons (load only when needed by other plugins)
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- Telescope (load on command)
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.telescope")
        end,
    },

    -- Harpoon (lazy-load on specific key mappings)
    {
        "ThePrimeagen/harpoon",
        keys = { "<leader>a", "<leader>h" },
        config = function()
            require("plugins.harpoon")
        end,
    },

    -- Mason (load on Mason-related commands)
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        dependencies = { "williamboman/mason.nvim" },
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" }, -- Load when editing files
        config = function()
            require("plugins.lsp")
        end,
    },

    -- Completion (load on InsertEnter for better responsiveness)
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" }, -- Ensure it loads with nvim-cmp
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
        },
        config = function()
            require("plugins.cmp")
        end,
    },

    -- Treesitter (optimize with specific parsers)
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost",
        build = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    },
    {
        "nvim-treesitter/playground",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    -- Utility libraries
    { "nvim-lua/plenary.nvim" },
    { "MunifTanjim/nui.nvim" },
})


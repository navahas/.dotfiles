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

    -- Icons (loaded only when required by dependencies)
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- Telescope (loads only when invoked)
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.telescope")
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        keys = { "<leader>a", "<leader>h" },
        config = function()
            require("plugins.harpoon")
        end,
    },

    -- Mason (Load on specific LSP or DAP commands)
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
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.lsp")
        end,
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            require("plugins.cmp")
        end,
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        dependencies = { "hrsh7th/nvim-cmp" }, -- Ensure it loads after `nvim-cmp`
    },


    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost",
        build = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    },
    { "nvim-treesitter/playground", dependencies = { "nvim-treesitter/nvim-treesitter" } },
})

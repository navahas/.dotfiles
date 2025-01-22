return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "lua",
                "javascript",
                "typescript",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "rust",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            modules = {},
            ignore_install = {}
        })
    end,
}

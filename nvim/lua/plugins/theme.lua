return {
    -- Theme: vim-code-dark
    {
        "tomasiser/vim-code-dark",
        lazy = false, -- Load immediately since it's a theme
        priority = 1000, -- Ensure it loads first
        config = function()
            vim.cmd([[colorscheme codedark]])
        end,
    },

    -- Theme: vscode.nvim
    {
        "Mofiqul/vscode.nvim",
        lazy = false, -- Load immediately since it's a theme
        priority = 1000, -- Ensure it loads first
        config = function()
            require("vscode").setup({
                -- Example: Use transparent background
                transparent = true,
            })
            vim.cmd([[colorscheme vscode]])
        end,
    },
}

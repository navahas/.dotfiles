require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "typescript",
        "markdown",
        "markdown_inline",
        "rust",
    },

    -- Install languages asynchronously (recommended)
    sync_install = false,

    -- Auto-install missing parsers when entering buffer
    auto_install = true,

    -- Enable highlighting
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
    },

    -- Enable indentation based on Treesitter
    indent = {
        enable = true,
    },
})

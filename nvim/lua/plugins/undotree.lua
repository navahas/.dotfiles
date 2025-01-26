return {
    "mbbill/undotree",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}

return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = { "<leader>pf", "<C-p>", "<leader>ps" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules/.*",
                    "package%-lock.json",
                    "dist/.*",
                },
            },
        })

        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "Search string" })
    end,
}

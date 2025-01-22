return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = { "<leader>pf", "<C-p>", "<leader>ps", "<leader>pe", "<leader>px" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },

    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        local function grep_word()
            local word
            if vim.fn.mode() == 'v' then
                -- Get visual selection
                local saved_reg = vim.fn.getreg('v')
                vim.cmd('noau normal! "vy"')
                word = vim.fn.getreg('v')
                vim.fn.setreg('v', saved_reg)
            else
                -- Get word under cursor
                word = vim.fn.expand("<cword>")
            end
            return word
        end

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules/.*",
                    "package%-lock.json",
                    "dist/.*",
                    -- Rust-specific ignores
                    "target/.*",           -- Build output directory
                    "Cargo.lock",          -- Lock file
                    ".rustup/.*",          -- Rust toolchain
                    ".cargo/.*",           -- Cargo cache
                    "*.rlib",              -- Rust library files
                    "*.rmeta",             -- Rust metadata files
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
        })

        -- Load fzf extension for performance
        telescope.load_extension('fzf')

        -- File finding
        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Git files" })
        vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Live grep (ripgrep)" })

        -- Custom Commands
        vim.keymap.set({ "n", "v" }, "<leader>pe", function()
            local search_word = grep_word()
            builtin.grep_string({ search = search_word })
        end, { desc = "Search word under cursor/selection" })

        vim.keymap.set("n", "<leader>px", function()
            -- local query = vim.fn.input("Live Grep Exact > ")
            local query = grep_word()
            builtin.live_grep({
                default_text = query,
                additional_args = function()
                    return { "--fixed-strings" }
                end,
            })
        end, { desc = "Live grep exact match" })
        -- vim.keymap.set("n", "<leader>pe", function()
        --     builtin.grep_string({ search = vim.fn.input("Grep > ") })
        -- end, { desc = "Search string" })
    end,
}

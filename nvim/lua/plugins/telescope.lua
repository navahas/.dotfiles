local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- Word under cursor or visual selection
local function grep_word()
    if vim.fn.mode() == 'v' then
        local saved_reg = vim.fn.getreg('v')
        vim.cmd('noau normal! "vy"')
        local word = vim.fn.getreg('v')
        vim.fn.setreg('v', saved_reg)
        return word
    end
    return vim.fn.expand('<cword>')
end

-- Setup telescope
telescope.setup({
    defaults = {
        file_ignore_patterns = {
            "node_modules/.*",
            "package%-lock.json",
            "dist/.*",
            -- Rust-specific ignores
            "target/.*",
            "Cargo.lock",
            ".rustup/.*",
            ".cargo/.*",
            "*.rlib",
            "*.rmeta",
        },
    },
    pickers = {
        find_files = { previewer = false, layout_config = { height = 0.4 } },
        git_files = { previewer = false, layout_config = { height = 0.4 } },
        live_grep = { layout_strategy = "vertical" },
        grep_string = { layout_strategy = "vertical" },
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
pcall(telescope.load_extension, 'fzf')

-- Telescope keymaps
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Live grep (ripgrep)" })

vim.keymap.set({ "n", "v" }, "<leader>pe", function()
    local search_word = grep_word()
    builtin.grep_string({ search = search_word })
end, { desc = "Search selected cursor/section in vmode" })

vim.keymap.set("n", "<leader>px", function()
    local query = vim.fn.input("Grep —> ")
    builtin.live_grep({
        default_text = query,
        additional_args = function()
            return { "--fixed-strings" }
        end,
    })
end, { desc = "Live grep exact match" })

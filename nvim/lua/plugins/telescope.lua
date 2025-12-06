local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- Helper function to get input for grep
local function get_input()
    local ok, input_word = pcall(vim.fn.input, {
        prompt = "Grep —> ",
        cancelreturn = nil,
    })
    if not ok or not input_word then return end
    return input_word
end

-- Helper function to grep word under cursor or visual selection
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
        get_input()
    end
    return word
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

local function with_winborder(border, fn)
  return function(...)
    local old = vim.opt.winborder:get()
    vim.opt.winborder = border
    fn(...)
    vim.opt.winborder = old
  end
end

-- Telescope keymaps
vim.keymap.set("n", "<leader>pf", with_winborder("none", builtin.find_files), { desc = "Find files" })
vim.keymap.set("n", "<leader>pg", with_winborder("none", builtin.git_files), { desc = "Git files" })
vim.keymap.set("n", "<leader>ps", with_winborder("none", builtin.live_grep), { desc = "Live grep (ripgrep)" })

vim.keymap.set({ "n", "v" }, "<leader>pe", with_winborder("none", function()
    local search_word = grep_word()
    builtin.grep_string({ search = search_word })
end), { desc = "Search selected cursor/section in vmode" })

vim.keymap.set("n", "<leader>px", with_winborder("none", function()
    local query = vim.fn.input("Grep —> ")
    builtin.live_grep({
        default_text = query,
        additional_args = function()
            return { "--fixed-strings" }
        end,
    })
end), { desc = "Live grep exact match" })

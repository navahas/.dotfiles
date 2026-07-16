local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

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
        -- never auto-hide the preview pane in small windows
        preview = { preview_cutoff = 0 },
        layout_config = { preview_cutoff = 0 },
        mappings = {
            -- C-q: Tab-marked entries if any, else all results -> quickfix + open
            i = { ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist },
            n = { ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist },
        },
    },
    pickers = {
        find_files = {
            previewer = false,
            layout_config = { height = 0.4 },
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
        },
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

-- Bypasses Telescope picker/preview. Streams into quickfix, never blocks.
vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob '!.git'"
vim.o.grepformat = "%f:%l:%c:%m"

-- Run rg async, populate quickfix, open it. Editor stays responsive.
local function rg_to_qf(pattern, extra)
    if not pattern or pattern == "" then return end
    local cmd = { "rg", "--vimgrep", "--smart-case", "--hidden", "--glob", "!.git" }
    vim.list_extend(cmd, extra or {})
    table.insert(cmd, pattern)

    vim.system(cmd, { text = true }, function(out)
        vim.schedule(function()
            vim.fn.setqflist({}, " ", {
                title = "rg: " .. pattern,
                lines = vim.split(out.stdout or "", "\n", { trimempty = true }),
                efm = "%f:%l:%c:%m",
            })
            vim.cmd("copen")
        end)
    end)
end

-- Prompt grep -> quickfix
vim.keymap.set("n", "<leader>pq", function()
    rg_to_qf(vim.fn.input("rg —> "))
end, { desc = "rg to quickfix (async)" })

-- Word under cursor / selection -> grep_string picker (preview + filter).
-- Tab-mark results then <C-q> to send to quickfix.
vim.keymap.set({ "n", "v" }, "<leader>pw", function()
    builtin.grep_string({ search = grep_word() })
end, { desc = "Grep cword (preview)" })

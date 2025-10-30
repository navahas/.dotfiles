local bookmarks = {}

-- Add current buffer to bookmarks
function _G.bookmark_add()
    local name = vim.api.nvim_buf_get_name(0)
    if name == "" then
        print("No file name")
        return
    end
    -- Avoid duplicates
    for _, b in ipairs(bookmarks) do
        if b == name then
            print("Already bookmarked: " .. name)
            return
        end
    end
    table.insert(bookmarks, name)
    print("Bookmarked: " .. name)
end

-- List bookmarks
function _G.bookmark_list()
    if #bookmarks == 0 then
        print("No bookmarks")
        return
    end

    -- Create an unlisted scratch buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = true
    vim.bo[buf].filetype = "bookmarklist"

    -- Build content
    local lines = { "=== Bookmarks ===" }
    for i, name in ipairs(bookmarks) do
        local short = vim.fn.fnamemodify(name, ":~:.")
        table.insert(lines, string.format("  [%d] %s", i, short))
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false

    -- Open it in a split
    vim.cmd("split")
    local win = 0
    vim.api.nvim_win_set_buf(win, buf)
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.api.nvim_win_set_height(win, math.min(#lines + 1, 10))

    -- Keymaps inside the scratch buffer
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
    vim.keymap.set("n", "<CR>", function()
        local line = vim.fn.line(".")
        vim.cmd("close")
        if line > 1 then
            _G.bookmark_jump(line - 1)
        end
    end, { buffer = buf, silent = true })
end

-- Jump to a bookmark by index
function _G.bookmark_jump(i)
    local name = bookmarks[i]
    if not name then
        print("No bookmark at " .. i)
        return
    end
    vim.cmd("edit " .. vim.fn.fnameescape(name))
end

-- Optional: clear bookmarks
function _G.bookmark_clear()
    bookmarks = {}
    print("Bookmarks cleared")
end

-- Keymaps
vim.keymap.set("n", "<leader>a", _G.bookmark_add, { desc = "Bookmark current buffer" })
vim.keymap.set("n", "<leader>bl", _G.bookmark_list, { desc = "List bookmarks" })
vim.keymap.set("n", "<leader>1", function() _G.bookmark_jump(1) end, { desc = "Jump to bookmark 1" })
vim.keymap.set("n", "<leader>2", function() _G.bookmark_jump(2) end, { desc = "Jump to bookmark 2" })
vim.keymap.set("n", "<leader>3", function() _G.bookmark_jump(3) end, { desc = "Jump to bookmark 3" })
vim.keymap.set("n", "<leader>bc", _G.bookmark_clear, { desc = "Clear bookmarks" })

local bookmarks = {}

-- add or replace using a specific filename
local function set_bookmark(slot, filename)
    if filename == "" then
        print("No file name")
        return
    end
    bookmarks[slot] = filename
    print("Bookmark [" .. slot .. "] = " .. vim.fn.fnamemodify(filename, ":~:."))
end

-- Add current buffer as bookmark (append until 4)
function _G.bookmark_add(slot)
    local name = vim.api.nvim_buf_get_name(0)
    if name == "" then
        print("No file name")
        return
    end

    -- if slot is given, this is a replace
    if slot then
        set_bookmark(slot, name)
        return
    end

    -- avoid duplicates
    for _, b in ipairs(bookmarks) do
        if b == name then
            print("Already bookmarked")
            return
        end
    end

    if #bookmarks >= 4 then
        print("Max 4 bookmarks reached — replace one (open list and press r)")
        return
    end

    table.insert(bookmarks, name)
    print("Bookmarked [" .. #bookmarks .. "]: " .. vim.fn.fnamemodify(name, ":~:."))
end

function _G.bookmark_jump(i)
    local name = bookmarks[i]
    if not name then
        print("No bookmark at [" .. i .. "]")
        return
    end
    vim.cmd("edit " .. vim.fn.fnameescape(name))
end

function _G.bookmark_remove(i)
    if not bookmarks[i] then
        print("No bookmark at [" .. i .. "]")
        return
    end
    table.remove(bookmarks, i)
    print("Removed bookmark [" .. i .. "]")
end

function _G.bookmark_clear()
    bookmarks = {}
    print("All bookmarks cleared")
end

-- popup
function _G.bookmark_list()
    -- capture the buffer the user was in BEFORE opening popup
    local source_buf = vim.api.nvim_get_current_buf()

    -- build lines (always 4 slots for consistency)
    local lines = {}
    local has_any = false
    for i = 1, 4 do
        local mark = bookmarks[i]
        if mark then
            has_any = true
            table.insert(lines, string.format("[%d] %s", i, vim.fn.fnamemodify(mark, ":~:.")))
        else
            table.insert(lines, string.format("[%d] — empty", i))
        end
    end
    if not has_any then
        print("No bookmarks")
        return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].modifiable = false

    local height = #lines
    local width = 0
    for _, l in ipairs(lines) do
        if #l > width then width = #l end
    end

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        anchor = "SW",
        style = "minimal",
        border = "rounded",
        title = " Buffmarks ",
        title_pos = "center",
        row = vim.o.lines - vim.o.cmdheight - height - 1,
        col = 1,
        width = width + 4,
        height = height + 1,
    })

    vim.wo[win].cursorline = true

    -- q to close
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })

    -- <CR> to jump
    vim.keymap.set("n", "<CR>", function()
        local idx = tonumber(vim.api.nvim_get_current_line():match("%[(%d+)%]"))
        if idx and bookmarks[idx] then
            vim.cmd("close")
            _G.bookmark_jump(idx)
        end
    end, { buffer = buf, silent = true })

    -- d to delete current slot
    vim.keymap.set("n", "d", function()
        local idx = tonumber(vim.api.nvim_get_current_line():match("%[(%d+)%]"))
        if idx then
            _G.bookmark_remove(idx)
            vim.cmd("close")
            _G.bookmark_list() -- refresh
        end
    end, { buffer = buf, silent = true })

    -- r to REPLACE selected slot with the buffer we had BEFORE the popup
    -- r to REPLACE selected slot with the buffer we had BEFORE the popup
    vim.keymap.set("n", "r", function()
        local idx = tonumber(vim.api.nvim_get_current_line():match("%[(%d+)%]"))
        if not idx then return end

        -- get filename from the buffer we were in before opening the popup
        local src_name = vim.api.nvim_buf_get_name(source_buf)
        if src_name == "" then
            print("Original buffer had no file name")
            return
        end

        -- if this file is already bookmarked, move it instead of duplicating
        local existing
        for i, b in ipairs(bookmarks) do
            if b == src_name then
                existing = i
                break
            end
        end

        if existing then
            -- move existing bookmark to new slot
            if existing == idx then
                print("Already at slot [" .. idx .. "]")
                return
            end
            bookmarks[existing], bookmarks[idx] = bookmarks[idx], bookmarks[existing]
            print("Moved bookmark to slot [" .. idx .. "]")
        else
            -- normal replace
            bookmarks[idx] = src_name
            print("Replaced slot [" .. idx .. "]")
        end

        vim.cmd("close")
        _G.bookmark_list() -- refresh view
    end, { buffer = buf, silent = true })
end

-- keymaps
vim.keymap.set("n", "<leader>a", _G.bookmark_add, { desc = "Bookmark current buffer" })
vim.keymap.set("n", "<leader>bl", _G.bookmark_list, { desc = "List bookmarks" })
vim.keymap.set("n", "<leader>1", function() _G.bookmark_jump(1) end)
vim.keymap.set("n", "<leader>2", function() _G.bookmark_jump(2) end)
vim.keymap.set("n", "<leader>3", function() _G.bookmark_jump(3) end)
vim.keymap.set("n", "<leader>4", function() _G.bookmark_jump(4) end)
vim.keymap.set("n", "<leader>bc", _G.bookmark_clear, { desc = "Clear all" })

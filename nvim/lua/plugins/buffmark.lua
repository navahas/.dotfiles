local buffmark = require('buffmark')

-- Setup with toggle key (automatically creates the keymap)
buffmark.setup({
    toggle_key = "<C-e>"
})

-- Set your other keymaps
vim.keymap.set("n", "<leader>a", buffmark.add, { desc = "Bookmark add" })
vim.keymap.set("n", "<leader>bc", buffmark.clear, { desc = "Bookmark clear" })
vim.keymap.set("n", "<leader>1", function() buffmark.jump(1) end, { desc = "Bookmark 1" })
vim.keymap.set("n", "<leader>2", function() buffmark.jump(2) end, { desc = "Bookmark 2" })
vim.keymap.set("n", "<leader>3", function() buffmark.jump(3) end, { desc = "Bookmark 3" })
vim.keymap.set("n", "<leader>4", function() buffmark.jump(4) end, { desc = "Bookmark 4" })

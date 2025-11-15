local cmp = require("cmp")

cmp.setup({
    window = {
        completion = {
            -- border = "rounded",
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel"
        },
        documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpDoc",
        }
    },
    completion = {
        autocomplete = false,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item
        ["<C-Space>"] = cmp.mapping.complete(),
    },
    sources = {
        { name = "nvim_lsp" }, -- LSP completions
        { name = "buffer" },   -- Buffer completions
    },
    formatting = {
        format = function(entry, vim_item)
            -- Limit width
            local max_width = 50
            if #vim_item.abbr > max_width then
                vim_item.abbr = vim_item.abbr:sub(1, max_width) .. "..."
            end

            -- Add source label
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                buffer = "[BUF]",
            })[entry.source.name]
            return vim_item
        end,
    },
})

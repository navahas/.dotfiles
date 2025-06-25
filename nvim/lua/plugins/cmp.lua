return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        -- Uncomment if you want path completions
        -- "hrsh7th/cmp-path",
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
                    -- winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel"
                    -- ",FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
                },
                documentation = {
                    border = "rounded",
                    -- winhighlight = "Normal:CmpDoc",
                    winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
                }
            },
            completion = {
                autocomplete = false,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item
                ["<C-Space>"] = cmp.mapping.complete(),
            },
            sources = {
                { name = "nvim_lsp" }, -- LSP completions
                { name = "buffer" },   -- Buffer completions
            },
        })
    end,
}

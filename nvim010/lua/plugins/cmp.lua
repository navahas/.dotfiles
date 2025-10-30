return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "onsails/lspkind.nvim",
        -- Uncomment if you want path completions
        -- "hrsh7th/cmp-path",
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        cmp.setup({
            window = {
                completion = {
                    -- border = "rounded",
                    winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel" -- ",FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
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
                ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item
                ["<C-Space>"] = cmp.mapping.complete(),
            },
            sources = {
                { name = "nvim_lsp" }, -- LSP completions
                { name = "buffer" },   -- Buffer completions
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text", -- 'text', 'symbol', or 'symbol_text'
                    maxwidth = 50,
                    ellipsis_char = "...",
                    -- Optionally label each source
                    menu = {
                        buffer = "[BUF]",
                        nvim_lsp = "[LSP]",
                    },
                    symbol_map = {
                        Buffer = "﬘",
                    },
                }),
            },
        })
    end,
}

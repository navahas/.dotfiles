local cmp = require('cmp')

cmp.setup({
    completion = {
        automcomplete = true,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept selected item
        ['<C-Space>'] = cmp.mapping.complete(),
    },
    sources = {
        { name = 'nvim_lsp' }, -- LSP completions
        { name = 'buffer' }, -- Buffer completions
        -- { name = 'path' }, -- Path completions
    },
    performance = {
    },
})


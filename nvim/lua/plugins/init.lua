-- Plugin management using vim.pack (Neovim 0.12+ nightly)
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/wtfox/jellybeans.nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/navahas/buffmark" },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }
})

-- Load plugins (required because vim.pack installs to opt/)
vim.cmd.packadd('plenary.nvim')
vim.cmd.packadd('nvim-web-devicons')
vim.cmd.packadd('telescope.nvim')
vim.cmd.packadd('telescope-fzf-native.nvim')
vim.cmd.packadd('nvim-treesitter')
vim.cmd.packadd('jellybeans.nvim')
vim.cmd.packadd('mason.nvim')
vim.cmd.packadd('mason-lspconfig.nvim')
vim.cmd.packadd('nvim-lspconfig')
vim.cmd.packadd('buffmark')
vim.cmd.packadd('render-markdown.nvim')

-- Load configurations
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.theme')
require('plugins.lsp')
require('plugins.buffmark')

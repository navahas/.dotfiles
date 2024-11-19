return require('packer').startup(function(use)
    use 'tomasiser/vim-code-dark'
    use 'wbthomason/packer.nvim' -- Plugin manager
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'ThePrimeagen/harpoon'
    use 'williamboman/mason.nvim'
    use 'neovim/nvim-lspconfig' -- LSP configurations
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/nvim-cmp' -- Completion engine
    use 'hrsh7th/cmp-nvim-lsp' -- LSP completions
    use 'hrsh7th/cmp-buffer' -- Buffer completions
    use 'hrsh7th/cmp-path' -- Path completions
    use 'hrsh7th/cmp-cmdline' -- Command-line completions

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'

    require('plugins.telescope')
    require('plugins.harpoon')
    require('plugins.lsp')
    require('plugins.treesitter')
    require('plugins.cmp')

end)

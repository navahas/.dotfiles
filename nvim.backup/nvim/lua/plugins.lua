return require('packer').startup(function(use)
    use 'tomasiser/vim-code-dark'
    use 'wbthomason/packer.nvim' -- Plugin manager
    use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'williamboman/mason.nvim'
    use 'neovim/nvim-lspconfig' -- LSP configurations
    use 'williamboman/mason-lspconfig.nvim'
end)

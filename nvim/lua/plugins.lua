return require('packer').startup({
    function(use)
        use 'wbthomason/packer.nvim' -- Plugin manager
        use 'tomasiser/vim-code-dark'
        use 'Mofiqul/vscode.nvim'
        use 'nvim-tree/nvim-web-devicons'
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

        use 'stevearc/dressing.nvim'
        use 'nvim-lua/plenary.nvim'
        use 'MunifTanjim/nui.nvim'

        if vim.g.avante_enabled then
            use {
                'yetone/avante.nvim',
                branch = 'main',
                build = 'make', -- Build step
                config = function()
                    require('avante_lib').load()
                    require('avante').setup()
                end
            }
        end

        vim.g.avante_enabled = false;

        require('plugins.telescope')
        require('plugins.harpoon')
        require('plugins.lsp')
        require('plugins.treesitter')
        require('plugins.cmp')

    end,
    config = {
        -- Custom path for compiled packer file
        compile_path = vim.fn.stdpath('data') .. '/packer_compiled.lua'
    }
})

return require('packer').startup({
    function(use)
        -- Packer manages itself
        use 'wbthomason/packer.nvim'

        -- Themes
        use { 'tomasiser/vim-code-dark' }
        use { 'Mofiqul/vscode.nvim' }

        -- Icons
        use { 'nvim-tree/nvim-web-devicons', event = 'BufRead' }

        -- FZF
        use {
            'junegunn/fzf',
            run = function() vim.fn['fzf#install']() end,
        }
        use { 'junegunn/fzf.vim', after = 'fzf' }

        -- Telescope
        use {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            requires = { 'nvim-lua/plenary.nvim' },
        }

        -- Harpoon
        use {
            'ThePrimeagen/harpoon',
            keys = { '<leader>a', '<leader>h' },
        }

        -- Mason and LSP
        use {
            'williamboman/mason.nvim',
            event = 'BufRead',
        }
        use {
            'neovim/nvim-lspconfig',
            after = 'mason.nvim',
        }
        use { 'williamboman/mason-lspconfig.nvim', after = 'mason.nvim' }

        -- Completion
        use {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
        }
        use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
        use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
        use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
        use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }

        -- Treesitter
        use {
            'nvim-treesitter/nvim-treesitter',
            event = 'BufRead',
            run = ':TSUpdate',
        }
        use { 'nvim-treesitter/playground', after = 'nvim-treesitter' }

        -- Utility libraries
        use { 'nvim-lua/plenary.nvim', module = 'plenary' }
        use { 'MunifTanjim/nui.nvim', module = 'nui' }

        require('plugins.telescope')
        require('plugins.harpoon')
        require('plugins.lsp')
        require('plugins.treesitter')
        require('plugins.cmp')
    end,
    config = {
        -- Custom path for the compiled file
        -- compile_path = vim.fn.stdpath('data') .. '/packer_compiled.lua'
    }
})

-- Install packer.nvim if not already installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
    end
end

ensure_packer()

-- Plugin setup
return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Plugin manager
    use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'
    use 'tomasiser/vim-code-dark'

    use {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "ts_ls" },  -- Ensures tsserver is installed
                automatic_installation = true,
            })
        end
    }

    use 'neovim/nvim-lspconfig' -- LSP configurations
end)


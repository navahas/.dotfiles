-- Plugin management using vim.pack (NVIM v0.12.2)
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
    { src = "https://github.com/wtfox/jellybeans.nvim" },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/navahas/buffmark" },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
})

-- Build fzf-native if missing (new machine / fresh install). Idempotent.
local fzf_dir = vim.fs.joinpath(vim.fn.stdpath("data"),
"site/pack/core/opt/telescope-fzf-native.nvim")

if vim.fn.filereadable(fzf_dir .. "/build/libfzf.so") == 0 then
    -- Block once so the .so is ready before telescope loads the fzf extension.
    -- Only runs on fresh install / missing build.
    vim.notify("Building telescope-fzf-native...", vim.log.levels.INFO)
    local out = vim.system({ "make" }, { cwd = fzf_dir }):wait()
    vim.notify("fzf-native build " .. (out.code == 0 and "OK"
        or "FAIL:\n" .. (out.stderr or "")),
        out.code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR)
end

-- Load plugins (required because vim.pack installs to opt/)
vim.cmd.packadd('plenary.nvim')
vim.cmd.packadd('nvim-web-devicons')
vim.cmd.packadd('telescope.nvim')
vim.cmd.packadd('telescope-fzf-native.nvim')
vim.cmd.packadd('jellybeans.nvim')
vim.cmd.packadd('mason.nvim')
vim.cmd.packadd('buffmark')
vim.cmd.packadd('render-markdown.nvim')
-- Load configurations
require('plugins.telescope')
require('plugins.theme')
require('plugins.buffmark')

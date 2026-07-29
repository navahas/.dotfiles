vim.filetype.add({ extension = { h = "c" } })

-- Map filetypes whose name differs from their parser name.
-- Native vim.treesitter.start guesses lang = filetype otherwise.
vim.treesitter.language.register("tsx", { "typescriptreact" })
vim.treesitter.language.register("javascript", { "javascriptreact" })

-- NASM (.asm/.nasm) gets a tree-sitter grammar. GAS (.s/.S) keeps its
-- default "asm" filetype with no parser installed -> Neovim's builtin
-- syntax highlighting (the tree-sitter-asm grammar colored GAS poorly).
vim.filetype.add({
    extension = {
        asm = "nasm",
        nasm = "nasm",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > 100 * 1024 then
            return
        end
        pcall(vim.treesitter.start, args.buf)
    end,
})

vim.filetype.add({ extension = { h = "c" } })

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stats and stats.size > 100 * 1024 then
            return
        end
        pcall(vim.treesitter.start, args.buf)
    end,
})

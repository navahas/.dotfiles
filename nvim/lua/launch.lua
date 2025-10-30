-- Record the start time
vim.g.start_time = vim.fn.reltime()

-- Function to calculate and print the startup time
local function print_startup_time()
    local elapsed_time = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
    print(string.format("Neovim started in %.2f ms", elapsed_time * 1000)) -- Convert to milliseconds
end

-- Print the startup time after everything is loaded
vim.api.nvim_create_autocmd("VimEnter", {
    callback = print_startup_time,
    group = vim.api.nvim_create_augroup("StartupTimeLogger", { clear = true }),
})

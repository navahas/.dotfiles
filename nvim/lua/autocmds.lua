-- ╭──────────────────────────────────────────────╮
-- │ AUTOCMDS & UTILITIES                         │
-- ╰──────────────────────────────────────────────╯

-- ============================================
-- STARTUP TIME MEASUREMENT
-- ============================================

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

-- ============================================
-- MACROS
-- ============================================

-- @c comment
vim.fn.setreg("c", "jI*/kO/*j")

-- @l - (LOG): FILETYPE SETUP
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.api.nvim_create_augroup('@CPrint', { clear = true })
vim.api.nvim_create_augroup('@RustPrint', { clear = true })
vim.api.nvim_create_augroup('@TypeScriptPrint', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    group = '@CPrint',
    pattern = { 'c' },
    callback = function()
        local macro = 'yiWo' .. 'printf("%s\\n' .. esc .. "la, " .. esc .. 'pA;' .. esc
        -- local macro = 'yiWo' .. "printf('%s\\n', " .. esc .. 'pa);' .. esc
        vim.fn.setreg("l", macro)
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = '@RustPrint',
    pattern = { 'rust' },
    callback = function()
        local macro = 'yiWo' .. 'println!("{}", ' .. esc .. 'pa);' .. esc
        vim.fn.setreg("l", macro)
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = '@TypeScriptPrint',
    pattern = { 'javascript', 'typescript' },
    callback = function()
        local macro = 'yiWo' .. 'console.log("", ' .. esc .. 'pa);' .. esc
        vim.fn.setreg("l", macro)
    end
})

-- ============================================
-- GIT FILE HISTORY
-- ============================================

-- Open last N commits of the current file in quickfix list
-- Usage: :FileHistory 5
vim.api.nvim_create_user_command('FileHistory', function(opts)
    local n = tonumber(opts.args) or 5
    local file = vim.fn.expand('%')
    local commits = vim.fn.systemlist("git log -n " .. n .. " --pretty=format:%H -- " .. file)
    local qf_entries = {}

    for _, sha in ipairs(commits) do
        local temp_path = "/tmp/" .. sha .. "_" .. vim.fn.fnamemodify(file, ":t")
        vim.fn.system("git show " .. sha .. ":" .. file .. " > " .. temp_path)
        table.insert(qf_entries, {
            filename = temp_path,
            lnum = 1,
            col = 1,
            text = "Commit: " .. sha
        })
    end

    vim.fn.setqflist(qf_entries, 'r')
    vim.cmd("copen")
end, { nargs = '?' })

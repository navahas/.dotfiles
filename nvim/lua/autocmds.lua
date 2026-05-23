local start_time = vim.fn.reltime()

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("StartupTimeLogger", { clear = true }),
    callback = function()
        local elapsed = vim.fn.reltimefloat(vim.fn.reltime(start_time))
        print(string.format("Neovim started in %.2f ms", elapsed * 1000))
    end,
})

-- ============================================
-- MACROS
-- ============================================

-- @c comment
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
vim.fn.setreg("c", "jI*/kO/*j")

-- @l - (LOG): filetype-specific print statement
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('@CPrint', { clear = true }),
    pattern = { 'c' },
    callback = function()
        vim.fn.setreg("l", 'yiWo' .. 'printf("%s\\n' .. esc .. "la, " .. esc .. 'pA;' .. esc)
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('@RustPrint', { clear = true }),
    pattern = { 'rust' },
    callback = function()
        vim.fn.setreg("l", 'yiWo' .. 'println!("{}", ' .. esc .. 'pa);' .. esc)
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('@TypeScriptPrint', { clear = true }),
    pattern = { 'javascript', 'typescript' },
    callback = function()
        vim.fn.setreg("l", 'yiWo' .. 'console.log("", ' .. esc .. 'pa);' .. esc)
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
    local escaped = vim.fn.shellescape(file)
    local commits = vim.fn.systemlist("git log -n " .. n .. " --pretty=format:%H -- " .. escaped)
    local qf_entries = {}

    for _, sha in ipairs(commits) do
        local temp_path = "/tmp/" .. sha .. "_" .. vim.fn.fnamemodify(file, ":t")
        vim.fn.system("git show " .. sha .. ":" .. escaped .. " > " .. vim.fn.shellescape(temp_path))
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

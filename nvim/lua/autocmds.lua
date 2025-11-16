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
-- ATTACH LSP TO DIFFERENT SERVER
-- ============================================

vim.api.nvim_create_user_command("LspConnect", function(opts)
    local args = vim.split(opts.args, " ")

    if #args < 2 then
        print("Usage: :LspConnect <server_name> <cmd> [args...]")
        print("Example: :LspConnect clangd ssh -F ~/.lima/node1/ssh.config lima-node1 clangd")
        return
    end

    local server_name = table.remove(args, 1)
    local cmd = args

    -- Expand ~ to home directory in all arguments
    local home = os.getenv("HOME")
    if home then
        for i, arg in ipairs(cmd) do
            cmd[i] = arg:gsub("^~", home)
        end
    end

    -- Update the LSP config for the specified server
    if vim.lsp.config[server_name] then
        vim.lsp.config[server_name].cmd = cmd
        print("LSP: overriding " .. server_name .. " cmd →", table.concat(cmd, " "))
    else
        print("Error: LSP server '" .. server_name .. "' not found in vim.lsp.config")
        return
    end

    -- Stop all clients for this server
    for _, client in ipairs(vim.lsp.get_clients({ name = server_name })) do
        vim.lsp.stop_client(client.id)
    end

    -- Restart LSP on current buffer
    vim.cmd("edit")
end, {
    nargs = "+",
    complete = "shellcmd",
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
-- Call with number of versions you want
-- :lua OpenFileHistoryInQuickfix(5)
function OpenFileHistoryInQuickfix(n)
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
end

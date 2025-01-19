vim.api.nvim_create_user_command('ThemeSwitch', function(opts)
    local theme = opts.args
    if theme == 'vscode' then
        vim.cmd.colorscheme('vscode')
    elseif theme == 'kanagawa' then
        vim.cmd.colorscheme('kanagawa')
    else
        print("Available themes: vscode, kanagawa")
    end
end, {
    nargs = 1,
    complete = function()
        return { 'vscode', 'kanagawa' }
    end
})

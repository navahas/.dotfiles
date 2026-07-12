return {
    cmd = { 'tsgo', '--lsp', '--stdio' },
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = false,
            },
        },
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx'
    },
    root_markers = {
        'package.json',
        'tsconfig.json',
        'jsconfig.json',
        '.git'
    }
}

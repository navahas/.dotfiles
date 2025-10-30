return {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
    settings = {
        ['rust-analyzer'] = {
            rustfmt = {
                enable = true
            },
            cargo = {
                allFeatures = true
            }
        }
    }
}

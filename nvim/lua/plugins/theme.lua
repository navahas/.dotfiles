return {
    {
        "Mofiqul/vscode.nvim",
        lazy = false, -- Load immediately since it's a theme
        priority = 1000, -- Ensure it loads first
        config = function()
            -- Get colors before setup
            local c = require('vscode.colors').get_colors()
            require("vscode").setup({
                -- Alternatively set style in setup
                -- style = 'light'

                -- Enable transparent background
                transparent = true,

                -- Enable italic comment
                italic_comments = true,

                -- Underline `@markup.link.*` variants
                underline_links = true,

                -- Disable nvim-tree background color
                disable_nvimtree_bg = true,

                -- Override colors (see ./lua/vscode/colors.lua)
                color_overrides = {
                    vscLineNumber = '#5a5a5a',
                },

                -- Override highlight groups (see ./lua/vscode/theme.lua)
                group_overrides = {
                    -- Change the color of the empty line symbols (`~`)
                    EndOfBuffer = { fg = '#5a5a5a' },
                    -- this supports the same val table as vim.api.nvim_set_hl
                    -- use colors from this colorscheme by requiring vscode.colors!
                    Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
                    CursorLine = { bg = '#2E2E2E' },
                    -- Override LSP Diagnostic Colors
                    DiagnosticError = { fg = '#D16969', bg = '' }, -- light red
                    DiagnosticWarn  = { fg = '#D7BA7D', bg = '' }, -- light yellow
                    DiagnosticInfo  = { fg = '#9CDCFE', bg = '' }, -- light blue
                    DiagnosticHint  = { fg = '#9CDCFE', bg = '' }, -- light green
                    -- Floating window customization
                    NormalFloat = { bg = '#1F1F1F' },
                    FloatBorder = { fg = '', bg = '#1F1F1F' },
                    -- Vim mode theme
                    ModeMsg = { fg = '#FFFFFF', bg = '#1F1F1F', bold = true },
                    -- Customize fold color
                    Folded = { fg = '#B2B2B2', bg = '#333333', italic = true },
                }
            })
            require('vscode').load()
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('kanagawa').setup({
                    compile = false,             -- enable compiling the colorscheme
                    undercurl = true,            -- enable undercurls
                    commentStyle = { italic = true },
                    functionStyle = {},
                    keywordStyle = { italic = true},
                    statementStyle = { bold = true },
                    typeStyle = {},
                    transparent = true,         -- do not set background color
                    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
                    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
                    colors = {                   -- add/modify theme and palette colors
                        palette = {},
                        theme = {
                            wave = {},
                            lotus = {},
                            dragon = {},
                            all = {
                                ui = {
                                    bg_gutter = "none",
                                    bg_visual = "none"  -- This will make visual selection transparent
                                }
                            }
                        },
                    },
                    overrides = function(colors) -- add/modify highlights
                        return {
                            -- Make empty line characters invisible
                            EndOfBuffer = { fg = "" },
                            -- Match VSCode LSP diagnostic colors
                            -- DiagnosticError = { fg = '#D16969', bg = 'none' }, -- light red
                            -- DiagnosticWarn  = { fg = '#D7BA7D', bg = 'none' }, -- light yellow
                            -- DiagnosticInfo  = { fg = '#9CDCFE', bg = 'none' }, -- light blue
                            -- DiagnosticHint  = { fg = '#9CDCFE', bg = 'none' }, -- light green
                            -- Telescope customization
                            TelescopeBorder = { fg = colors.dragonGray, bg = "none" },
                            TelescopeNormal = { bg = "none" },
                            TelescopePromptNormal = { bg = "none" },
                            TelescopeResultsNormal = { bg = "none" },
                            TelescopeSelection = { bg = colors.dragonBlack4 },
                            TelescopePreviewNormal = { bg = "none" },
                            TelescopePromptBorder = { fg = colors.dragonGray, bg = "none" },
                            TelescopeResultsBorder = { fg = colors.dragonGray, bg = "none" },
                            TelescopePreviewBorder = { fg = colors.dragonGray, bg = "none" },
                            TelescopePromptTitle = { fg = colors.dragonGray, bg = "none" },
                            TelescopeResultsTitle = { fg = colors.dragonGray, bg = "none" },
                            TelescopePreviewTitle = { fg = colors.dragonGray, bg = "none" },

                            CursorLine = { bg = "none" },
                        }
                    end,
                    theme = "dragon",              -- Load "wave" theme when 'background' option is not set
                    background = {               -- map the value of 'background' option to a theme
                        dark = "dragon",           -- try "dragon" !
                        light = "lotus"
                    },
            })
            -- vim.cmd("colorscheme kanagawa")
        end
    },
}

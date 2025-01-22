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
            -- require('vscode').load()
        end,
    },
    {
            "wtfox/jellybeans.nvim",
            lazy = false, -- Load immediately since it's a theme
            priority = 1000,
            config = function()
                require("jellybeans").setup({
                    transparent = true,
                    italics = false,
                    plugins = {
                        all = true, -- Enable all plugin integrations
                        auto = true,
                    },
                    -- Customize colors
                    on_colors = function(colors)
                        -- You can adjust these colors to match your VSCode theme
                        colors.error = "#D98870"
                        colors.warning = "#8FBFDC"
                        -- colors.info = "#9CDCFE" 
                        colors.hint = colors.perano
                    end,
                    -- Customize highlight groups
                    on_highlights = function(highlights, colors)
                        -- Remove backgrounds from various UI elements
                        -- Remove all Telescope backgrounds
                        highlights.TelescopeNormal = { bg = "NONE" }
                        highlights.TelescopePromptNormal = { bg = "NONE" }
                        highlights.TelescopePromptBorder = { fg = colors.grey, bg = "NONE" }
                        highlights.TelescopePromptTitle = { fg = colors.grey, bg = "NONE" }
                        highlights.TelescopePromptPrefix = { fg = colors.koromiko, bg = "NONE" }
                        highlights.TelescopePromptCounter = { fg = colors.yellow, bg = "NONE" }
                        -- highlights.TelescopeResultsNormal = { bg = "NONE" }
                        highlights.TelescopeResultsBorder = { fg = colors.grey, bg = "NONE" }
                        highlights.TelescopeResultsTitle = { fg = "#B0D0F0", bg = "NONE" }
                        -- highlights.TelescopeResultsStats = { fg = colors.yellow, bg = "NONE" }
                        -- highlights.TelescopePreviewNormal = { bg = "NONE" }
                        highlights.TelescopePreviewBorder = { fg = colors.grey, bg = "NONE" }
                        highlights.TelescopePreviewTitle = { fg = "#CC88A3", bg = "NONE" }
                        highlights.TelescopeSelection = { fg = colors.koromiko, bg = "NONE", bold = true }
                        -- highlights.TelescopeSelectionCaret = { fg = colors.koromiko, bg = "NONE" }
                        highlights.TelescopeMatching = { fg = colors.koromiko, bold = true }

                        -- LSP diagnostic highlights without backgrounds
                        highlights.DiagnosticError = { fg = colors.error, bg = "NONE" }
                        highlights.DiagnosticWarn = { fg = colors.warning, bg = "NONE" }
                        highlights.DiagnosticInfo = { fg = colors.info, bg = "NONE" }
                        highlights.DiagnosticHint = { fg = colors.hint, bg = "NONE" }

                        -- LSP-specific diagnostics (some themes/setups need these specifically)
                        highlights.LspDiagnosticsUnderlineError = { undercurl = true, sp = colors.error }
                        highlights.LspDiagnosticsUnderlineWarning = { undercurl = true, sp = colors.warning }
                        highlights.LspDiagnosticsUnderlineInformation = { undercurl = true, sp = colors.info }
                        highlights.LspDiagnosticsUnderlineHint = { undercurl = true, sp = colors.hint }

                        -- Virtual text diagnostics
                        highlights.DiagnosticVirtualTextError = { fg = colors.error, bg = "NONE" }
                        highlights.DiagnosticVirtualTextWarn = { fg = colors.warning, bg = "NONE" }
                        highlights.DiagnosticVirtualTextInfo = { fg = colors.info, bg = "NONE" }
                        highlights.DiagnosticVirtualTextHint = { fg = colors.hint, bg = "NONE" }

                        -- Floating diagnostics
                        highlights.DiagnosticFloatingError = { fg = colors.error, bg = "NONE" }
                        highlights.DiagnosticFloatingWarn = { fg = colors.warning, bg = "NONE" }
                        highlights.DiagnosticFloatingInfo = { fg = colors.info, bg = "NONE" }
                        highlights.DiagnosticFloatingHint = { fg = colors.hint, bg = "NONE" }

                        -- Inside your on_highlights function, add or modify these lines:
                        highlights.FloatBorder = { fg = colors.grey, bg = "NONE" }
                        highlights.NormalFloat = { bg = "NONE" }
                        highlights.LspInfoBorder = { fg = colors.grey, bg = "NONE" }
                        highlights.PmenuDocBorder = { fg = colors.grey, bg = "NONE" }

                        highlights.CmpBorder = { fg = '#5a5a5a', bg = '#1E1E1E' }
                        highlights.CmpPmenuBorder = { link = 'CmpBorder' }
                        highlights.CmpDocBorder = { link = 'CmpBorder' }

                        -- For hover documentation
                        highlights.LspSignatureActiveParameter = { fg = colors.magenta, bg = "NONE", bold = true }
                        highlights.LspInlayHint = { fg = colors.grey, bg = "NONE" }

                        -- For floating windows and documentation
                        highlights.FloatTitle = { fg = colors.white, bg = "NONE" }

                        -- Customize netrw directory color (orange)
                        highlights.netrwDir = { fg = colors.koromiko, bold = true }

                        -- Search
                        -- highlights.Search = { fg = colors.total_black, bg = colors.wewak, bold = true }
                        -- highlights.CurSearch = { bg = colors.wewak, fg = colors.total_white }
                        -- highlights.IncSearch = { bg = colors.wewak, fg = colors.total_white }

                        -- Line number and cursor line
                        highlights.LineNrAbove = { fg = "#5a5a5a" }
                        highlights.LineNr = { fg = colors.white }
                        highlights.LineNrBelow = { fg = "#5a5a5a" }
                        highlights.CursorLine = { bg = "NONE" }

                        -- Folding
                        highlights.Folded = { fg = colors.grey, italic = true, bg = "NONE" }

                        -- Mode message
                        highlights.ModeMsg = { fg = colors.yellow, bold = true, bg = "NONE" }

                        -- Error message
                        highlights.ErrorMsg = { fg = colors.error, bg = "NONE", bold = true }

                        -- RenderMarkdown For Avante
                        highlights.RenderMarkdownCode = { bg = "NONE" }
                        highlights.ColorColumn = { bg = "NONE" }
                    end,
                })
                vim.cmd.colorscheme("jellybeans")
            end,
        }
}

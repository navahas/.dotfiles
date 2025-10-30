require("jellybeans").setup({
    transparent = true,
    italics = false,
    plugins = {
        all = true,
        auto = true,
    },
    -- Customize colors
    on_colors = function(colors)
        colors.error = "#D98870"
        colors.warning = colors.perano
        colors.hint = colors.perano
    end,
    -- Customize highlight groups
    on_highlights = function(highlights, colors)
        -- Telescope backgrounds
        highlights.TelescopeNormal = { bg = "NONE" }
        highlights.TelescopePromptNormal = { bg = "NONE" }
        highlights.TelescopePromptBorder = { fg = colors.grey, bg = "NONE" }
        highlights.TelescopePromptTitle = { fg = colors.grey, bg = "NONE" }
        highlights.TelescopePromptPrefix = { fg = colors.koromiko, bg = "NONE" }
        highlights.TelescopePromptCounter = { fg = colors.yellow, bg = "NONE" }
        highlights.TelescopeResultsBorder = { fg = colors.grey, bg = "NONE" }
        highlights.TelescopeResultsTitle = { fg = "#B0D0F0", bg = "NONE" }
        highlights.TelescopePreviewBorder = { fg = colors.grey, bg = "NONE" }
        highlights.TelescopePreviewTitle = { fg = "#CC88A3", bg = "NONE" }
        highlights.TelescopeSelection = { fg = colors.koromiko, bg = "NONE", bold = true }
        highlights.TelescopeSelectionCaret = { fg = colors.koromiko, bg = "NONE" }
        highlights.TelescopeMatching = { fg = colors.koromiko, bold = true }

        -- LSP diagnostics
        highlights.DiagnosticError = { fg = colors.error, bg = "NONE" }
        highlights.DiagnosticWarn = { fg = colors.warning, bg = "NONE" }
        highlights.DiagnosticInfo = { fg = colors.info, bg = "NONE" }
        highlights.DiagnosticHint = { fg = colors.hint, bg = "NONE" }

        highlights.LspDiagnosticsUnderlineError = { undercurl = true, sp = colors.error }
        highlights.LspDiagnosticsUnderlineWarning = { undercurl = true, sp = colors.warning }
        highlights.LspDiagnosticsUnderlineInformation = { undercurl = true, sp = colors.info }
        highlights.LspDiagnosticsUnderlineHint = { undercurl = true, sp = colors.hint }

        highlights.DiagnosticVirtualTextError = { fg = colors.error }
        highlights.DiagnosticVirtualTextWarn = { fg = colors.warning }
        highlights.DiagnosticVirtualTextInfo = { fg = colors.info }
        highlights.DiagnosticVirtualTextHint = { fg = colors.hint }

        highlights.DiagnosticFloatingError = { fg = colors.error, bg = "NONE" }
        highlights.DiagnosticFloatingWarn = { fg = colors.warning, bg = "NONE" }
        highlights.DiagnosticFloatingInfo = { fg = colors.info, bg = "NONE" }
        highlights.DiagnosticFloatingHint = { fg = colors.hint, bg = "NONE" }

        -- Floating windows
        highlights.FloatBorder = { fg = colors.grey, bg = "NONE" }
        highlights.NormalFloat = { bg = "NONE" }
        highlights.LspInfoBorder = { fg = colors.grey, bg = "NONE" }
        highlights.PmenuDocBorder = { fg = colors.grey, bg = "NONE" }

        highlights.LspSignatureActiveParameter = { fg = colors.magenta, bg = "NONE", bold = true }
        highlights.LspInlayHint = { fg = colors.grey, bg = "NONE" }
        highlights.FloatTitle = { fg = colors.white, bg = "NONE" }

        -- netrw directory color
        highlights.netrwDir = { fg = colors.koromiko, bold = true }

        -- Tabs
        highlights.TabLine = { fg = colors.grey, bg = "NONE" }
        highlights.TabLineSel = { fg = colors.wewak, bg = "NONE", bold = true }
        highlights.TabLineFill = { fg = colors.grey, bg = "NONE" }
        highlights.TabLineSep = { fg = colors.grey, bg = "NONE" }

        -- Line numbers
        highlights.LineNrAbove = { fg = "#5a5a5a", bg = "NONE" }
        highlights.LineNr = { fg = colors.white, bg = "NONE" }
        highlights.LineNrBelow = { fg = "#5a5a5a", bg = "NONE" }
        highlights.CursorLine = { bg = "NONE" }

        -- Folding
        highlights.Folded = { fg = colors.grey, italic = true, bg = "NONE" }

        -- Messages
        highlights.ModeMsg = { fg = colors.yellow, bold = true, bg = "NONE" }
        highlights.ErrorMsg = { fg = colors.error, bg = "NONE", bold = true }

        -- Completion menu (popup menu)
        -- highlights.Pmenu = { fg = colors.white, bg = "NONE" }
        -- highlights.PmenuSel = { fg = colors.koromiko, bg = "NONE", bold = true }
        -- highlights.PmenuSbar = { bg = "NONE" }
        -- highlights.PmenuThumb = { bg = colors.grey }
        -- highlights.PmenuBorder = { fg = colors.grey, bg = "NONE" }
    end,
})

-- Apply the colorscheme
vim.cmd.colorscheme("jellybeans")

-- ============================================================================
-- Sanzo highlight builder (PURE) — (palette, cfg) -> { [group] = opts }
-- ----------------------------------------------------------------------------
-- No side effects; init.lua applies the returned table. Philosophy: muted TINTS,
-- blend > distinction, HUE ONLY (no bold/italic as structure). 5 accents +
-- comment grey; everything else = fg. functions = warm hero; the cool family =
-- user types (hero) · builtin/library (darker) · def/preproc (light); strings +
-- escape = one green, numbers/const + Error = rose, keywords = plum-grey;
-- operators/punct recede down a neutral grey ladder. No bg on code (only
-- Visual). Line numbers + statusline share ONE grey (p.grey_ui); CursorLineNr = fg.
-- ============================================================================

return function(p, cfg)
    local BG = cfg.transparent and "NONE" or p.bg
    local h = {}
    local function set(list, o) for _, g in ipairs(list) do h[g] = o end end

    -- ---- editor chrome -----------------------------------------------------
    h.Normal      = { fg = p.fg, bg = BG }
    h.NormalNC    = { fg = p.fg, bg = BG }
    h.NormalFloat = { fg = p.fg, bg = BG }
    h.FloatBorder = { fg = p.role_punct, bg = BG } -- borders = punctuation (structural strokes)
    h.FloatTitle  = { fg = p.fg, bg = BG }
    set({ "SignColumn", "FoldColumn", "MsgArea" }, { bg = BG })
    h.EndOfBuffer     = { fg = p.grey_ui, bg = BG } -- ~ tildes match line numbers
    h.ColorColumn     = { bg = "NONE" }
    h.CursorLine      = { bg = "NONE" }
    h.CursorColumn    = { bg = "NONE" }
    h.Cursor          = { fg = p.bg, bg = p.fg }
    h.LineNr          = { fg = p.grey_ui, bg = BG }
    h.LineNrAbove     = { fg = p.grey_ui, bg = BG }
    h.LineNrBelow     = { fg = p.grey_ui, bg = BG }
    h.CursorLineNr    = { fg = p.fg, bg = BG }
    h.Visual          = { bg = p.visual }
    h.VisualNOS       = { bg = p.visual }
    h.Search          = { fg = p.bg, bg = p.role_string }
    h.IncSearch       = { fg = p.bg, bg = p.role_fn }
    h.CurSearch       = { fg = p.bg, bg = p.role_fn }
    h.MatchParen      = { fg = p.role_fn, bold = true } -- the `}` match pop (rare weight, kept)
    h.WinSeparator    = { fg = p.role_punct, bg = BG }  -- window borders = punctuation tone
    h.VertSplit       = { fg = p.role_punct, bg = BG }
    h.NonText         = { fg = p.grey_dim }
    h.Whitespace      = { fg = p.grey_dim }
    h.SpecialKey      = { fg = p.grey_dim }
    h.Directory       = { fg = p.role_fn }
    h.Title           = { fg = p.role_fn, bold = true }
    h.Folded          = { fg = p.grey, italic = true, bg = "NONE" }
    h.Conceal         = { fg = p.grey }
    h.WinBar          = { fg = p.fg, bg = BG }
    h.WinBarNC        = { fg = p.grey, bg = BG }
    h.QuickFixLine    = { bg = p.sel }

    -- statusline (ui.lua re-asserts on ColorScheme; keep on grey_ui)
    h.StatusLine      = { fg = p.grey_ui, bg = "NONE" }
    h.StatusLineNC    = { fg = p.grey_dim, bg = "NONE" }

    -- ---- messages ----------------------------------------------------------
    h.ModeMsg         = { fg = p.role_fn, bold = true }
    h.MoreMsg         = { fg = p.role_string }
    h.Question        = { fg = p.role_string }
    h.ErrorMsg        = { fg = p.role_const, bold = true }
    h.WarningMsg      = { fg = p.role_fn }
    h.OkMsg           = { fg = p.role_string }
    h.MsgSeparator    = { fg = p.grey, bg = "NONE" }

    -- ---- popup menu --------------------------------------------------------
    h.Pmenu           = { fg = p.fg, bg = BG }
    h.PmenuSel        = { fg = p.role_fn, bg = p.sel, bold = true }
    h.PmenuSbar       = { bg = "NONE" }
    h.PmenuThumb      = { bg = p.grey }
    h.PmenuKind       = { fg = p.role_def, bg = BG }
    h.PmenuKindSel    = { fg = p.role_def, bg = p.sel, bold = true }
    h.PmenuExtra      = { fg = p.grey, bg = BG }
    h.WildMenu        = { fg = p.role_fn, bg = p.sel }

    -- ---- tabline -----------------------------------------------------------
    h.TabLine         = { fg = p.grey, bg = BG }
    h.TabLineSel      = { fg = p.role_keyword, bg = BG, bold = true }
    h.TabLineFill     = { fg = p.grey, bg = BG }

    -- ---- syntax: grouped BY ROLE (fg only) ---------------------------------
    -- Color the BASE captures; children inherit via the right-to-left fallback
    -- (@keyword.function -> @keyword) and legacy vim links (Conditional ->
    -- Statement, String -> Constant, Function -> Identifier, Include -> PreProc).
    -- Only list a specific subgroup when it should DEVIATE from its base.
    -- role -> captures.  Keyed by the palette's ROLE NAME (the p.* field), NOT
    -- its hex — names are unique, so two roles may resolve to the SAME hex
    -- without merging (retone var == fg and it just works). Two knobs:
    --   palette.lua  = what COLOR  (role name -> hex)
    --   this table   = what STUFF  (role -> which capture groups)
    -- Share a color on purpose? Give two roles the same hex in palette.lua.
    local fg_by_role = {
        role_fn = { -- HERO: functions — call-site landmark
            "Function", "@function", "@method",
        },
        role_fn_lib = { -- stdlib / library functions (malloc/free/pthread)
            "@function.builtin",
        },
        role_type = {          -- USER/custom types — the cool hero (teal-slate)
            "Type",            -- legacy base: StorageClass/Structure/Typedef
            "@type",           -- typedefs, structs
            "@type.qualifier", -- const/volatile
        },
        role_builtin = {             -- BUILTIN (int/void/char) + library types + named consts — darker blue
            "@type.builtin",
            "@type.library",         -- size_t/FILE/pthread_t (LSP defaultLibrary)
            "Constant", "@constant", -- named consts = fixed declared things, like builtins
        },
        role_def = { -- DEFINITIONS: preproc / #define / macros / modules — light blue
            "@module", "@namespace",
            "@keyword.directive", "@keyword.directive.define",
            "Define", "PreProc", "@function.macro",
        },
        role_keyword = {             -- declaration / storage keywords (static/const/typedef)
            "Statement",             -- legacy base: Keyword/Label
            "@keyword",
            "@tag",
        },
        role_kw_control = { -- control flow (if/for/while/switch/break) — violet-plum
            "@keyword.import",
            "Conditional", "Repeat", "Exception", "Label",
            "@keyword.conditional", "@keyword.conditional.ternary",
            "@keyword.repeat",
            "@keyword.exception",
            "@keyword.debug",
            "@keyword.coroutine",
        },
        role_string = { -- strings — the calm literal mass. escapes/regex fold in
            -- (one green: blend > distinction). See string reasoning note below.
            "String", "@string",
            "Character", "@character",
            "@tag.attribute", "@markup.raw",
            "Special", "@string.escape", "@string.regexp",
            "@string.special", "@character.special",
        },
        role_const = { -- warm base: boolean / return / syntax Error (dusty rose)
            "@boolean",
            "@number",
            "Error", -- syntax error rides the const tone
        },
        role_ret = {           -- NUMBERS only — stronger rose pop
            "@keyword.return", -- return in the warm channel (important landmark)
        },
        role_op = {            -- operators — grey, just under the bone field
            "Operator", "@operator", "@punctuation.special",
        },
        role_punct = { -- punctuation / delimiters — a step dimmer
            "@punctuation", "@tag.delimiter", "Delimiter",
        },
        -- ---- BONE content family (value depth, no color) --------------------
        bone_var = { -- variables ONLY — the pop (brightest). May equal fg.
            "@variable",
        },
        fg = { -- base content: identifiers / members / properties (calm floor)
            "Identifier", "@property",
            "@variable.member", "@field", "@constructor",
        },
        bone_param = { -- parameters — inputs, one step down (dimmer)
            "@variable.parameter",
        },
    }
    for role, groups in pairs(fg_by_role) do
        local color = p[role] or error("sanzo: unknown palette role '" .. role .. "'")
        for _, g in ipairs(groups) do h[g] = { fg = color } end
    end

    -- ---- syntax: groups with extra attributes ------------------------------
    local comment_list = {
        "Comment",
        "SpecialComment",
        "@comment",
        "@comment.documentation",
        "@markup.quote",
    }
    set(comment_list, { fg = p.role_comment, italic = true }) -- hue only, no italic

    h.Underlined                  = { fg = p.role_def, underline = true }
    h.Todo                        = { fg = p.bg, bg = p.role_fn, bold = true }
    h["@markup.heading"]          = { fg = p.role_fn, bold = true }
    h["@markup.link"]             = { fg = p.role_def, underline = true }
    h["@markup.link.url"]         = { fg = p.grey, underline = true }
    h["@markup.strong"]           = { bold = true }
    h["@markup.italic"]           = { italic = true }

    -- Structural links (LSP defers + per-language token fixes) live in
    -- lua/sanzo/links.lua. groups.lua stays palette-only.

    h.LspInlayHint                = { fg = p.grey, bg = "NONE" }
    h.LspSignatureActiveParameter = { fg = p.role_keyword, bold = true }
    h.LspReferenceText            = { bg = p.sel }
    h.LspReferenceRead            = { bg = p.sel }
    h.LspReferenceWrite           = { bg = p.sel }

    -- ---- diagnostics -------------------------------------------------------
    local dcol                    = {
        Error = p.role_const,
        Warn  = p.role_fn,
        Info  = p.role_def,
        Hint  = p.grey,
        Ok    = p.role_string,
    }
    for sev, c in pairs(dcol) do
        h["Diagnostic" .. sev] = { fg = c }
        h["DiagnosticVirtualText" .. sev] = { fg = c }
        h["DiagnosticVirtualLines" .. sev] = { fg = c }
        h["DiagnosticUnderline" .. sev] = { undercurl = true, sp = c }
        h["DiagnosticFloating" .. sev] = { fg = c, bg = BG }
        h["DiagnosticSign" .. sev] = { fg = c, bg = BG }
    end

    -- ---- git / diff (add=sage, change=slate, delete=rose) ------------------
    h.DiffAdd        = { fg = p.role_string, bg = "NONE" }
    h.DiffChange     = { fg = p.role_def, bg = "NONE" }
    h.DiffDelete     = { fg = p.role_const, bg = "NONE" }
    h.DiffText       = { fg = p.role_fn, bg = "NONE" }
    h.Added          = { fg = p.role_string }
    h.Changed        = { fg = p.role_def }
    h.Removed        = { fg = p.role_const }
    h.GitSignsAdd    = { fg = p.role_string, bg = BG }
    h.GitSignsChange = { fg = p.role_def, bg = BG }
    h.GitSignsDelete = { fg = p.role_const, bg = BG }

    -- ---- telescope ---------------------------------------------------------
    set({ "TelescopeNormal", "TelescopePromptNormal", "TelescopeResultsNormal",
        "TelescopePreviewNormal" }, { bg = "NONE" })
    set({ "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder",
        "TelescopeBorder" }, { fg = p.punc_grey, bg = "NONE" })
    h.TelescopePromptTitle    = { fg = p.punc_grey, bg = "NONE" }
    h.TelescopeResultsTitle   = { fg = p.role_def, bg = "NONE" }
    h.TelescopePreviewTitle   = { fg = p.role_keyword, bg = "NONE" }
    h.TelescopePromptPrefix   = { fg = p.role_fn, bg = "NONE" }
    h.TelescopePromptCounter  = { fg = p.role_fn, bg = "NONE" }
    h.TelescopeSelection      = { fg = p.role_fn, bg = "NONE", bold = true }
    h.TelescopeSelectionCaret = { fg = p.role_fn, bg = "NONE" }
    h.TelescopeMatching       = { fg = p.role_fn, bold = true }

    -- ---- mason (installer UI — kill the default green/teal blocks) ---------
    set({ "MasonHeader", "MasonHeaderSecondary" }, { fg = p.role_fn, bg = "NONE", bold = true })
    set({ "MasonHighlight", "MasonHighlightSecondary" }, { fg = p.role_def })
    set({ "MasonHighlightBlock", "MasonHighlightBlockBold",
            "MasonHighlightBlockSecondary", "MasonHighlightBlockBoldSecondary" },
        { fg = p.role_def, bg = "NONE" })
    set({ "MasonMuted", "MasonMutedBlock", "MasonMutedBlockBold" }, { fg = p.grey, bg = "NONE" })
    h.MasonError   = { fg = p.role_const }
    h.MasonWarning = { fg = p.role_fn }
    h.MasonHeading = { fg = p.fg }
    h.MasonLink    = { fg = p.role_def, underline = true }

    -- ---- misc plugins ------------------------------------------------------
    h.netrwDir     = { fg = p.role_fn, bold = true }
    h.SpellBad     = { undercurl = true, sp = p.role_const }
    h.SpellCap     = { undercurl = true, sp = p.role_fn }
    h.SpellRare    = { undercurl = true, sp = p.role_keyword }
    h.SpellLocal   = { undercurl = true, sp = p.role_def }

    return h
end

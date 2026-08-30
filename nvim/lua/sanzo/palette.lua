-- ============================================================================
-- Sanzo (nvim) — self-contained palette.  Hand-authored; edit hexes freely.
-- ----------------------------------------------------------------------------
-- PHILOSOPHY (Sanzo Wada): muted, tonal, restrained. Harmony from VALUE
-- gradation inside a family — not from adding hues. Depth = subtle steps.
--
--   • BONE family  — the content body (vars/params/fields). One warm off-white
--                    in three tints. This is most of the screen; giving it depth
--                    is the biggest lift. Shades of the key light #e8e8d3.
--   • GREY ladder  — connective tissue + chrome, all UNDER the bone (content
--                    must outrank punctuation, never the reverse).
--   • 5 ACCENTS    — the ONLY hues. Low chroma, shared warmth. Blend > distinct.
--
-- One value ladder, brightest = most meaning:
--   vars > param > field > operator > punct > comment > chrome > line-nr
--
-- To split a capture WITHOUT a brightness step: add an equal-luminance SIBLING
-- (same L/chroma, hue nudged sideways) and give it its own row in groups.lua.
-- Decoupled from the terminal 16 — this theme owns its colors.
-- ============================================================================

local M       = {}

-- surfaces ------------------------------------------------------------------
local BG      = "#2B2A2A" -- background (warm paper)
local SEL     = "#404040" -- selection grey (refs/quickfix; matches tmux/lazygit)
local VIS     = "#4d4d4d" -- Visual-mode selection (a touch lighter than SEL)

-- BONE — content family (shades of #e8e8d3, warm undertone) ------------------
local bone    = {
    fg    = "#e8e8d3", -- variables / identifiers  (the subject you read)
    param = "#d7d7c6", -- parameters               (inputs, one step down)
    field = "#c7c7b6", -- fields / members / props  (data on objects)
}

-- GREY ladder — connective + chrome, all below the bone family --------------
local grey    = {
    op      = "#bcbcb2", -- operators  * & + - =   (just under field)
    punct   = "#acaca2", -- punctuation () , ; { }
    comment = "#7a7a7a", -- comments   (quiet but legible, neutral)
    ui      = "#6f6f6b", -- borders / splits / folds / telescope
    line    = "#5a5a5a", -- line numbers + statusline (unified)
    dim     = "#3a3a3a", -- non-text / inactive statusline
}

-- 5 ACCENTS — the only hues (muted tints) -----------------------------------
local accent  = {
    fn      = "#dcbd93", -- functions  (HERO, warm)
    type    = "#a8b0b8", -- types + preproc scaffolding (cool)
    string  = "#a8bcac", -- strings + escape (green)
    const   = "#cca598", -- numbers / literals + Error (rose)
    keyword = "#b3a6b0", -- all keywords (plum-grey)
}

-- Equal-luminance SIBLINGS — same L/chroma, hue nudged sideways. Add when you
-- want two captures separated with NO brightness step. Give each its own row.
local sibling = {
    -- type_alt = "#a8b4ac", -- builtin types: type hue nudged toward green
}

function M.get()
    local p               = {}

    -- surfaces
    p.bg, p.sel, p.visual = BG, SEL, VIS

    -- bone (content). p.fg = the key light (Normal text / variables)
    p.fg                  = bone.fg
    p.bone_param          = bone.param
    p.bone_field          = bone.field

    -- grey ladder
    p.role_op             = grey.op
    p.role_punct          = grey.punct
    p.comment_grey        = grey.comment
    p.grey                = grey.ui
    p.grey_ui             = grey.line
    p.grey_dim            = grey.dim
    p.punc_grey           = grey.ui -- telescope borders / titles
    p.role_comment        = grey.comment

    -- accents + any siblings. Chrome (diagnostics/git/telescope/search) reads
    -- these SAME role_* keys directly — no color-name aliases (they lie the
    -- moment you retone; a role name says what the token IS and never lies).
    for role, hex in pairs(accent) do p["role_" .. role] = hex end
    for name, hex in pairs(sibling) do p["role_" .. name] = hex end

    return p
end

return M

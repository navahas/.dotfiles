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
    -- var   = "#eaead7", -- variables ONLY — the pop (brightest)
    var   = "#e8e8d3", -- variables ONLY — the pop (brightest)
    fg    = "#e8e8d3", -- Normal / identifiers / members / properties (calm base)
    param = "#d7d7c6", -- parameters (inputs, dimmer)
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
    type    = "#93a5a0", -- USER/custom types (cool teal-slate) — the type hero
    string  = "#a8bcac", -- strings (green — see role note below)
    const   = "#cca598", -- warm base: boolean / return / Error (dusty rose)
    keyword = "#b3a6b0", -- all keywords (plum-grey)
}

-- SIBLINGS — controlled enrichment: a split off one of the 5 families, kept
-- tight so it stays a tint of that family, never a new hue (no rainbow). Each
-- is either a VALUE step (same hue, lighter/darker) or a small hue nudge.
-- The cool (type) family has three roles, all under one hue:
--   type (#93a5a0 user types) · builtin (#859099 language/library) · def (#a8b0b8 preproc)
local sibling = {
    fn_lib     = "#cebfa1", -- stdlib fns (malloc/free/pthread): faded amber, quiet "not mine"
    builtin    = "#859099", -- builtin types (int/void/char) + library types + named consts: deeper blue-slate
    def        = "#a8b0b8", -- definitions: preproc / #define / macros / modules — light blue
    ret        = "#cc9a98", -- NUMBERS only: stronger rose, one step up from the const base
    --                         (return/boolean/Error stay on the softer const base)
    kw_control = "#9e8f9c", -- control flow (if/for/while/switch): deeper muted plum
    --                         (frequent -> quiet). brighter alt #b8a0be
}

function M.get()
    local p               = {}

    -- surfaces
    p.bg, p.sel, p.visual = BG, SEL, VIS

    -- bone (content). p.fg = calm base (Normal text); p.bone_var = the pop
    p.fg                  = bone.fg
    p.bone_var            = bone.var
    p.bone_param          = bone.param

    -- grey ladder
    p.role_op             = grey.op
    p.role_punct          = grey.punct
    p.comment_grey        = grey.comment
    p.grey                = grey.ui
    p.grey_ui             = grey.line
    p.grey_dim            = grey.dim
    p.punc_grey           = grey.punct -- telescope borders = punctuation tone (structural strokes)
    p.role_comment        = grey.comment

    -- accents + any siblings. Chrome (diagnostics/git/telescope/search) reads
    -- these SAME role_* keys directly — no color-name aliases (they lie the
    -- moment you retone; a role name says what the token IS and never lies).
    for role, hex in pairs(accent) do p["role_" .. role] = hex end
    for name, hex in pairs(sibling) do p["role_" .. name] = hex end

    return p
end

return M

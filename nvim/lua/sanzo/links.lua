-- ============================================================================
-- Sanzo — structural links / template (NO palette colors)
-- ----------------------------------------------------------------------------
-- The reusable scaffolding a theme sits on top of. Anchors (Define, @constant,
-- @type, ...) are colored in groups.lua; here we ROUTE the long-tail and
-- language-specific groups onto those anchors. Any theme can reuse this file
-- unchanged and just pick colors.
--
-- Value is either:
--   "TargetGroup"  -> becomes { link = "TargetGroup" }
--   { ...opts }    -> applied as-is (use {} to CLEAR, letting treesitter drive)
--
-- Applied with LOWER precedence than groups.lua (a colored group wins).
--
-- Neovim already links standard treesitter captures to legacy groups
-- (@keyword->Keyword, ...) and creates language variants (@x.c -> @x). This
-- file adds what nvim does NOT: LSP semantic tokens deferring to treesitter,
-- capture aliases, and per-language token fixes.
-- ============================================================================

return {
    -- ========================================================================
    -- COMMON (language-agnostic)
    -- ========================================================================

    -- ---- LSP semantic tokens -> treesitter ---------------------------------
    ["@lsp.type.variable"]                     = "@variable",
    ["@lsp.type.parameter"]                    = "@variable.parameter",
    ["@lsp.type.property"]                     = "@property",
    ["@lsp.type.field"]                        = "@variable.member",
    ["@lsp.type.function"]                     = "@function",
    ["@lsp.type.method"]                       = "@function.method",
    ["@lsp.type.class"]                        = "@type",
    ["@lsp.type.type"]                         = "@type",
    ["@lsp.type.enum"]                         = "@type",
    ["@lsp.type.struct"]                       = "@type",
    ["@lsp.type.interface"]                    = "@type",
    ["@lsp.type.typeParameter"]                = "@type.parameter",
    ["@lsp.type.builtinType"]                  = "@type.builtin",
    ["@lsp.type.enumMember"]                   = "@number", -- enum members = rose literals (const bucket), not the type-blue @constant
    ["@lsp.type.const"]                        = "@constant",
    ["@lsp.type.keyword"]                      = "@keyword",
    ["@lsp.type.modifier"]                     = "@keyword.modifier",
    ["@lsp.type.namespace"]                    = "@module",
    ["@lsp.type.macro"]                        = "@constant.macro",
    ["@lsp.type.comment"]                      = "@comment",
    ["@lsp.type.string"]                       = "@string",
    ["@lsp.type.number"]                       = "@number",
    ["@lsp.type.operator"]                     = "@operator",
    ["@lsp.type.decorator"]                    = "@attribute",
    ["@lsp.type.selfKeyword"]                  = "@variable.builtin",

    -- ---- capture refinements: route mislabeled captures to the right anchor ----
    ["@keyword.operator"]                      = "@operator", -- sizeof/alignof, typeof, not/in/and/or = operators
    ["@variable.builtin"]                      = "@constant", -- this/self/NULL/true = literal pop, off plain var
    ["@function.builtin"]                      = "@function", -- libc printf/malloc = amber landmarks (explicit)
    ["@constant.builtin"]                      = "@constant", -- true/false/nullptr(c23) = literal pop, not Special

    -- ---- preproc: macros route to the `Define` anchor (colored in groups) ---
    ["@constant.macro"]                        = "Define", -- #define names, include guards

    -- ---- older-grammar / alias captures ------------------------------------
    ["@doc"]                                   = "@comment",
    ["@text.literal"]                          = "@markup.raw",
    ["@text.reference"]                        = "@markup.link",
    ["@text.title"]                            = "@markup.heading",
    ["@text.uri"]                              = "@markup.link.url",

    -- ========================================================================
    -- LANGUAGE-SPECIFIC  (extend per language; `{}` clears a noisy token)
    -- ========================================================================

    -- ---- C -----------------------------------------------------------------
    ["@function.macro.c"]                      = "PreProc",
    ["@lsp.type.property.c"]                   = "@property",
    ["@lsp.typemod.property.classScope.c"]     = {}, -- clear -> ts drives
    ["@lsp.typemod.property.declaration.c"]    = "@property",
    ["@lsp.type.parameter.c"]                  = "@variable.parameter",
    ["@lsp.mod.functionScope.c"]               = {}, -- clear modifier token
    ["@lsp.typemod.parameter.functionScope.c"] = "@variable.parameter",
    ["@lsp.typemod.parameter.declaration.c"]   = "@variable.parameter",
    ["@lsp.typemod.parameter.definition.c"]    = "@variable.parameter",
    -- enum members = rose literals. The live tokens are the high-priority (127)
    -- typemods -> @lsp (colorless); route them all to @number to force rose.
    ["@lsp.type.enumMember.c"]                 = "@number",
    ["@lsp.typemod.enumMember.readonly.c"]     = "@number",
    ["@lsp.typemod.enumMember.fileScope.c"]    = "@number",
    ["@lsp.typemod.enumMember.defaultLibrary.c"] = "@number",
    ["@constant.builtin.c"]                    = "@constant", -- nullptr/NULL/true: beat grammar's Special link
    ["@lsp.typemod.function.defaultLibrary.c"] = "@function",  -- malloc/printf/memcpy = amber, like any call
    ["@lsp.typemod.function.globalScope.c"]    = "@function",  -- global fns: keep amber (beat @lsp blanking)
    -- @keyword.operator.c inherits the COMMON @keyword.operator -> @operator link


    -- ---- Rust (example — add when needed) ----------------------------------
    -- ["@lsp.type.derive.rust"]   = "@attribute",
    -- ["@lsp.type.builtinAttribute.rust"] = "@attribute",
}

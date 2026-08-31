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

    -- ---- capture refinements: mislabeled captures -> right anchor ----------
    -- sizeof/typeof/not/and/or are operators, not keywords
    ["@keyword.operator"]                      = "@operator",
    -- this/self/NULL/true = literal, off plain var
    ["@variable.builtin"]                      = "@constant",
    -- true/false/nullptr = literal, not Special
    ["@constant.builtin"]                      = "@constant",
    -- (@function.builtin colored directly in groups.lua = stdlib tone)

    -- macros -> Define anchor (#define names, include guards)
    ["@constant.macro"]                        = "Define",

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

    -- preproc macros -> Define (all typemods; the 127 typemod else blanks)
    ["@function.macro.c"]                        = "PreProc",
    ["@lsp.typemod.macro.globalScope.c"]         = "Define",
    ["@lsp.typemod.macro.fileScope.c"]           = "Define",
    ["@lsp.typemod.macro.defaultLibrary.c"]      = "Define",
    ["@lsp.typemod.macro.declaration.c"]         = "Define",

    -- properties / fields (class members recede to bone, under the fn hero)
    ["@lsp.type.property.c"]                      = "@property",
    ["@lsp.typemod.property.declaration.c"]       = "@property",
    ["@lsp.typemod.property.classScope.c"]        = "@variable.member",

    -- parameters
    ["@lsp.type.parameter.c"]                     = "@variable.parameter",
    ["@lsp.typemod.parameter.functionScope.c"]    = "@variable.parameter",
    ["@lsp.typemod.parameter.declaration.c"]      = "@variable.parameter",
    ["@lsp.typemod.parameter.definition.c"]       = "@variable.parameter",
    ["@lsp.mod.functionScope.c"]                  = {},

    -- enum members -> rose (all typemods; the 127 typemod else blanks)
    ["@lsp.type.enumMember.c"]                    = "@number",
    ["@lsp.typemod.enumMember.readonly.c"]        = "@number",
    ["@lsp.typemod.enumMember.fileScope.c"]       = "@number",
    ["@lsp.typemod.enumMember.defaultLibrary.c"]  = "@number",

    -- types: 3-way split. int/void/char = @type.builtin (treesitter, deeper slate);
    -- struct foo = @type (slate). LSP typemods at 127 outrank @type.type.c (125),
    -- so route them or they blank to @lsp:
    --   defaultLibrary (size_t/FILE/pthread_t, from headers) -> teal-slate sibling
    --   fileScope (user types declared in this file)         -> back to @type
    ["@lsp.typemod.type.defaultLibrary.c"]        = "@type.library",
    ["@lsp.typemod.type.fileScope.c"]             = "@type",

    -- constants / user globals
    ["@constant.builtin.c"]                       = "@constant",
    ["@lsp.typemod.function.globalScope.c"]       = "@function",
    -- stdlib fns (defaultLibrary) -> semantic.lua autocmd.
    -- member-calls + NULL/true/false -> after/queries/c/highlights.scm.


    -- ---- Rust (example — add when needed) ----------------------------------
    -- ["@lsp.type.derive.rust"]   = "@attribute",
    -- ["@lsp.type.builtinAttribute.rust"] = "@attribute",
}

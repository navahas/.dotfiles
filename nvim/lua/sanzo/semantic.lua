-- ============================================================================
-- Sanzo — LSP semantic-token behaviors (lives WITH the theme, not user config)
-- ----------------------------------------------------------------------------
-- Some distinctions are known ONLY to the language server, not treesitter, and
-- can't be resolved by links (they'd be a same-priority tie). Those need an
-- LspTokenUpdate hook that re-weights a specific token by its modifiers.
--
-- This belongs to sanzo, not the user's lsp config: gated to the sanzo
-- colorscheme so switching themes silently disables it (no override of others).
-- Ships with the plugin. Companion: treesitter-side fixes live in
-- `after/queries/<lang>/highlights.scm` (they encode facts treesitter DOES know,
-- e.g. a name in call position is a function).
-- ============================================================================

local M = {}

function M.setup()
    local grp = vim.api.nvim_create_augroup("SanzoSemantic", { clear = true })

    vim.api.nvim_create_autocmd("LspTokenUpdate", {
        group = grp,
        callback = function(args)
            if vim.g.colors_name ~= "sanzo" then return end
            local tok = args.data.token

            -- stdlib / library functions (malloc/free/pthread): only the LSP
            -- knows this (the `defaultLibrary` modifier — treesitter can't see
            -- it). Force @function.builtin above the globalScope tie (both 127).
            if tok.type == "function" and tok.modifiers.defaultLibrary then
                vim.lsp.semantic_tokens.highlight_token(
                    tok, args.buf, args.data.client_id, "@function.builtin",
                    { priority = 200 })
            end

            -- library types (size_t/FILE/pthread_t): defaultLibrary modifier,
            -- LSP-only. Force @type.library (teal-slate sibling), matching the
            -- per-language typemod route in links.lua.
            if tok.type == "type" and tok.modifiers.defaultLibrary then
                vim.lsp.semantic_tokens.highlight_token(
                    tok, args.buf, args.data.client_id, "@type.library",
                    { priority = 200 })
            end
        end,
    })
end

return M

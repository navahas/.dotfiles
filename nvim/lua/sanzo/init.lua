-- ============================================================================
-- Sanzo — modular colorscheme (plugin-style, jellybeans-like override hooks)
-- ----------------------------------------------------------------------------
-- Meant to be extracted into its own repo and cloned as a plugin. User config
-- customizes purely through setup() — never by editing this module.
--
--   require("sanzo").setup({
--     transparent = true,                    -- bg=NONE (default) vs solid p.bg
--     on_colors = function(p) ... end,       -- mutate palette before groups
--     on_highlights = function(hl, p) ... end,-- mutate final highlight table
--     palette = { ... },                     -- fully override the palette
--   })
--   vim.cmd.colorscheme("sanzo")
-- ============================================================================

local M = {}

M.config = {
    transparent = true,
    on_colors = nil,
    on_highlights = nil,
    palette = nil,
}

function M.setup(opts)
    M.config = vim.tbl_extend("force", M.config, opts or {})
end

function M.load()
    vim.cmd("highlight clear")
    if vim.g.syntax_on then vim.cmd("syntax reset") end
    vim.o.termguicolors = true
    vim.g.colors_name = "sanzo"

    local cfg = M.config

    -- 1. palette (self-contained muted anchors + neutrals, or full override) + hook
    local p = cfg.palette or require("sanzo.palette").get()
    if type(cfg.on_colors) == "function" then cfg.on_colors(p) end

    -- 2. build highlight table (pure, colors on base groups)
    local groups = require("sanzo.groups")(p, cfg)

    -- 3. structural links (common + per-language) — lower precedence: a colored
    --    group from groups.lua wins. Value = "Target" (link) or opts table.
    for group, v in pairs(require("sanzo.links")) do
        if groups[group] == nil then
            groups[group] = type(v) == "string" and { link = v } or v
        end
    end

    -- 4. user hook (wins last) + apply
    if type(cfg.on_highlights) == "function" then cfg.on_highlights(groups, p) end
    for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- 5. LSP semantic-token behaviors (stdlib fns, etc.) — sanzo-owned, gated.
    require("sanzo.semantic").setup()
end

return M

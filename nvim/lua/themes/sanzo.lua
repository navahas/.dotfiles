-- ============================================================================
-- Sanzo — independent theme unit.
-- The theme itself is a plugin (lua/sanzo/*), self-contained with its own
-- overrides. This file just activates it. Personal tweaks, if ever needed,
-- go in the setup() call below (on_colors / on_highlights) — this unit only.
-- ============================================================================

require("sanzo").setup({
    transparent = true, -- bg = NONE (terminal shows through); false = solid bg
    -- on_highlights = function(hl, p) ... end,
})

vim.cmd.colorscheme("sanzo")

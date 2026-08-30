-- ============================================================================
-- Theme selector
-- ----------------------------------------------------------------------------
-- Each theme is an independent, self-contained unit in themes/<name>.lua
-- (its own setup + overrides + colorscheme call). Switch the active theme by
-- changing the one line below. Add a theme = install its plugin + drop a
-- themes/<name>.lua file.
-- ============================================================================

local active = "sanzo" -- "jellybeans" | "sanzo"

require("themes." .. active)

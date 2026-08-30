# Sanzo — theme guide

A modular, plugin-style Neovim colorscheme. Meant to be extracted into its own
repo and cloned as a plugin; all personal customization happens through
`setup()`, never by editing this module.

## Layout

```
colors/sanzo.lua      entry point -> require("sanzo").load()
lua/sanzo/
  init.lua            setup(opts) + load(); override hooks
  palette.lua         roles -> hex (self-contained muted anchors + grey ladder)
  groups.lua          COLORS: (palette, cfg) -> { [group] = opts } on base groups
  links.lua           STRUCTURAL LINKS (no color): LSP tokens -> treesitter, aliases
  README.md           this file
```

Precedence (init.lua applies in this order): colored `groups.lua` wins over a
link in `links.lua`, and your `setup{ on_highlights }` wins over both.

The palette is **self-contained** in `palette.lua` — 5 muted anchors (fn, type,
string, const, keyword), a neutral grey ladder (op > punct > comment > chrome),
and chrome aliases that follow the anchors. Decoupled from the terminal 16; this
theme owns its own colors.

## Customizing (from your config, not here)

```lua
require("sanzo").setup({
  transparent = true,                       -- bg = NONE (default) | false = solid
  on_colors = function(p) ... end,          -- mutate palette before groups build
  on_highlights = function(hl, p) ... end,  -- override/add groups, wins last
})
vim.cmd.colorscheme("sanzo")
```

## Editing colors

In `groups.lua`, syntax is grouped **by role** — a LIST of `{ color, {groups} }`
rows (not keyed by hex: two roles may share a color, so a hex key would collide).
Move a group between rows to recolor it:

```lua
local fg_by_color = {
  { p.role_fn,      { "Function", "@function", "@method" } },
  { p.role_type,    { "Type", "@type", "@type.builtin", ... } },
  { p.role_keyword, { "Statement", "@keyword", "Conditional", ... } },
  { p.role_string,  { "String", "@string", "@string.escape", ... } },
  { p.role_const,   { "@number", "@constant", "Error" } },
  ...
}
```

Retone a role by editing its one hex in `palette.lua`. To split a capture without
a brightness step, add an equal-luminance sibling (see the `type_alt` note) and
give it its own row. Groups needing more than `fg` live in the "extra attributes"
block below the rows.

## Treesitter capture hierarchy (IMPORTANT)

Capture names are hierarchical and Neovim **auto-falls-back right-to-left**:

```
@keyword.directive.define.c
  -> @keyword.directive.define
  -> @keyword.directive
  -> @keyword
```

So you only color **base groups**; everything specific inherits for free.
Override a subgroup **only** when you want it to differ (e.g. an equal-luminance
sibling for `@type.builtin`). By default Sanzo folds subgroups into their base
(blend > distinction).

### Base captures to keep colored

Everything else inherits these. General across languages:

| base                                                | role                       |
| --------------------------------------------------- | -------------------------- |
| `@comment` `@string` `@character`                   | comments, strings          |
| `@keyword`                                           | control flow, declarations |
| `@function` `@method` `@constructor`                | callables                  |
| `@type` `@type.builtin`                             | types                      |
| `@constant` `@number` `@boolean`                    | literals                   |
| `@variable` `@property` `@field` `@parameter`       | data / identifiers         |
| `@operator` `@punctuation`                          | symbols                    |
| `@module` `@namespace`                              | imports / namespaces       |
| `@keyword.directive` `@function.macro` `@constant.macro` | **C/C++ preproc**     |
| `@tag` `@tag.attribute` `@tag.delimiter`            | HTML / JSX / XML           |
| `@markup.*`                                          | markdown / prose           |

### Linking

`link = "..."` makes a group mirror another. Two good uses:

1. **Make LSP semantic tokens defer to treesitter** — link `@lsp.type.*` to the
   treesitter base so the language server doesn't fight the theme:
   ```lua
   h["@lsp.type.variable"] = { link = "@variable" }
   h["@lsp.type.type"]     = { link = "@type" }
   ```
2. **Language-specific fixes** — e.g. C `defined` is captured as
   `@function.macro`; Neovim defaults link it to `@function`. Put it in the
   preproc row (role_type) instead so it reads as scaffolding, not a call.

Don't over-link: the right-to-left fallback already handles most cases.

### links.lua as a reusable template

`links.lua` is the structural scaffolding — no palette colors, so any theme can
reuse it verbatim and only pick colors. It has two parts:

- **COMMON** (language-agnostic): LSP semantic tokens → treesitter, capture
  aliases, and preproc macros → the `Define` anchor.
- **LANGUAGE-SPECIFIC**: one section per language (`-- C`, `-- Rust`, …) routing
  that language's `@lsp.*.<lang>` tokens. Add a language = add a section.

Anchors (`Define`, `@constant`, `@type`, …) are **universal**; only the routing
of a given grammar's captures / a server's semantic tokens onto them is
language-specific. Each value is either `"TargetGroup"` (→ a link) or an opts
table (`{}` clears a noisy token so treesitter drives).

**Creating a semantic group** (e.g. macros as their own color):
1. name an anchor — legacy `Define`;
2. color it in `groups.lua` (drop it in a bucket);
3. route captures to it in `links.lua` (`["@constant.macro"] = "Define"`).
The LSP token follows for free since `@lsp.type.macro → @constant.macro`.

## Rule of thumb

Color the base captures, override a handful for taste (`@keyword.return`,
`@type.builtin`), link `@lsp.type.*` to the treesitter base. Covers C well and
generalizes cleanly to other languages.

## Inspecting

- `:Inspect` — show capture groups + final highlight under the cursor.
- `:Inspect!` (or `:InspectTree`) — the treesitter tree for the buffer.

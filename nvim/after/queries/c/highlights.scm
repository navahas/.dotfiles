; extends

; The ONE earned priority rule. A struct member in CALL position is a function
; pointer being called — trust treesitter over clangd, which labels it
; property.classScope (LSP priority 127 > treesitter 100). Without this,
; vtable-style calls (t->comp(...), obj.fn()) render as white members.
;
; ONLY field_expression calls are bumped:
;   - plain calls foo() already get amber from the LSP (@lsp.type.function 125);
;   - function-like MACROS MAX(x) are plain identifiers too and must stay Define
;     (blue) via their macro semantic token — bumping identifier-calls would
;     wrongly turn macros amber. So we touch member-calls only.

((call_expression
   function: (field_expression
     field: (field_identifier) @function.call))
 (#set! priority 200))

; NULL / true / false are builtin CONSTANTS, not macros. clangd tags NULL as a
; macro (127 -> Define); treesitter knows better (dedicated (null)/(true)/(false)
; nodes). Bump above the semantic token so they read as constants.
([(null) (true) (false)] @constant.builtin (#set! priority 200))

#!/usr/bin/env nu
# Show common scalar C types and their printf specifiers

let table = [
  { level: 0, name: "size_t", category: "Unsigned", where: "<stddef.h>", printf: "%zu %zx" }
  { level: 0, name: "double", category: "Floating", where: "Built in", printf: "%e %f %g %a" }
  { level: 0, name: "signed (int)", category: "Signed", where: "Built in", printf: "%d" }
  { level: 0, name: "unsigned", category: "Unsigned",  where: "Built in", printf: "%b %o %u %x" }
  { level: 0, name: "bool (_Bool)", category: "Unsigned", where: "Built in (since C23)", printf: "%d (0 or 1)" }
  { level: 1, name: "ptrdiff_t", category: "Signed", where: "<stddef.h>", printf: "%td" }
  { level: 1, name: "char const*", category: "String", where: "Built in", printf: "%s" }
  { level: 1, name: "char", category: "Character", where: "Built in", printf: "%c" }
  { level: 1, name: "void*", category: "Pointer", where: "Built in", printf: "%p" }
  { level: 2, name: "unsigned char", category: "Unsigned", where: "Built in", printf: "%hhu %02hhx" }
]

$table
# $table | sort-by level name

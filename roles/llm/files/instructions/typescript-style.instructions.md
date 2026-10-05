---
name: TypeScript Style
description: "Write simple, readable TypeScript with explicit failure paths. Use when writing or refactoring TypeScript, TSX, Astro, or Vue SFCs."
applyTo: "**/*.ts, **/*.tsx, **/*.astro, **/*.vue, **/*.mts, **/*.cts"
---

# TypeScript Style

## Arguments and errors

- Prefer required arguments; resolve defaults once at the entry point.
- Let errors throw; catch only at the outermost boundary.
- Distinguish missing data from failures; return empty only for absent files.

## Tests

- Mirror `src` layout under `tests`; route shared imports through a barrel.
- Test-only access goes through an explicit `__test__` object, never bare exports.

## Syntax and imports

- Keep `switch` only when linters accept exhaustiveness; else use `if` chains.
- Merge same-source imports into one statement with inline `type` qualifiers.

---
name: Code Structure
description: "Keep module boundaries and function scope tight. Use when splitting files, placing logic, or trimming exports and wrappers."
---

# Code Structure

## Module boundaries

- Place domain knowledge in one module; keep dependents thin.
- Keep structures flat; avoid single-field wrapper objects.
- Share literals via one constant; avoid duplicating names or values.

## File granularity

- Keep one concern per file; split only when a second concern emerges.
- Merge files that cover a similar range; avoid one-function files. Group by direction of conversion when both directions share parsing (e.g. frontmatter structure vs. `applyTo`/`paths`/glob conversion).
- Keep the current file layout unchanged unless asked for a new split; respect intentional blank-line choices such as compact `ParsePaths`-style loops.

## Functions and exports

- Keep public surface minimal; expose only cross-module callers.
- Remove pass-through wrappers; call the real function directly.
- Split only at a meaningful unit of work; do not extract a function that has just one caller doing only wrapping. A thin helper shared by multiple callers to remove duplication is allowed.
- Keep single-purpose helpers inline when inlining removes indirection without growing the caller (e.g. one-line `Trim` chains, `filepath.Join` + `ToSlash` pairs); extract only when the helper names a distinct decision such as quote handling or symlink escape checks.

## Refactoring safety

- Separate moving code from changing it: a rename, a move, and a behaviour fix in one step leave the fix unverifiable.
- Report a logic fix only with evidence the old code was wrong — a runnable snippet, a failing test, an observed value; otherwise state it as a rename.

## Layout and blank lines

- Separate processing blocks with one blank line: guard clause, setup, main loop, and return each get breathing room. Keep `switch` directly attached to its first `case`, and separate remaining `case` blocks with one blank line.

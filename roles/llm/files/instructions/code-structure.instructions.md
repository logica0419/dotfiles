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

- Keep one concern per file; split only when a second concern emerges, and merge files covering a similar range.
- Group by direction of conversion when both directions share parsing.
- Keep the current layout unchanged unless a split is asked for, and respect intentional blank-line choices.

## Functions and exports

- Keep the public surface minimal; expose only cross-module callers, and remove pass-through wrappers.
- Split at a meaningful unit of work: a thin helper several callers share to drop duplication qualifies, a one-caller wrapper does not.
- Keep a single-purpose helper inline when inlining removes indirection without growing the caller; extract only when the helper names a distinct decision such as quote handling or symlink escape checks.

## Refactoring safety

- Separate moving code from changing it: a rename, a move, and a behaviour fix in one step leave the fix unverifiable.
- Report a logic fix only with evidence the old code was wrong — a runnable snippet, a failing test, an observed value; otherwise state it as a rename.

## Layout

- Put one blank line between the guard clause, setup, main loop, and return.

---
name: instruction-maintenance
description: "Add, update, or condense instructions, skills, prompts, or agents. Use when recording a constraint, choosing the primitive, or deciding destinations."
argument-hint: "Constraint or files to record, e.g. task naming rule"
---

# Instruction Maintenance

Record a reusable constraint without duplication.

## When to Use

- Recording a user preference.
- Choosing the primitive or destination.
- Condensing after an edit.

## Procedure

1. Read the constraint and surrounding files; keep only preferences code cannot reveal, else report `unchanged` and stop.
2. Choose one primitive (most work → instructions, workflow → skill, one-off → prompt, boundaries → agent, enforcement → hook).
3. Decide one destination and append there only: other repositories → shared global location then deploy; multiple areas → shared project instructions; one area → area notes (e.g. `AGENTS.md`); otherwise report `unchanged` and stop.
4. Write keyword-rich `description` with a "Use when..." trigger; `applyTo` only for file-scoped rules, never `"**"` for task-scoped content; keep `name` consistent with file or folder name.
5. Re-read every changed file, then condense without changing meaning.
6. Report `changed / unchanged` plus merged or removed points.

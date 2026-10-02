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

1. Read the constraint and surrounding files; retain only user preferences that are not explicitly coded in the system, else report `unchanged` and stop.
2. First, identify the task type. Then select one primitive: most work → instructions, workflow → skill, one-off → prompt, boundaries → agent, enforcement → hook.
3. Decide one destination from the following options and append to that destination only: other repositories → shared global location then deploy; multiple areas → shared project instructions; one area → area notes (e.g. `AGENTS.md`); otherwise report `unchanged` and stop.
4. Write keyword-rich `description` with a "Use when..." trigger; `applyTo` only for file-scoped rules, never `"**"` for task-scoped content; keep `name` consistent with file or folder name.
5. Preserve meaning strictly; condense only where meaning is unchanged, then run `chatCustomizationsEvaluations.analyzePrompt` on every changed file and apply fixes.
6. Repeat step 5 until no findings remain.
7. Report `changed / unchanged` plus merged or removed points.

---
name: Instruction Style
description: "Decide what belongs in instructions, skills, prompts, or agents. Use when writing, updating, or condensing them."
applyTo: "**/*.instructions.md, **/SKILL.md, **/AGENTS.md"
---

# Instruction Style

## Choose the primitive

- Most work → instructions (always-on).
- Repeatable workflow → skill (on-demand).
- One-off task → prompt.
- Role or tool boundaries → agent.
- Guaranteed enforcement → hook, not instructions.

## What to write

- Write only preferences surrounding code cannot reveal; keep as concise as possible without changing meaning.
- Keep one concern per file; prefer short examples.
- Do not append obvious, duplicated, procedural, or non-decision-improving content.

## Discovery

- Write keyword-rich `description` with a "Use when..." trigger.
- Use `applyTo` only for file-scoped globs; avoid bare `"**"`.
- Keep `name` consistent with file or folder name; quote `description` with colons.

## Procedure

- Follow the `/instruction-maintenance` skill procedure.

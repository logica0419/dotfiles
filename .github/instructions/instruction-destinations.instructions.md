---
description: "Use when recording a new instruction, skill, prompt, agent, or AGENTS.md rule in this dotfiles repo."
applyTo: "**/*.instructions.md, **/SKILL.md, **/AGENTS.md"
---

# Instruction Destinations

Follow the global `/instruction-maintenance` skill procedure with these dotfiles bindings.

- Other repositories → `roles/llm/files/` (`instructions/` or `skills/`), then ask the user to re-run dotfiles.
- Shared instructions → `.github/instructions/*.instructions.md`.
- One area → the corresponding `AGENTS.md` (`roles/<role>/` or `windows/`).
- Write `applyTo` as a double-quoted single-line string (single quotes, trailing comments, and CR are unsupported by sync); join patterns with commas.
- Avoid commas inside `{…}` brace groups in `applyTo`; sync splits on every comma.

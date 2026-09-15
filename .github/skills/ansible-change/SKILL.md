---
name: ansible-change
description: "Edit Ansible roles and playbooks in this dotfiles repo. Use when adding or renaming tasks, changing files/templates, or handling OS differences."
argument-hint: "Target role or change, e.g. llm skill deployment"
---

# Ansible Change

Change an Ansible role or playbook in this dotfiles repo with a minimal diff.

## When to Use

- Adding or renaming tasks; changing `files/` or `templates`; handling OS differences; validating with `ansible-lint`.

## Procedure

1. Read the target role's `AGENTS.md` when present, and follow its design decisions and exceptions.
2. Follow the global Ansible style plus `ansible-tasks.instructions.md`.
3. Edit with a minimal diff.
4. After changes, verify the target playbook runs, plus check with `ansible-lint`.
5. When a new constraint emerges, record it with `/instruction-maintenance`. Do not append routinely.

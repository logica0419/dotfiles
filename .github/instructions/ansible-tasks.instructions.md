---
description: "Use when writing Ansible tasks, playbooks, handlers, or shell tasks, changing files/templates, or handling OS differences in this dotfiles repo."
applyTo: "roles/**/*.yaml, *.yaml, inventory/**/*"
---

# Ansible Tasks

Follow the global Ansible style first; this file adds dotfiles-only constraints.

- Read the target role's `AGENTS.md` when present, and follow its design decisions and exceptions.
- Prefer dotfiles verbs (`Configure`, `Create`, `Deploy`, `Install`, `Enable`, `Get`); map legacy `Copy` / `Move` / `Put` / `Setup` / `Check` to them; fix shared phrases to one spelling (`SSH`, `VS Code`, `workspace path`, `updater service`).
- Prefix `register` with `<role>_`.
- Prefer `community.general.homebrew_services` over direct `brew services`.
- Disable automatic dotfile edits by external installers when possible; distribute via the `rc` role.

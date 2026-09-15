# Copilot Instructions

Ansible-based dotfiles repository for Mac, WSL, and server.

## Build and Test

```bash
uv run ansible-lint -s --exclude .github/* --exclude .github/workflows/*
```

Run the target playbook plus `ansible-lint` after Ansible changes.

## Conventions

- Express OS differences through playbook and role separation of concerns.
- Respect existing facts references and template naming conventions.
- Bash, YAML, and Jinja2 coexist, so do not mix language-specific idioms.
- See `.github/skills/ansible-change/SKILL.md` for the Ansible change procedure.
- See `.github/instructions/instruction-destinations.instructions.md` for instruction destinations.

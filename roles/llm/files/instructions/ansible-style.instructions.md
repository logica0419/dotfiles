---
name: Ansible Style
description: "Write consistent Ansible tasks and playbooks. Use when adding or editing tasks, blocks, handlers, files, templates, or shell tasks."
applyTo: "**/*.yaml, **/*.yml"
---

# Ansible Style

```yaml
- name: Deploy app config file
  ansible.builtin.template:
    src: app.conf.j2
    dest: /etc/app/app.conf
    mode: "0644"
```

## Task names

- Keep `name` to 2-6 space-separated words starting with a verb (`Install`, `Deploy`, `Configure`).
- Reuse one name for the same purpose, settle a repeated phrase on one spelling, and drop a prefix that only repeats clear context.

## Blocks and OS differences

- Group related tasks in a `block` without blank lines; set shared `become` at block level.
- Express OS differences via `include_tasks` or `vars`; reference `ansible_facts.<fact_name>`.

## Fields and change detection

- Keep field order: `name` -> `become` / `when` -> module -> args -> `changed_when` / `failed_when` -> `register` -> `notify` (`state` right after `name` for packages).
- Add `changed_when` / `failed_when` where applicable; prefer `notify` + handler over `when: <reg>.changed`.

## Files, templates, and directories

- Create nested directories parent-first; loop related directories in one `ansible.builtin.file` task; avoid `recurse`.
- Use `templates` for variable expansion, else `files`; keep `content` to one line; keep `noqa` minimal with a clear reason.

## Shell tasks

- Use `ansible.builtin.shell`, not `ansible.builtin.command`, when the check needs a shell builtin.
- Prefer POSIX form; set `args.executable: /bin/bash` only for Bash-specific syntax. Embedded shell code follows shell-style.

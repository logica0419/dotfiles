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

- Keep `name` to 2-6 words starting with a verb (e.g., Install, Deploy, Configure); reuse same-purpose names, avoid redundant prefixes, omit clear context, fix shared phrases to one spelling.

## Structure

- Group related tasks in a `block` without blank lines; set shared `become` at block level.
- Express OS differences via `include_tasks` or `vars`; reference `ansible_facts.<fact_name>`.
- Add `changed_when` / `failed_when` where applicable; prefer `notify` + handler over `when: <reg>.changed`.
- Keep field order: `name` -> `become` / `when` -> module -> args -> `changed_when` / `failed_when` -> `register` -> `notify` (`state` right after `name` for packages).
- Create nested directories parent-first; loop related directories in one `ansible.builtin.file` task; avoid `recurse`.
- Use `templates` for variable expansion, else `files`; keep `content` to one line; keep `noqa` minimal with a clear reason.

## Shell tasks

- Check command existence with `command -v ... >/dev/null 2>&1` using `ansible.builtin.shell` (not `ansible.builtin.command`, which lacks shell builtins); keep idempotent with explicit exit codes per shell-style.
- Prefer POSIX form; set `args.executable: /bin/bash` only for Bash-specific syntax.
- See [shell-style](./shell-style.instructions.md) for embedded shell code.

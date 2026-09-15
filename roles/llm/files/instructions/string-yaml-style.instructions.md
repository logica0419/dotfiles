---
name: String and YAML Style
description: "Keep string quoting and YAML notation consistent. Use when writing YAML, Ansible tasks, or long commands and strings."
applyTo: "**/*.yaml, **/*.yml"
---

# String and YAML Style

- Use `yaml` extensions, not `yml`; double quotes by default, single only for special characters or reserved keywords.
- Preserve indentation and line-break width; keep one notation per purpose; avoid extra YAML symbols.
- For long strings prefer `>-` or `|` over escaping.

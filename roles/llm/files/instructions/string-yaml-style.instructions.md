---
name: String and YAML Style
description: "Keep string quoting and YAML notation consistent. Use when writing YAML, Ansible tasks, or long commands and strings."
applyTo: "**/*.yaml, **/*.yml"
---

# String and YAML Style

- Use the `yaml` extension, not `yml`; quoting follows quote-style.
- Keep one notation per purpose, and match the file's existing indentation and line width.
- For long strings prefer `>-` or `|` over escaping.

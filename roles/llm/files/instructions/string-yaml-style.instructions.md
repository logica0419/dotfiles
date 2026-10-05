---
name: String and YAML Style
description: "Keep string quoting and YAML notation consistent. Use when writing YAML, Ansible tasks, or long commands and strings."
applyTo: "**/*.yaml, **/*.yml"
---

# String and YAML Style

## Extensions and quoting

- Use `yaml` extensions, not `yml`; quoting follows quote-style.

## Notation and formatting

- Preserve indentation and line-break width; keep one notation per purpose; avoid extra YAML symbols.

## Long strings

- For long strings prefer `>-` or `|` over escaping.

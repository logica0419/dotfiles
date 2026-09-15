---
name: Shell Style
description: "Write idempotent shell scripts with explicit failure behavior. Use when writing Bash scripts, shell tasks, or installer shims."
applyTo: "**/*.sh"
---

# Shell Style

```bash
#!/bin/bash
set -eu -o pipefail

if ! command -v git >/dev/null 2>&1; then
  echo "Installing git"
fi
```

- Prefer idempotency with explicit exit codes.
- Use `command -v` checks and `>/dev/null 2>&1` suppression; add `-e` / `-u` / `-o pipefail` as needed. Bash-only `&>/dev/null` requires Bash via `args.executable`.

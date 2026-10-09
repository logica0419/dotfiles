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

## Idempotency and failure

- Make a script safe to re-run; on an unmet precondition, write the reason to stderr and exit non-zero.

## Command checks and suppression

- Check with `command -v ... >/dev/null 2>&1`; set `-e` / `-u` / `-o pipefail` as needed.
- Bash-only syntax such as `&>/dev/null` needs `args.executable: /bin/bash`.

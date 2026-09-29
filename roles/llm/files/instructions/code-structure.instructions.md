---
name: Code Structure
description: "Keep module boundaries and function scope tight. Use when splitting files, placing logic, or trimming exports and wrappers."
---

# Code Structure

- Place domain knowledge in one module; keep dependents thin.
- Keep one concern per file; split only when a second concern emerges.
- Keep public surface minimal; expose only cross-module callers.
- Remove pass-through wrappers; call the real function directly.
- Share literals via one constant; avoid duplicating names or values.
- Keep structures flat; avoid single-field wrapper objects.

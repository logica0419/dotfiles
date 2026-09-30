# llm role

- Manage user-scope global instructions and skills under `files/`; `~/.agents` distribution is owned here, not by the `rc` role.
- Install all external skills (`explainer`, `explainer-book`, `first-reader`) via `bunx --bun skills add` on every run (no vendoring).

# llm role

- Manage user-scope global instructions and skills under `files/`; `~/.agents` distribution is owned here, not by the `rc` role.
- Install all external skills (`explainer`, `explainer-book`, `first-reader`) via `bunx --bun skills add` on every run (no vendoring).
- List every file under `files/` in `tasks/main.yaml`; an unregistered file is never installed.
- Treat `files/` as the source and `~/.copilot/instructions/` as the deployed copy.
- Sync the edited file there before `chatCustomizationsEvaluations.analyzePrompt`; a stale copy makes the analyzer report conflicts over text the file does not contain.

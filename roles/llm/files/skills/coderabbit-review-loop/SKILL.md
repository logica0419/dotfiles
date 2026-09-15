---
name: coderabbit-review-loop
description: Run CodeRabbit reviews until no findings remain. Use when the user asks to review with CodeRabbit before a PR.
---

# CodeRabbit Review Loop

Run before creating a PR to raise code quality. Only run when the user explicitly asks.

1. Ensure a feature branch (create/switch if needed), record HEAD as `<loop-base>`, then commit the worktree.
2. Run `coderabbit review --agent --base-commit <last reviewed>` (first: `<loop-base>`).
3. Ask the user on design decisions; ask before adding invalid findings to `.coderabbit.yaml` `path_instructions`. Config changes apply only after merging to main; verify with `@coderabbitai configuration`.
4. Fix valid findings, run the project's check/lint/format commands, commit; repeat until `findings: 0`.
5. `git reset <loop-base>` (mixed, keep worktree), notify and wait, then recommit granularly.

---
name: coderabbit-review-loop
description: Run CodeRabbit reviews until no findings remain. Use when the user asks to review with CodeRabbit before a PR.
---

# CodeRabbit Review Loop

Only run when explicitly asked.

1. Ensure feature branch, record HEAD as `<loop-base>`, commit worktree (keep local, never push).
2. Run `coderabbit review --agent --base-commit <last reviewed>` (first: `<loop-base>`).
3. Triage each finding: fix if valid; always ask if fix adds complexity.
4. Ask with summary, fix cost, keep-simple risk, `accept fix` vs `keep simple + suppress`, and recommendation (default `keep simple` when risk is low).
5. On `keep simple`: ask before adding one concise English `path_instructions` entry with narrow glob. Config applies after merging to main; verify with `@coderabbitai configuration`.
6. Fix accepted findings, run check/lint/format, commit; repeat until `findings: 0`.
7. `git reset <loop-base>` (mixed, keep worktree), notify and wait, then recommit granularly.

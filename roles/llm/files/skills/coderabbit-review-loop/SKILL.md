---
name: coderabbit-review-loop
description: Run CodeRabbit reviews until no findings remain. Use when the user asks to review with CodeRabbit before a PR.
---

# CodeRabbit Review Loop

Only run when explicitly asked.

1. Ensure feature branch, commit worktree (keep local, never push). Define `<review-base>` as `@{u}` with upstream, else `$(git merge-base HEAD main)`.
2. Run `coderabbit review --agent --base-commit <last reviewed>` (first: `<review-base>`). On failure, notify and suggest checking syntax or repo state.
3. Triage each finding: fix if valid; always ask if the fix increases code complexity or introduces additional dependencies.
4. Summarize findings, then ask fix cost and keep-simple risk, and present `accept fix` vs `keep simple + suppress` with recommendation (default `keep simple` when risk is low).
5. On `keep simple`: ask before adding one concise English `path_instructions` entry with narrow glob. Config applies after merging to main; verify with `@coderabbitai configuration`.
6. Fix accepted findings, run check/lint/format, commit; repeat until `findings: 0`.
7. If `origin/<branch>..HEAD` is non-empty (pushed PR follow-ups exist), stop before reset and wait; never reset pushed commits. Otherwise `git reset --mixed <review-base>` (reset all unpushed commits, keep worktree), notify and wait, then recommit granularly.

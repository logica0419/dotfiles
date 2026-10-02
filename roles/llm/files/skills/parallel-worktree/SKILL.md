---
name: parallel-worktree
description: Open a git worktree in a new VS Code window. Use when starting concurrent agent work or isolating a branch.
---

# Parallel Worktree

Only run when explicitly asked.

1. Check status with `git status --porcelain`. If dirty, run `git stash push --include-untracked`. Confirm clean before proceeding. Never copy untracked files directly.
2. Devise branch(es): explicit task/branch > stashed changes > ask then devise.
3. Add the specified worktree(s) first (`git worktree add ../<repo>-<suffix> -b <branch>`), then copy every `!!` entry from `git status --porcelain --ignored` (e.g. `node_modules/`) into each; skip missing, copy as-is. On failure, report and suggest checking branch name or existing worktrees.
4. Pop stash only in continuing worktree, open each (`code --new-window ../<repo>-<suffix>`). On failure, report and suggest fix.
5. Verify each: `git status --porcelain -uall` clean and top-level entries match source; return to original branch and confirm clean.
6. Report path, branch, and task; user starts agent manually.
7. After merge, run `cleanup-merged-branch`.

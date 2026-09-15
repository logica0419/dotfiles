---
name: parallel-worktree
description: Open a git worktree in a new VS Code window. Use when starting concurrent agent work or isolating a branch.
---

# Parallel Worktree

Open a sibling worktree in a new VS Code window so another agent can work on a different branch. Only run when the user explicitly asks.

1. Check `git status --porcelain`.
2. If dirty, stash (`git stash push --include-untracked`), then devise branch from the working directory.
3. If clean, devise branch from the worktree state; ask only when it cannot be inferred.
4. Create worktree: add (`git worktree add ../<repo>-<suffix> -b <branch>`, pop stash there), copy setup dirs only when present, open (`code --new-window ../<repo>-<suffix>`). On failure, notify and suggest a fix.
5. Return to the main worktree (`cd` back, verify `main` and clean).
6. Report path, branch, and task; user starts agent manually.
7. After merge, run `cleanup-merged-branch`.

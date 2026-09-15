---
name: cleanup-merged-branch
description: Clean up a merged branch or worktree. Use when the user asks to clean up after a PR merge.
---

# Cleanup Merged Branch

Single entry point for post-merge cleanup. `parallel-worktree` delegates here instead of removing worktrees itself.

1. If on `main` or no PR exists for the current branch, stop.
2. If the PR is not merged, report the state and stop.
3. If the current workspace is a linked worktree (`git rev-parse --git-common-dir` differs from `--git-dir`):
   - If dirty, stop and report (do not remove a dirty worktree).
   - Move to the main worktree (`git worktree list --porcelain`); if it is dirty, stop and report; otherwise `git pull`, then `git worktree remove <worktree-path>` and `git branch -d <branch>`.
4. Otherwise (plain branch):
   - Stash if dirty (`git stash push --include-untracked`), `git checkout main` → `git pull` → `git branch -d <branch>`, then `git stash pop` if stashed.

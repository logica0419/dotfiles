---
name: git-commit-and-pr
description: Commit changes and create a PR. Use when the user asks to commit, push, or create a PR.
---

# Git Commit & PR

Only run on explicit request.

1. Merged branch PR → run `cleanup-merged-branch` first.
2. On `main` → create feature branch. Otherwise confirm current branch.
3. One commit per focused change (feature/fix/refactor/move/asset/chore), imperative, no prefix.
4. Match VS Code git behavior: `-s` (`git.alwaysSignOff`), `-S` (`git.enableCommitSigning`, `commit.gpgsign=true`, `gpg.format=ssh`, `user.signingkey`). Stage explicitly; no Smart Commit (`git.enableSmartCommit`).
5. Commit before push; commit-only → stop.
6. Push with a user-provided branch name (`git push -u origin <branch>`); if the branch does not exist or is not up to date with the remote, return an error.
7. PR (only on explicit `create PR` etc.):
   1. Check for existing PR first.
   2. If none exists, check for commits (none → error), then `gh pr create --base main --head <branch> --title ... --body ...` (English).
8. Always `gh pr merge <n> --auto --merge` (never squash), even if PR existed. Conflicts → notify and offer resolutions.

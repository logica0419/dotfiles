---
name: git-commit-and-pr
description: Commit changes and create a PR. Use when the user asks to commit, push, or create a PR.
---

# Git Commit & PR

Only run on explicit request.

1. Merged branch PR → run `cleanup-merged-branch` first.
2. On `main` → devise branch from the changes; ask only when it cannot be inferred. Otherwise confirm current branch.
3. One commit per focused change (feature/fix/refactor/move/asset/chore), imperative, no prefix.
4. Match VS Code git behavior: `-s` (`git.alwaysSignOff`), `-S` (`git.enableCommitSigning`, `commit.gpgsign=true`, `gpg.format=ssh`, `user.signingkey`). Stage explicitly; no Smart Commit (`git.enableSmartCommit`).
5. Commit; stop here without explicit push request.
6. Push only on explicit request (`git push -u origin <branch>`); on failure or invalid branch → error.
7. PR (only on explicit `create PR` etc.):
   1. Check for existing PR first.
   2. If none exists, check for commits (none → error), then `gh pr create --base main --head <branch> --title ... --body ...` (English).
8. Always `gh pr merge <n> --auto --merge` (never squash), even if PR existed. Conflicts → notify and offer resolutions.

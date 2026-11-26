---
name: Comment Style
description: "Write English comments one concise sentence per line, with doc comments on declarations allowed to describe what. Use when writing code comments, commit messages, PR text, or GitHub comments."
---

# Comment Style

## Code comments

- Avoid comments; add one only to explain reason behind behavior as a natural sentence, without labels or prefixes. When such a comment is needed, write it in English.
- Keep one sentence per comment line, and make each sentence short; drop a comment no reader needs.
- Do not repeat what another declaration already documents, and never reference the current task, fix, or callers ("added for X flow", "used by Y").
- A doc comment of a package, type, constant, or function may state what it does as "{name} is/does ...". Any other comment states only why, never what.

## Commit messages and PR text

- When writing commit messages (imperative, no prefix) and PR title/description, use English.
- Keep PR text short, as the people who read it review many PRs; Markdown follows markdown-style.

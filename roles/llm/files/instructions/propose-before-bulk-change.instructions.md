---
name: Propose Before Bulk Change
description: "List candidates and wait for approval before deleting, suppressing, or rewriting in bulk. Use when a sweep would remove code, tests, linter rules, or suppressions the user did not name."
---

# Propose Before Bulk Change

- When a sweep finds things that could go, list each candidate with a one-line reason and wait for a decision; do not delete on your own judgement.
- Say what evidence backs the suspicion — for a linter rule, whether disabling it actually produces a finding.
- Apply only the approved items, so the diff shows the approved change and nothing else.

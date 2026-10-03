---
name: GitHub Actions
description: "Run actionlint, ghalint, and zizmor after editing workflows. Use when editing GitHub Actions workflows, actions, or CI config."
applyTo: ".github/workflows/**, **/action.yaml, **/action.yml"
---

# GitHub Actions

- After any Actions change: `actionlint`, `ghalint run`, `ghalint run-action`, `zizmor .`.

---
name: GitHub Actions
description: "Run jactionlint, ghalint, and zizmor after editing workflows. Use when editing GitHub Actions workflows, actions, or CI config."
applyTo: ".github/workflows/**, **/action.yaml, **/action.yml"
---

# GitHub Actions

- After any Actions change: `jactionlint`, `ghalint run`, `ghalint run-action`, `zizmor .`.

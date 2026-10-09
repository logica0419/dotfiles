---
name: Reuse First
description: "Check for an established library, pattern, or upstream issue before writing new code. Use when adding a dependency, hand-rolling a helper, or picking an approach."
---

# Reuse First

## Before writing new code

- Look for an established library or pattern before writing new code and say whether it is a de-facto standard; check how comparable projects solved the same problem before designing an interface, a CLI surface, or a CI shape.
- Do not add a dependency that only saves a few lines.

## Before reporting upstream

- Search the target project's open and closed issues for the same report before filing, and state the result.
- Treat "this looks like a bug" as unverified until a reproduction or a failing case backs it.

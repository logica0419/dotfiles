---
name: Naming Style
description: "Choose variable and parameter names that carry meaning. Use when naming a loop index, a map binding, a counter, or any short-lived local."
---

# Naming Style

## Index and counter names

- Keep `i` for a position and `k`/`v` for a map binding when the position is all the name says; the conventional short name tells the reader that, and a longer one hides it.
- Name the index after what it indexes once it is a domain value rather than a place: over cluster members it is a `nodeID`, over the log an `entryIndex`, as a map key a `nodeID`. Ask whether the name marks a role in the algorithm or only a spot in the iteration.
- Rename a name that misleads about which of two values it holds, or a parameter whose role changed as it was reused.
- Keep one spelling per concept inside a file or module; when a neighbour already says `nodeID`, a new `id` is the defect.

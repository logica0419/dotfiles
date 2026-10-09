---
name: Naming Style
description: "Choose variable and parameter names that carry meaning. Use when naming a loop index, a map binding, a counter, or any short-lived local."
---

# Naming Style

## Index and counter names

- Keep `i` for a position and `k`/`v` for a map binding when the position is all the name says; the conventional short name tells the reader that, and a longer one hides it.
- Name the index after the value it walks once that is a domain value rather than a place: `nodeID` over cluster members, `entryIndex` over log lines, `nodeID` as a map key.
- Rename anything that misleads about which of two values it holds, or a parameter whose role changed as it was reused.
- Keep one spelling per concept inside a file or module; when a neighbour already says `nodeID`, a new `id` is the defect.

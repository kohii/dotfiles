---
name: code-extraction-refactoring
description: Best practices for refactoring involving code extraction
---

1. When extracting modules, try to move code first (not writing new code), and then refactor.
  - This approach helps prevent accidental code loss.
  - If a move is difficult, consider refactoring the code to make it easier to move before actually moving it.
2. After refactoring, look for glue code or awkward code to improve.
  - Prioritize ideal code structure over backward compatibility or minimizing code changes.
  - Ask yourself: "How would I write this if starting from scratch?"
3. Commit the changes after each step.

This is not a strict rule. Use this approach only if it fits the situation.

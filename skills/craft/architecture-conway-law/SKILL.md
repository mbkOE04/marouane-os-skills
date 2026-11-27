---
name: architecture-conway-law
description: Conway's Law and the inverse Conway manoeuvre. Use when system boundaries and team structure need to line up.
---
# Conway's Law
## When to use
Designing service boundaries, splitting a monolith, reorganising teams, diagnosing slow cross-team delivery.
## Principles
- A system's design mirrors the communication structure of the organisation that builds it (Melvin Conway, 1968).
- To get a target architecture, shape teams around it first.
- Boundaries that cut across team ownership create coordination cost.
## Checklist
- Map each component to one owning team.
- List changes that need 3+ teams; those are the boundary smells.
- Check interfaces are explicit contracts, not shared databases.
## Questions
Who owns this? Which team must be asked before it can change?
## Sources
- https://melconway.com/Home/Conways%5FLaw.html

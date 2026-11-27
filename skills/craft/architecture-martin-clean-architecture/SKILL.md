---
name: architecture-martin-clean-architecture
description: Robert C. Martin's Clean Architecture dependency rule. Use for layering and keeping business logic independent of frameworks.
---
# Clean Architecture
## When to use
Structuring a service; isolating business rules from UI, DB and vendors.
## Principles
- Dependencies point inward, toward business rules.
- Entities and use cases know nothing of frameworks, DB or web.
- Cross boundaries with interfaces and simple data structures.
- Frameworks are details; defer decisions.
## Checklist
- Can the core be tested without DB or network?
- Do any inner modules import outer ones?
- Are vendor SDKs behind an adapter?
## Questions
What would change if we swapped the database or provider?
## Sources
- https://www.informit.com/articles/article.aspx?p=2832399

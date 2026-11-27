---
name: architecture-newman-microservices
description: Sam Newman's microservices guidance. Use when deciding whether and how to split a system into services.
---
# Building Microservices (Newman)
## When to use
Evaluating a monolith split; defining service boundaries; reviewing inter-service coupling.
## Principles
- Independent deployability is the core property.
- Boundaries follow business capability and bounded context.
- Information hiding; avoid shared databases.
- Do not start with microservices without a reason; migrate incrementally.
- Invest in observability and automation first.
## Checklist
- Can this service deploy alone?
- Does it own its data?
- What is the failure behaviour when a dependency is down?
## Questions
What problem does the split solve that a module boundary would not?
## Sources
- https://samnewman.io/books/building_microservices/

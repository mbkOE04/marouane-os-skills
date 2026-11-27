---
name: engineering-pragmatic-programmer
description: David Thomas and Andrew Hunt's Pragmatic Programmer habits. Use for everyday engineering judgment - DRY as knowledge duplication, orthogonality, tracer bullets over big up-front builds, prototypes, entropy and broken windows, automation.
---

# The Pragmatic Programmer (Thomas & Hunt)

Sources: "The Pragmatic Programmer" (Thomas & Hunt, 20th anniversary ed. 2019). DRY excerpt: https://media.pragprog.com/titles/tpp20/dry.pdf; Tracer bullets: https://www.artima.com/articles/tracer-bullets-and-prototypes

## When to use
- Duplication is spreading across code, docs or configuration.
- A change ripples through unrelated modules (orthogonality broken).
- A project needs end-to-end feedback fast (tracer bullet) vs speculative scaffolding.
- Small neglects are accumulating ("broken windows").

## Core principles
- DRY: every piece of knowledge has a single, unambiguous, authoritative representation. It is about knowledge, not about avoiding similar-looking text.
- Orthogonality: components are independent; a change in one does not propagate to others. Eliminate effects between unrelated things.
- Tracer bullets: build a thin end-to-end slice through every layer early to prove the architecture and give users something to react to; prototypes are disposable learning, tracers are kept.
- Broken windows: do not leave "temporary" hacks, dead code or failing tests; entropy spreads.
- Good enough software: know when to stop polishing; involve users in the trade-off.
- Automate everything repeatable: builds, tests, releases, docs generation.
- Care about your craft: take responsibility, keep learning, criticize code not people.

## Checklist
- [ ] Each fact/rule exists in exactly one place.
- [ ] Modules can be changed without touching unrelated ones.
- [ ] There is a thin end-to-end path running before any layer is "finished".
- [ ] No broken windows left in touched code.
- [ ] Repetitive manual steps are scripted.
- [ ] Estimates include the phrase "it depends" and state assumptions.

## Questions to ask
- If this rule changes, how many places must change?
- Does this change force unrelated code to change?
- What is the thinnest slice that reaches production?

## Sources
- DRY chapter excerpt: https://media.pragprog.com/titles/tpp20/dry.pdf
- Orthogonality chapter: https://www.oreilly.com/library/view/hunt-the-pragmatic-programmer/020161622X/ch02.html
- Tracer bullets: https://www.artima.com/articles/tracer-bullets-and-prototypes

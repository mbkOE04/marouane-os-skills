---
name: engineering-fowler-refactoring
description: Martin Fowler's refactoring discipline. Use when improving existing code without changing its behavior - small behavior-preserving steps, test coverage first, opportunistic cleanup while doing feature work, and recognizing code smells.
---

# Refactoring (Martin Fowler)

Sources: "Refactoring: Improving the Design of Existing Code" (Fowler, 2nd ed. 2018); martinfowler.com refactoring tag: https://martinfowler.com/tags/refactoring.html; Opportunistic Refactoring: https://www.martinfowler.com/bliki/OpportunisticRefactoring.html

## When to use
- Code works but is hard to read, change or test.
- Adding a feature requires touching tangled code - refactor first to make the change easy, then make the easy change.
- Reviewing a diff that mixes behavior change and restructuring (separate them).

## Core principles
- Refactoring = a small behavior-preserving transformation. Never mix refactoring with behavior change in the same step.
- The test suite is the safety net: no refactoring without tests you trust.
- Two hats: when adding function you do not refactor; when refactoring you do not add function. Swap hats deliberately.
- Opportunistic refactoring: leave every place you touch a little better, in service of the current task.
- Code smells are signals, not verdicts: duplicated code, long method, large class, feature envy, data clumps, shotgun surgery, primitive obsession.

## Checklist
- [ ] Tests pass before, between and after each micro-step.
- [ ] Each step is small enough to be obviously safe (rename, extract, inline, move).
- [ ] Behavior changes and refactorings are in separate commits.
- [ ] The current task's code path got cleaner, not the whole file "fixed" in one pass.
- [ ] Smells addressed with the named counter-refactoring (extract method, move method, replace conditional with polymorphism...).

## Questions to ask
- What smell is actually blocking this change?
- What is the smallest step that improves it without changing behavior?
- If we broke something, which test would fail?

## Sources
- https://martinfowler.com/tags/refactoring.html
- https://www.martinfowler.com/bliki/OpportunisticRefactoring.html
- https://refactoring.com (catalog, by Fowler)

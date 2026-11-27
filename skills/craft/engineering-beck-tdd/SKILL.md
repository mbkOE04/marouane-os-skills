---
name: engineering-beck-tdd
description: Kent Beck's Test-Driven Development. Use when building or changing logic and want design feedback plus a regression net - red/green/refactor cycle, small steps, and letting tests drive the API shape.
---

# Test-Driven Development (Kent Beck)

Source: Kent Beck, "Test Driven Development: By Example" (2002): https://www.pearson.com/en-us/subject-catalog/b/test-driven-development-by-example/P200000009421/9780321146533

## When to use
- Writing new logic where correctness matters and requirements are understood well enough to state examples.
- A bug report: reproduce it as a failing test first.
- A design that is hard to test - the difficulty is design feedback, treat it as a signal.

## Core principles
- Red / Green / Refactor: write one failing test; make it pass the simplest way possible (fake it, then triangulate); clean up with tests green.
- Tests drive design: the test is the first client of the API. Awkward test setup means an awkward interface.
- Small steps: the goal is working code with a clean design, reached in minutes-long cycles, not a big-bang implementation.
- Keep a to-do list: every test idea, smell and refactor goes on the list; pick one at a time.
- Obvious implementation vs faking vs triangulation: choose the step size that keeps you moving.

## Checklist
- [ ] Next behavior is expressed as one concrete failing test.
- [ ] The failing message is the one you expected.
- [ ] Passed with the simplest code that could work.
- [ ] Duplication removed only after green.
- [ ] To-do list updated; one item in play at a time.
- [ ] No test asserts implementation details that make refactoring expensive.

## Questions to ask
- What is the smallest example of the next behavior?
- Which test would teach us something we do not already know?
- Is this test hard to write because the design is wrong?

## Sources
- Book: https://www.pearson.com/en-us/subject-catalog/b/test-driven-development-by-example/P200000009421/9780321146533
- Beck's XP values (feedback, simplicity, courage, communication): "Extreme Programming Explained" https://www.informit.com/articles/article.aspx?p=367636

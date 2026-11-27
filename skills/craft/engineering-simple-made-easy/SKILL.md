---
name: engineering-simple-made-easy
description: Rich Hickey's simplicity discipline. Use when a design, codebase or system is getting hard to change and the cause is entanglement rather than inherent difficulty - choosing data over objects, untangling concerns, and spotting "easy" choices that create long-term complexity.
---

# Simple Made Easy (Rich Hickey)

Source: Rich Hickey, "Simple Made Easy", Strange Loop 2011. Transcript: https://github.com/matthiasn/talk-transcripts/blob/master/Hickey_Rich/SimpleMadeEasy-mostly-text.md

## When to use
- A system is becoming harder to change as it grows.
- A design decision trades short-term convenience against long-term entanglement.
- Reviewing architecture, APIs, state management, or a framework choice.

## Core principles
- Simple means "one fold" - not interleaved. Complex means braided together ("complected"). Simplicity is objective; ease is relative and familiar.
- Easy is not simple. Familiar constructs (objects with intertwined state and behavior, conditionals everywhere, shared mutable state) are easy but complect.
- Complecting anything with anything is the source of most software difficulty: state complects value and time; objects complect state, identity and value; inheritance complects types.
- Choose constructs that are simple in what they produce: values, pure functions, data, declarative rules, queues, interfaces-as-sets-of-functions.
- Abstraction means separating WHAT from HOW/WHO/WHEN/WHERE: draw things apart by specifying the what, not the mechanism.
- Complexity is environmental too: anything your construct entangles itself with (calling convention, resource management, ordering) becomes your problem.

## Checklist
- [ ] Name what this design complects (state+time, type+behavior, what+how).
- [ ] Can any component be replaced by data or a pure function?
- [ ] Is state isolated, explicit and minimized?
- [ ] Are interfaces sets of functions over values, not stateful objects?
- [ ] Does the choice optimize for change-ability, not just familiarity?
- [ ] Are ordering, resources and calling conventions kept out of the constructs?

## Questions to ask
- What is being braided together here, and what would it take to pull the strands apart?
- Are we choosing this because it is simple, or because it is familiar and near at hand?
- If this doubles in size, what breaks first?

## Sources
- Talk transcript: https://github.com/matthiasn/talk-transcripts/blob/master/Hickey_Rich/SimpleMadeEasy-mostly-text.md
- Companion talk "The Value of Values": https://github.com/matthiasn/talk-transcripts

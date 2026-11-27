---
name: architecture-hohpe-integration-patterns
description: Hohpe and Woolf's Enterprise Integration Patterns. Use when designing messaging, queues and system-to-system integration.
---
# Enterprise Integration Patterns
## When to use
Connecting systems by messaging; designing retries, routing and transformation.
## Principles
- Asynchronous messaging decouples systems in time and availability.
- Named patterns: Message Channel, Router, Translator, Idempotent Receiver, Dead Letter Channel, Correlation Identifier.
- Design for duplicates, out-of-order and failure.
## Checklist
- Is each consumer idempotent?
- Is there a dead-letter path and alerting?
- Are messages traceable by correlation ID?
## Questions
What happens if this message arrives twice, late or never?
## Sources
- https://www.enterpriseintegrationpatterns.com/

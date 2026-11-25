# marouane-os-skills

A small, vetted set of 51 public Claude skills, with a pull-only installer. This repo holds no skill
content of its own: `manifest.tsv` says where each skill lives upstream, and `setup.sh` fetches it
from there at a pinned commit.

## Install (one command per session)

```sh
git clone --depth 1 https://github.com/mbkOE04/marouane-os-skills && sh marouane-os-skills/setup.sh
```

Skills land in `~/.claude/skills/<install-name>`. A session reads its skills at start, so they are
available from the next session start onward, or straight away if run from a session-start hook or an
environment setup script.

## The groups

| Group | Count | Upstream | Installed as |
|---|---|---|---|
| Design and comms | 4 | `anthropics/skills` | upstream name, copied whole |
| Marketing | 12 | `coreyhaines31/marketingskills` | upstream name, text files only |
| Go-to-market | 12 | `LeadMagic/gtm-skills` | `gtm-` prefix, text files only |
| Legal (Claude for Legal) | 8 | `anthropics/claude-for-legal` | `cfl-` prefix, copied whole |
| Legal (knowledge work) | 6 | `anthropics/knowledge-work-plugins` | `legal-` prefix, copied whole |
| Finance and tax | 4 | `poorvith-mp/skills-finance` | `fin-` prefix, text files only |
| Teaching (K-12) | 4 | `anthropics/k12-teacher-skills` | upstream name, copied whole |
| Teaching (England) | 1 | `seanmcww/uk-lesson-planning` | upstream name, text and data only |

- **Design and comms:** frontend-design, canvas-design, theme-factory, internal-comms.
- **Marketing:** copywriting, copy-editing, content-strategy, marketing-psychology, marketing-ideas,
  launch, pricing, product-marketing, competitors, customer-research, public-relations, cro.
- **Go-to-market:** gtm-brand-kit, gtm-founder-brand, gtm-positioning-messaging, gtm-podcast-gtm,
  gtm-ai-content-creation, gtm-ai-video-creation, gtm-social-media-strategy, gtm-linkedin-algorithm,
  gtm-content-distribution, gtm-objection-handling, gtm-pitch-deck-builder, gtm-graphic-design
  (upstream folder: `graphic-design-gtm`).
- **Legal (Claude for Legal):** cfl-contract-review, cfl-nda-review, cfl-entity-compliance,
  cfl-privacy-triage (upstream: `use-case-triage`), cfl-dpa-review, cfl-trademark-clearance
  (upstream: `clearance`), cfl-ip-clause-review, cfl-oss-review. These expect a practice profile
  (`CLAUDE.md`) and will ask for setup on first use. Every output is a draft for professional
  review, never legal advice.
- **Legal (knowledge work):** legal-review-contract, legal-triage-nda, legal-compliance-check,
  legal-risk-assessment, legal-vendor-check, legal-brief. legal-vendor-check and legal-brief are
  built for connected systems (CLM, CRM, email); without connectors they ask for the documents
  instead.
- **Finance and tax:** fin-tax-strategy, fin-cap-table, fin-runway-planning, fin-financial-modeling.
  US-flavoured (Delaware, QSBS, IRC); treat UK tax output as questions to take to an accountant,
  not answers.
- **Teaching (K-12):** k12-lesson-plan-creation, k12-lesson-differentiation, k12-lesson-prep,
  k12-check-for-understanding. Co-developed by Anthropic and Learning Commons.
- **Teaching (England):** uk-lesson-planning. England National Curriculum lessons grounded in the
  DfE content store. Its bundled curriculum corpus (Open Government Licence v3.0) is installed;
  its retrieval scripts are not (pull-only rule), so live grounding is degraded to the shipped
  references until a reviewed exception is made.

### Reviewed and held back

- `simonsxxs/cognitive-psychology-mentor`: no licence file, and the skill content is mainly
  Chinese. Kept as reference material only, not installed.
- Therapy-style CBT/DBT toolkits: excluded on safeguarding grounds for an education programme.
- `easedup/educator-skills`: licence unverified; revisit if wanted.

### Optional candidates (not installed)

Reviewed and judged useful, but left out of the approved set. To add one, append a line to
`manifest.tsv`.

| Skill | Upstream | Path |
|---|---|---|
| doc-coauthoring | anthropics/skills | `skills/doc-coauthoring` |
| offers | coreyhaines31/marketingskills | `skills/offers` |
| gtm-buyer-psychology | LeadMagic/gtm-skills | `skills/foundation/buyer-psychology` |
| gtm-competitive-intel | LeadMagic/gtm-skills | `skills/foundation/competitive-intel` |
| gtm-landing-page-copy | LeadMagic/gtm-skills | `skills/creative/landing-page-copy` |
| gtm-seo-strategy | LeadMagic/gtm-skills | `skills/content-seo/seo-strategy` |
| gtm-aeo-strategy | LeadMagic/gtm-skills | `skills/content-seo/aeo-strategy` |

## What setup.sh does

- Reads `manifest.tsv`: `install-name <TAB> upstream repo URL <TAB> path in that repo`, one skill per
  line, no header. A URL of `BUNDLE-ONLY` means "no public upstream"; such a line is reported and
  not downloaded.
- Downloads each upstream once, at the commit pinned at the top of `setup.sh` (tarball, or a `git
  fetch` of that exact commit where the tarball host is blocked).
- Official Anthropic repos are installed whole (their skills load sibling reference files). For the
  other third-party repos it keeps text files only: no `scripts/` folders, no code files, no eval
  fixtures. For prefixed installs (`gtm-`, `cfl-`, `legal-`, `fin-`) it rewrites the `name:` line in
  `SKILL.md` to match the prefix.
- Writes only inside `~/.claude/skills`, uses no secrets, and runs nothing it downloads.
- On a failure it prints a loud warning, skips that skill, carries on, and exits with code 2.

## Pinned commits (reviewed 24-25 November 2026)

| Upstream | Commit |
|---|---|
| anthropics/skills | `e4bb5d960d87126ff3b3a8af1a104b7db67560ba` |
| coreyhaines31/marketingskills | `8fd2fcade2fd6629026e9dfe6d133b55b36968b9` |
| LeadMagic/gtm-skills | `2b7ec0f9e7044f46e4c77b536f486303fd863e28` |
| anthropics/claude-for-legal | `4a6c651889c97cc9140580363c73e0eb17379c2b` |
| anthropics/knowledge-work-plugins | `5e504ae11498f2b8daa30d86b7dab97b2ecd8092` |
| poorvith-mp/skills-finance | `9e9b1cb547c5671594c15dd5f6c50d9e8069d711` |
| anthropics/k12-teacher-skills | `31fd6dbb0c07cb50bb3ce7f62a4135a393bd0e8c` |
| seanmcww/uk-lesson-planning | `31a05832128f3a9f3c827dbb7799e5349bd485ab` |

To add or drop a skill, edit `manifest.tsv`. To move a pin, re-read that upstream first, then change
the commit in `setup.sh`. The skills remain the work of their upstream authors under their own
licences; check those before redistributing any skill content.

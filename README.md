# marouane-os-skills

A small, vetted set of 28 public Claude skills, with a pull-only installer. This repo holds no skill
content of its own: `manifest.tsv` says where each skill lives upstream, and `setup.sh` fetches it
from there at a pinned commit.

## Install (one command per session)

```sh
git clone --depth 1 https://github.com/mbkOE04/marouane-os-skills && sh marouane-os-skills/setup.sh
```

Skills land in `~/.claude/skills/<install-name>`. A session reads its skills at start, so they are
available from the next session start onward, or straight away if run from a session-start hook or an
environment setup script.

## The three groups

| Group | Count | Upstream | Installed as |
|---|---|---|---|
| Design and comms | 4 | `anthropics/skills` | upstream name, copied whole |
| Marketing | 12 | `coreyhaines31/marketingskills` | upstream name, text files only |
| Go-to-market | 12 | `LeadMagic/gtm-skills` | `gtm-` prefix, text files only |

- **Design and comms:** frontend-design, canvas-design, theme-factory, internal-comms.
- **Marketing:** copywriting, copy-editing, content-strategy, marketing-psychology, marketing-ideas,
  launch, pricing, product-marketing, competitors, customer-research, public-relations, cro.
- **Go-to-market:** gtm-brand-kit, gtm-founder-brand, gtm-positioning-messaging, gtm-podcast-gtm,
  gtm-ai-content-creation, gtm-ai-video-creation, gtm-social-media-strategy, gtm-linkedin-algorithm,
  gtm-content-distribution, gtm-objection-handling, gtm-pitch-deck-builder, gtm-graphic-design
  (upstream folder: `graphic-design-gtm`).

### Optional candidates (not installed)

Reviewed and judged useful, but left out of the approved 28. To add one, append a line to
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
- For the two third-party repos it keeps text files only: no `scripts/` folders, no code files, no
  eval fixtures. For `gtm-` skills it rewrites the `name:` line in `SKILL.md` to match the prefix.
- Writes only inside `~/.claude/skills`, uses no secrets, and runs nothing it downloads.
- On a failure it prints a loud warning, skips that skill, carries on, and exits with code 2.

## Pinned commits (reviewed 24 November 2026)

| Upstream | Commit |
|---|---|
| anthropics/skills | `e4bb5d960d87126ff3b3a8af1a104b7db67560ba` |
| coreyhaines31/marketingskills | `8fd2fcade2fd6629026e9dfe6d133b55b36968b9` |
| LeadMagic/gtm-skills | `2b7ec0f9e7044f46e4c77b536f486303fd863e28` |

To add or drop a skill, edit `manifest.tsv`. To move a pin, re-read that upstream first, then change
the commit in `setup.sh`. The skills remain the work of their upstream authors under their own
licences; check those before redistributing any skill content.

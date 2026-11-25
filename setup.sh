#!/bin/sh
# marouane-os-skills: pull-only installer.
# Reads manifest.tsv (install-name <TAB> upstream repo URL <TAB> path in that repo) from the folder this script is in,
# downloads each upstream once PINNED to the commit below (tarball, or a git fetch of that exact commit if the tarball host is blocked), and copies each skill folder to
# ~/.claude/skills/<install-name>. It writes nowhere else, needs no secrets, and runs nothing it downloads.
# A skill that fails is skipped with a loud warning; the rest continue.
set -u

# Upstream commits these skills were reviewed at (24-25 November 2026). Change a pin only after re-reading that repo.
pin_for() {
  case "$1" in
    https://github.com/anthropics/skills)                 echo e4bb5d960d87126ff3b3a8af1a104b7db67560ba ;;
    https://github.com/coreyhaines31/marketingskills)     echo 8fd2fcade2fd6629026e9dfe6d133b55b36968b9 ;;
    https://github.com/LeadMagic/gtm-skills)              echo 2b7ec0f9e7044f46e4c77b536f486303fd863e28 ;;
    https://github.com/anthropics/claude-for-legal)       echo 4a6c651889c97cc9140580363c73e0eb17379c2b ;;
    https://github.com/anthropics/knowledge-work-plugins) echo 5e504ae11498f2b8daa30d86b7dab97b2ecd8092 ;;
    https://github.com/poorvith-mp/skills-finance)        echo 9e9b1cb547c5671594c15dd5f6c50d9e8069d711 ;;
    https://github.com/anthropics/k12-teacher-skills)     echo 31fd6dbb0c07cb50bb3ce7f62a4135a393bd0e8c ;;
    https://github.com/seanmcww/uk-lesson-planning)       echo 31a05832128f3a9f3c827dbb7799e5349bd485ab ;;
    https://github.com/bgolubovski/exec-recruiter)      echo db3e3a7fa50873fa3304a158ec84299398e946b9 ;;
    https://github.com/dbhat93/job-search-os)           echo 412d99360396143316ad949a290078cd4a7b6f57 ;;
    https://github.com/Frederic-Klingen-Personalberatung/Recruiting-Skills-for-AI-Agents) echo 86f9ebd393b1d5482ea2e56be15777b86feff13a ;;
    https://github.com/workinsiders/claude-skills)      echo 79ac683946673b25df14e1a71137c5b0a82c1ee3 ;;
    *) echo "" ;;
  esac
}

HERE=$(cd "$(dirname "$0")" && pwd)
MANIFEST="$HERE/manifest.tsv"
DEST="${HOME:?HOME is not set}/.claude/skills"
[ -f "$MANIFEST" ] || { echo "ERROR: manifest.tsv not found next to setup.sh" >&2; exit 1; }
mkdir -p "$DEST" || exit 1
TMP="$DEST/.marouane-os-skills-tmp.$$"          # scratch space stays inside ~/.claude/skills
mkdir -p "$TMP" || exit 1
cleanup() { case "$TMP" in "$DEST"/.marouane-os-skills-tmp.*) rm -rf "$TMP" ;; esac; }
trap cleanup EXIT INT TERM

fetch() {                                         # fetch URL FILE
  if command -v curl >/dev/null 2>&1; then curl -fsSL --retry 2 -o "$2" "$1"
  elif command -v wget >/dev/null 2>&1; then wget -q -O "$2" "$1"
  else echo "ERROR: neither curl nor wget is available" >&2; return 1; fi
}
warn() { echo "!!! WARNING: SKIPPED $1 -- $2" >&2; failed=$((failed + 1)); failed_names="$failed_names $1"; }

ok=0; failed=0; bundle=0; failed_names=""
TAB=$(printf '\t')
while IFS="$TAB" read -r name url path || [ -n "${name:-}" ]; do
  case "${name:-}" in ''|'#'*) continue ;; esac
  case "$name" in */*|.*) warn "$name" "unsafe install name"; continue ;; esac
  if [ "$url" = "BUNDLE-ONLY" ]; then echo "--- $name: BUNDLE-ONLY (no public upstream; not downloaded)"; bundle=$((bundle + 1)); continue; fi
  case "$path" in /*|*..*) warn "$name" "unsafe path '$path'"; continue ;; esac
  pin=$(pin_for "$url")
  [ -n "$pin" ] || { warn "$name" "no pinned commit for $url"; continue; }
  slug=${url#https://github.com/}
  key=$(printf '%s' "$slug" | tr '/' '_')
  root="$TMP/$key"
  if [ ! -d "$root" ] && [ ! -f "$TMP/$key.failed" ]; then
    mkdir -p "$root"
    if fetch "https://codeload.github.com/$slug/tar.gz/$pin" "$TMP/$key.tgz" 2>/dev/null && tar -xzf "$TMP/$key.tgz" -C "$root" --strip-components=1 2>/dev/null; then :
    elif command -v git >/dev/null 2>&1 && git init -q "$root" 2>/dev/null && git -C "$root" fetch -q --depth 1 "$url" "$pin" 2>/dev/null && git -C "$root" checkout -q FETCH_HEAD 2>/dev/null; then :   # some networks block the tarball host
    else rm -rf "$root"; : > "$TMP/$key.failed"; fi
  fi
  [ -d "$root" ] || { warn "$name" "could not download $slug at $pin"; continue; }
  src="$root/$path"
  case "$url" in
    https://github.com/bgolubovski/exec-recruiter) ;;   # plugin repo: no root SKILL.md; installed whole by design
    *) [ -f "$src/SKILL.md" ] || { warn "$name" "no SKILL.md at $path in $slug"; continue; } ;;
  esac
  new="$TMP/new-$name"
  cp -R "$src" "$new" || { warn "$name" "copy failed"; continue; }
  case "$url" in
    https://github.com/anthropics/skills|https://github.com/anthropics/claude-for-legal|https://github.com/anthropics/knowledge-work-plugins|https://github.com/anthropics/k12-teacher-skills) ;;  # official Anthropic skills are installed whole
    https://github.com/bgolubovski/exec-recruiter) ;;   # plugin: keep config/agents/templates + the two audited local scripts (read line by line 2026-11-25: no network, no exfil)
    *)                                            # third-party: text files only (no scripts, no eval fixtures)
      rm -rf "$new/scripts" "$new/evals"
      find "$new" -type f \( -name '*.py' -o -name '*.js' -o -name '*.mjs' -o -name '*.ts' -o -name '*.sh' -o -name 'evals.json' \) -exec rm -f {} + ;;
  esac
  case "$name" in
    gtm-*|cfl-*|legal-*|fin-*)                    # installed under a prefix: make the skill's own name match
      sed "s/^name:[[:space:]].*\$/name: $name/" "$new/SKILL.md" > "$new/SKILL.md.tmp" && mv "$new/SKILL.md.tmp" "$new/SKILL.md" ;;
  esac
  rm -rf "$DEST/$name" && mv "$new" "$DEST/$name" || { warn "$name" "could not write $DEST/$name"; continue; }
  echo "ok  $name"
  ok=$((ok + 1))
done < "$MANIFEST"

echo
echo "Summary: $ok installed, $failed skipped, $bundle bundle-only. Destination: $DEST"
[ "$failed" -eq 0 ] || { echo "Skipped:$failed_names" >&2; exit 2; }

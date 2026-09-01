---
name: dotfiles-sync
description: Review, commit, and push changes in Tyler's bare-repo dotfiles. Handles both the personal repo (github.com/tylereades/dotfiles) and the work repo (gitlab.zgtools.net/tylerea/dotfiles-work). Use when Tyler asks to sync/commit/push his dotfiles, or to start tracking a new config file/app in either repo.
---

# Dotfiles sync

Tyler has **two** bare-repo dotfiles, both with work-tree `$HOME`:

| Repo | git-dir | Remote | Contains |
|------|---------|--------|----------|
| Personal | `~/.dotfiles/` | `github.com/tylereades/dotfiles` | shell, nvim, starship, wezterm, Brewfile, gitconfig |
| Work | `~/.dotfiles-work/` | `gitlab.zgtools.net/tylerea/dotfiles-work` | AWS config, Databricks, SSH, Claude Code (CLAUDE.md, settings, context, rules, skills), Brewfile.work, setup script |

Commands for each (no persistent alias — spell it out every time):

```bash
# Personal
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME <command>

# Work
git --git-dir=$HOME/.dotfiles-work/ --work-tree=$HOME <command>
```

When Tyler says "sync dotfiles" without specifying which, sync **both** — personal first, then work.

`status.showUntrackedFiles = no` is set on both repos. **Never run `add -A` or `add -u`** — always add explicit paths. This keeps secrets, caches, and unrelated home-dir files out of both repos.

## Workflow A: sync pending changes

Run this for each repo (personal, then work). Steps are identical for both — just swap the git-dir.

1. **Fetch and check for remote-only commits first** — the repo is shared
   between Tyler's personal and work laptops, so the other machine may have
   pushed since this machine last pulled.

   ```bash
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch origin
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME rev-list --left-right --count HEAD...FETCH_HEAD
   # repeat for .dotfiles-work/
   ```

   There's no `refs/remotes/origin/main` configured (only a fetch spec), so
   compare against `FETCH_HEAD`, not `origin/main`. If the right-hand count is
   nonzero, merge before adding local changes.

2. **Show what's changed**:

   ```bash
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME diff -- <changed files>
   ```

   Summarize each changed file's diff in a sentence or two. For noisy generated
   files (e.g. `.config/nvim/lazy-lock.json`), a `--stat` summary is enough.

3. **Stage only what's intended** and commit with a short direct message
   (Tyler's style: "add oil.lua", "lazyvim updates", "update Brewfile").

4. **Push both repos**:

   ```bash
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push origin main
   git --git-dir=$HOME/.dotfiles-work/ --work-tree=$HOME push origin main
   ```

## Which repo does a new file belong in?

| Goes in **personal** (GitHub) | Goes in **work** (GitLab) |
|-------------------------------|---------------------------|
| Shell config (zshrc, aliases, path) | `.zprofile-work`, `zillow.zsh` |
| Editor (nvim, starship, wezterm) | `.aws/config`, `.databrickscfg` |
| Brewfile (shared tools) | `Brewfile.work` |
| `.gitconfig`, `.zshenv` | `.ssh/config` |
| Personal Claude skills | `.claude/CLAUDE.md`, `settings.json` |
| `~/.claude/context/dotfiles.md`, `glove80.md` | `.claude/context/` (Voyager, Databricks, etc.) |
| | `.claude/rules/`, work Claude skills |

When in doubt: would this file contain Zillow-specific config, credentials, or internal tooling? → work repo. Generic dev tooling? → personal repo.

## Workflow B: track a new file or folder for the first time

Use this when a new app or tool has config worth version-controlling (e.g.
adding a new CLI tool's config, or a GUI app's settings file like Handy's).

1. **Find the real file(s)** — most app config lives under one of:
   - `~/.config/<app>/...` (most CLI/Linux-style tools)
   - `~/Library/Application Support/<app>/...` (macOS GUI apps)
   - `~/Library/Preferences/<bundle-id>.plist` (macOS GUI apps, plist prefs)
   - directly in `$HOME` (dotfiles proper, e.g. `~/.zshrc`)

2. **Inspect the file(s) before adding anything**:
   - Read the file. Flag anything that looks like an API key, token, or
     credential (e.g. Handy's `settings_store.json` has a
     `post_process_api_keys` block — currently empty, but would hold secrets
     if filled in). Don't silently commit a file with a live secret in it —
     tell Tyler and let him decide (strip it, gitignore it, or accept the
     repo is private enough).
   - **Only add specific files, never a whole directory**, even if the config
     lives in a directory. Directories like an app's `Application Support`
     folder often also contain unrelated data — history databases, cached
     media, downloaded models, recordings/logs. Check what's actually a
     config file (small, human-relevant, edited by the user or the app's
     settings UI) versus generated/personal data (large binaries, `.db`
     files, media) before adding.

4. **Add, commit, push**:

   ```
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add "<exact relative path from $HOME>"
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status   # confirm ONLY the intended file(s) are staged
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m "track <app> config"
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push origin main
   ```

   Always check `status` after staging and before committing — this is the
   check that catches an accidental extra file getting swept in.

5. **Decide whether this app needs a context file.** `~/.claude/CLAUDE.md` is
   a progressive-disclosure index — one-line pointers to detail files in
   `~/.claude/context/*.md`. Add a new `context/<app>.md` (plus a one-line
   pointer in `CLAUDE.md`) only when there's non-obvious detail worth
   preserving: secrets/keys to watch out for, quirks about where the config
   lives or how the app writes it, non-default settings worth remembering, or
   anything a future session would otherwise have to re-derive by reading the
   file cold. Skip it when the commit message already says everything that
   matters (e.g. a one-line CLI config with nothing surprising in it) —
   don't create a context file just because a file got tracked.

## Git identity

Should already be set globally (`user.name = Tyler Eades`,
`user.email = tyler.eades@yahoo.com`). If a commit ever shows an
auto-generated author like `tyler@<hostname>.local`, global identity isn't
configured on that machine — set it (with Tyler's confirmation) rather than
leaving wrong authorship in history. An unpushed commit's author can be
corrected with `commit --amend --reset-author --no-edit`; never rewrite an
already-pushed commit's history without Tyler explicitly asking for it.

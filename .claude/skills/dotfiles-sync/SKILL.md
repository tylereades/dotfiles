---
name: dotfiles-sync
description: Review, commit, and push changes in Tyler's bare-repo dotfiles (~/.dotfiles git-dir, $HOME work-tree, github.com/tylereades/dotfiles), or add a new file/folder to tracking for the first time. Use when Tyler asks to sync/commit/push his dotfiles, or to start tracking a new config file/app.
---

# Dotfiles sync

Tyler's dotfiles repo is a **bare repo**: git-dir `~/.dotfiles`, work-tree
`$HOME`. There is no checked-out clone anywhere else — tracked files live at
their real paths under `$HOME` (`.zshrc`, `.config/nvim/...`, even
`Library/Application Support/<app>/...`).

Every git command in this skill uses this exact form (no persistent shell
alias — it doesn't survive across tool calls):

```
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME <command>
```

`status.showUntrackedFiles = no` is set deliberately so random files in
`$HOME` never show up in `status`/`diff`. **Never run `add -A` or `add -u` on
this repo** — always `add` explicit paths. This is the main safety rail that
keeps secrets/caches/personal data (recordings, history DBs, API keys in app
config files) out of a public-ish repo, so don't work around it.

## Workflow A: sync pending changes

1. **Fetch and check for remote-only commits first** — this repo is shared
   between Tyler's personal and work laptops, so the other machine may have
   pushed since this machine last pulled.

   ```
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME fetch origin
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME rev-list --left-right --count HEAD...FETCH_HEAD
   ```

   There's no `refs/remotes/origin/main` configured (only a fetch spec), so
   compare against `FETCH_HEAD`, not `origin/main`. If the right-hand count is
   nonzero, origin has commits this machine doesn't — merge those in
   (`git ... merge FETCH_HEAD`) before adding new local changes, so you don't
   commit on top of stale state.

2. **Show what's changed**:

   ```
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME diff -- <changed files>
   ```

   Summarize each changed file's diff for Tyler in a sentence or two — don't
   just dump raw diffs unasked. For noisy generated files (lockfiles like
   `.config/nvim/lazy-lock.json`), a `--stat` summary is enough.

3. **Stage only what's intended.** If the changes are unrelated to each other
   (e.g. a shell tweak + an unrelated Brewfile addition), it's fine to bundle
   them in one commit if that matches Tyler's existing style (check recent
   `log --oneline` — his messages are short and direct, e.g. "add oil.lua",
   "lazyvim updates"), or split them if he asks for that.

4. **Commit and push**:

   ```
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m "<short, direct message>"
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push origin main
   ```

   Confirm before pushing unless Tyler has already told you to push as part of
   the same request — it's a shared/visible action.

## Workflow B: track a new file or folder for the first time

Use this when a new app or tool has config worth version-controlling (e.g.
adding a new CLI tool's config, or a GUI app's settings file like Handy's).

1. **Find the real file(s)** — most app config lives under one of:
   - `~/.config/<app>/...` (most CLI/Linux-style tools)
   - `~/Library/Application Support/<app>/...` (macOS GUI apps)
   - `~/Library/Preferences/<bundle-id>.plist` (macOS GUI apps, plist prefs)
   - directly in `$HOME` (dotfiles proper, e.g. `~/.zshrc`)

2. **Check whether Mackup already covers it instead.** Read
   `git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME show HEAD:mackup.cfg` —
   if the app is one of Mackup's supported apps and Tyler wants it synced via
   iCloud rather than git, this repo isn't the right place for it. This git
   repo is for: shell/editor/tool config, and apps Mackup doesn't support.

3. **Inspect the file(s) before adding anything**:
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

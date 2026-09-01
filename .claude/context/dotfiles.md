# Dotfiles

Tyler's dotfiles live in a **bare git repo**, not a normal clone: git-dir is
`~/.dotfiles`, work-tree is `$HOME` itself, so tracked files sit directly at
their real paths (`~/.zshrc`, `~/.config/nvim/...`, etc). Remote:
`github.com/tylereades/dotfiles`. Shared between his personal and work
laptops.

Because there's no working-tree checkout, plain `git` commands run from `$HOME`
don't see it — always use `git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME`
(aliased to `dotfiles` in his shell, but the alias doesn't persist into tool
calls, so spell it out). The repo sets `status.showUntrackedFiles = no` on
purpose: only explicitly-tracked files ever show up in `status`/`diff`, so
random junk in `$HOME` (secrets, caches, app data) can't get swept in by an
`add -A`. Never use `-A`/`-u` on this repo — always `add` specific paths.

Not everything goes through this repo directly. macOS **application**
preferences (Rectangle, Finder, etc.) live in binary plists under
`~/Library/Preferences/` and are captured as `defaults write` lines in the
tracked `.macos` script, not by syncing the plists themselves. Mackup was
evaluated for this and **rejected** (Sept 2025): macOS rewrites preference
files atomically, which destroys Mackup's symlinks, and it silently failed to
link even a single file. Do not reintroduce it.

Apps whose settings do not appear in `defaults read <bundle-id>` cannot go in
`.macos` at all. Raycast is the example — its config is SQLite under
`~/Library/Application Support/com.raycast.macos/`. Those need per-app
handling; see `~/.config/raycast/README.md`.

Since the repo is shared across two machines, **always fetch and compare
before committing new changes** — there's no `refs/remotes/origin/main`
configured (only a fetch spec for `main`), so compare `HEAD` against
`FETCH_HEAD` after `git fetch origin`, not `origin/main`.

See the `dotfiles-sync` skill for the actual review→commit→push workflow.

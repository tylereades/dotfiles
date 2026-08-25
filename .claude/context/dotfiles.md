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

Not everything goes through this repo: `mackup.cfg` (tracked in the repo)
configures Mackup to sync most GUI app preferences via iCloud instead — zsh is
explicitly excluded from Mackup (`applications_to_ignore`) since it's handled
here in git. When adding a new app's config file, prefer this git repo when
the app isn't in Mackup's supported list (e.g. a new/niche app) — add the
specific config file only, never a whole app-support directory, and check the
file for embedded API keys/secrets first.

Since the repo is shared across two machines, **always fetch and compare
before committing new changes** — there's no `refs/remotes/origin/main`
configured (only a fetch spec for `main`), so compare `HEAD` against
`FETCH_HEAD` after `git fetch origin`, not `origin/main`.

See the `dotfiles-sync` skill for the actual review→commit→push workflow.

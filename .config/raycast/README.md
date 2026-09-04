# Raycast

Raycast keeps its real config (hotkeys, snippets, quicklinks, aliases) in
SQLite under `~/Library/Application Support/com.raycast.macos/`, so it cannot
be captured with `defaults write` in `.macos` the way Rectangle is.

Split:

- **Extensions** — sync automatically via the Raycast account. Nothing to track.
- **Settings** — Settings > Advanced > *Export Settings & Data* produces a
  `.rayconfig` covering hotkeys, aliases, quicklinks and snippets. Import on
  the other machine from the same menu. This is the real mechanism; the
  hand-written list further down is the fallback for when the export is stale.
- **Script commands** — plain shell, tracked here in `scripts/`.

### Before exporting a `.rayconfig` into this repo

**This repo is public** (`github.com/tylereades/dotfiles`). A `.rayconfig` is a
single opaque archive of everything above — snippets (`;em` is a real email
address), quicklinks, AI presets, and Clipboard History if it's left checked.

So, two non-negotiables:

1. **Uncheck Clipboard History** in the export dialog. It can hold passwords
   and tokens.
2. **Set a password** in the export dialog, which encrypts the archive. Never
   commit an unencrypted `.rayconfig` here. Keep the password in the usual
   place (see [[secrets]]); an encrypted export you can't decrypt is just a
   dead 2 MB blob.

Also worth knowing before committing one: it's a binary blob, so git can't diff
it. Every re-export rewrites the whole file and the history grows accordingly.
Re-export deliberately when settings actually change, not on a schedule.

## Manual steps on a new machine

Nothing here is automated. Work down the list after cloning the dotfiles:

1. `brew install --cask raycast`, launch it, sign in (extensions restore).
2. Set Raycast's own hotkey to `cmd+space`, and disable Spotlight's shortcut
   in System Settings > Keyboard > Keyboard Shortcuts > Spotlight.
3. Point Raycast at this repo's scripts:
   Settings > Extensions > Script Commands > *Add Directory* >
   `~/.config/raycast/scripts`
4. Import the `.rayconfig` if one exists (it's password-protected — see above),
   otherwise re-create the settings listed below by hand.
5. Run `sh ~/.macos` to apply Finder and Rectangle settings.

## Settings configured by hand

Recreate these if there is no `.rayconfig` to import.

**Clipboard History** — hotkey `opt+cmd+V`, history 3 months, keep images on,
ignore sensitive/concealed content on.

**Window management** — left to Rectangle, not Raycast. Rectangle's bindings
live in `.macos`: `ctrl+opt+1/2/3` for left/center/right third, add shift for
two-thirds. Raycast's own window commands are unbound on purpose; its custom
layouts are a Pro feature.

**Snippets** — keywords prefixed with `;` so they never fire mid-word
(`;em` email, `;gh` github url, `;dot` the dotfiles git invocation).
Requires Settings > Advanced > auto-expand snippets.

**Quicklinks** — GitHub repo jump, GitHub code search scoped to the user,
AWS console by service (us-east-1), and the `~/Projects` folder. Give each a
two-letter alias or they are not worth having.

**App hotkeys** — assign per app via `cmd+K` > *Configure Application*, and
two-letter aliases for everything else.

**WezTerm as "the terminal"** — WezTerm gets the alias `terminal` via
`cmd+K` > *Configure Application*, so typing the word launches it instead of
Apple's Terminal.app. Note the alias only wins once enough of it is typed; on
a bare `ter` the built-in Terminal.app is still a legitimate prefix match, and
Raycast has no setting to exclude an app from search. Frecency sorts this out
with use, and an app hotkey sidesteps the race entirely.

macOS has no system-wide default-terminal setting, so Finder's *New Terminal
at Folder* stays wired to Terminal.app no matter what — the alias only governs
what Raycast opens.

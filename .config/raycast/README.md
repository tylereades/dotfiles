# Raycast

Raycast keeps its real config (hotkeys, snippets, quicklinks, aliases) in
SQLite under `~/Library/Application Support/com.raycast.macos/`, so it cannot
be captured with `defaults write` in `.macos` the way Rectangle is.

Split:

- **Extensions** — sync automatically via the Raycast account. Nothing to track.
- **Settings** — **not exportable on the free tier.** *Export Settings & Data*
  (Settings > Advanced) produces a `.rayconfig`, but it's a Pro feature and is
  greyed out here. So the hand-written list below is the source of truth, not a
  fallback — if you change a setting in Raycast, edit this file too or it's
  lost on the next machine.
- **Script commands** — plain shell, tracked here in `scripts/`.

If a Pro subscription ever happens, two things to get right before a
`.rayconfig` lands in this repo: **this repo is public**, and that archive
bundles snippets (`;em` is a real email address), quicklinks, AI presets, and
Clipboard History unless it's unchecked. Uncheck it, password-protect the
export, and note that it's an undiffable binary blob that git will store in
full on every re-export.

## Manual steps on a new machine

Nothing here is automated. Work down the list after cloning the dotfiles:

1. `brew install --cask raycast`, launch it, sign in (extensions restore).
2. Set Raycast's own hotkey to `cmd+space`, and disable Spotlight's shortcut
   in System Settings > Keyboard > Keyboard Shortcuts > Spotlight.
3. Point Raycast at this repo's scripts:
   Settings > Extensions > Script Commands > *Add Directory* >
   `~/.config/raycast/scripts`
4. Re-create the settings listed below by hand — there's no export to import
   on the free tier.
5. Run `sh ~/.macos` to apply Finder and Rectangle settings.

## Settings configured by hand

Recreate these by hand on a new machine. Keep the list current — nothing else
captures them.

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

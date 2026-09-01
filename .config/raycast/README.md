# Raycast

Raycast keeps its real config (hotkeys, snippets, quicklinks, aliases) in
SQLite under `~/Library/Application Support/com.raycast.macos/`, so it cannot
be captured with `defaults write` in `.macos` the way Rectangle is.

Split:

- **Extensions** — sync automatically via the Raycast account. Nothing to track.
- **Settings** — Settings > Advanced > *Export Settings & Data* produces a
  `.rayconfig`. Uncheck **Clipboard History** before exporting; it can contain
  passwords and tokens. Import on the other machine from the same menu.
- **Script commands** — plain shell, tracked here in `scripts/`.

## Manual steps on a new machine

Nothing here is automated. Work down the list after cloning the dotfiles:

1. `brew install --cask raycast`, launch it, sign in (extensions restore).
2. Set Raycast's own hotkey to `cmd+space`, and disable Spotlight's shortcut
   in System Settings > Keyboard > Keyboard Shortcuts > Spotlight.
3. Point Raycast at this repo's scripts:
   Settings > Extensions > Script Commands > *Add Directory* >
   `~/.config/raycast/scripts`
4. Import the `.rayconfig` if one exists, otherwise re-create the settings
   listed below by hand.
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

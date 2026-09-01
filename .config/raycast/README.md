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

Point Raycast at the scripts directory once per machine:
Settings > Extensions > Script Commands > *Add Directory* >
`~/.config/raycast/scripts`

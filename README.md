# dotfiles

Personal dotfiles for Tyler Eades. Uses a bare git repo with `$HOME` as the work tree.

## New machine setup

```bash
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone
git clone --bare https://github.com/tylereades/dotfiles.git ~/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config core.excludesFile ~/.dotfiles-gitignore

# 3. Git identity (untracked, per-machine)
cp ~/.gitconfig-identity.example ~/.gitconfig-identity
# edit ~/.gitconfig-identity — set name and email

# 4. Install tools
brew bundle
git lfs install

# 5. Apply macOS/app preferences
sh ~/.macos
```

For work machine setup (AWS, Claude Code, Zillow tools) see the work dotfiles:
`gitlab.zgtools.net/tylerea/dotfiles-work`

## Daily use

```bash
# Status / diff
dotfiles status
dotfiles diff

# Stage and commit
dotfiles add ~/.some/file
dotfiles commit -m "chore: description"
dotfiles push
```

`dotfiles` is aliased in `.zshrc`. In tool calls, spell it out:
`/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME`

## What's tracked

Shell (`zshrc`, `zsh/`), editor (`nvim/`), terminal (`wezterm`), prompt (`starship`), git (`gitconfig`, `gitconfig-identity.example`), Brewfile, macOS prefs (`.macos`), Raycast scripts (`.config/raycast/`).

## What's NOT here

- `~/.gitconfig-identity` — per-machine, fill from the `.example`
- SSH private keys — regenerate on each machine
- Work configs (AWS, Databricks, Claude Code work context) — in work dotfiles

#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dotfiles Status
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🗂️
# @raycast.packageName Dotfiles

# Documentation:
# @raycast.description Show uncommitted dotfiles changes and any commits waiting on the remote
# @raycast.author Tyler Eades

dot() { git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"; }

echo "--- uncommitted ---"
dot status --short || echo "(clean)"

echo
echo "--- remote ---"
dot fetch origin --quiet 2>/dev/null
behind=$(dot log --oneline HEAD..FETCH_HEAD 2>/dev/null)
ahead=$(dot log --oneline FETCH_HEAD..HEAD 2>/dev/null)
[ -n "$behind" ] && { echo "behind by:"; echo "$behind"; }
[ -n "$ahead" ]  && { echo "ahead by:";  echo "$ahead"; }
[ -z "$behind$ahead" ] && echo "in sync with origin/main"

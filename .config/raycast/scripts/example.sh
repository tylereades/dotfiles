#!/bin/bash

# Template for new Raycast script commands. Copy this file, change the
# metadata, make it executable. Raycast picks it up automatically.
#
# mode: fullOutput (show output in a view) | compact (toast) | silent | inline

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Example
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🧪
# @raycast.packageName Examples
# @raycast.argument1 { "type": "text", "placeholder": "name", "optional": true }

# Documentation:
# @raycast.description Minimal script command showing metadata and an argument
# @raycast.author Tyler Eades

echo "hello ${1:-world}"

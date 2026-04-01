#!/bin/bash

# i3-workspace-nav.sh [next|prev] [move|switch]
# Handles numeric workspace navigation, creating new workspaces if they don't exist.

DIRECTION=$1
MODE=$2

# Get current focused workspace number
CURRENT=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')

# Fallback to 1 if not found
if [[ -z "$CURRENT" ]]; then
    CURRENT=1
fi

if [[ "$DIRECTION" == "next" ]]; then
    NEW=$((CURRENT + 1))
elif [[ "$DIRECTION" == "prev" ]]; then
    NEW=$((CURRENT - 1))
    if [[ $NEW -lt 1 ]]; then NEW=1; fi
else
    exit 1
fi

if [[ "$MODE" == "move" ]]; then
    # Move focused window and then switch to that workspace
    i3-msg "move container to workspace number $NEW; workspace number $NEW"
else
    # Just switch to the workspace
    i3-msg "workspace number $NEW"
fi

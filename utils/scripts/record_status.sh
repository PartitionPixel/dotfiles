#!/usr/bin/env bash

# Absolute path to the state file
STATE_FILE="~/dotfiles/utils/scripts/.recording_start_time"

if pgrep -x wf-recorder > /dev/null && [ -f "$STATE_FILE" ]; then
    start_time=$(cat "$STATE_FILE")
    now=$(date +%s)
    elapsed=$((now - start_time))

    # format mm:ss
    minutes=$((elapsed / 60))
    seconds=$((elapsed % 60))
    timer=$(printf "%02d:%02d" "$minutes" "$seconds")

    echo "🔴 $timer"
else
    echo "⏺"
fi

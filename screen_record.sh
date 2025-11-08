#!/usr/bin/env bash

STATE_FILE="/home/warpstar/.recording_start_time"
mkdir -p "/home/warpstar/Videos/Recordings"

# Check if recording is already running
if pgrep -x wf-recorder > /dev/null; then
    pkill -INT -x wf-recorder
    rm -f "$STATE_FILE"
    kill -SIGRTMIN+1 $(pidof waybar)
    exit 0
fi

# Ask user for selection
GEOMETRY=$(slurp)
if [ -z "$GEOMETRY" ]; then
    notify-send "Screen Recording" "No region selected, canceled"
    exit 1
fi

# Create the state file immediately (for the timer)
date +%s > "$STATE_FILE"

# Signal Waybar immediately so timer starts
kill -SIGRTMIN+1 $(pidof waybar)

# Start recording in foreground (still blocks for wf-recorder)
dateTime=$(date +%m-%d-%Y-%H-%M-%S)
output="/home/warpstar/Videos/Recordings/$dateTime.mp4"
wf-recorder --bframes max_b_frames -f "$output" -g "$GEOMETRY"

# Cleanup after recording ends
rm -f "$STATE_FILE"
kill -SIGRTMIN+1 $(pidof waybar)
notify-send "Screen Recording" "Saved: $output"

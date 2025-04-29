#!/bin/bash

# Get all active outputs
outputs=$(swaymsg -t get_outputs | jq -r '.[] | select(.active) | .name')

# Check if eDP-1 and DP-1 are in the list of active outputs
edp_active=$(echo "$outputs" | grep -w "eDP-1")
dp_active=$(echo "$outputs" | grep -w "DP-1")

if [[ -n "$edp_active" && -n "$dp_active" ]]; then
    # Both eDP-1 and DP-1 are active, disable eDP-1
    swaymsg output eDP-1 disable
    swaymsg output DP-1 enable
elif [[ -n "$edp_active" && -z "$dp_active" ]]; then
    # Only eDP-1 is active, disable eDP-1 and enable DP-1
    swaymsg output eDP-1 disable
    swaymsg output DP-1 enable
elif [[ -z "$edp_active" && -n "$dp_active" ]]; then
    # Only DP-1 is active, disable DP-1 and enable eDP-1
    swaymsg output DP-1 disable
    swaymsg output eDP-1 enable
else
    notify-send "No known outputs are active. Resetting"
    swaymsg output DP-1 enable
    swaymsg output eDP-1 enable
fi

pkill gammastep && sleep 1 && gammastep -O 3000k;

#!/bin/bash

workspaces=$(i3-msg -t get_workspaces | jq -r '.[].name')
active_workspace_monitor=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true).output')

# Turn the active monitor the primary
xrandr --output $active_workspace_monitor --primary

## Move each workspace to the destination output
for workspace in $workspaces; do
    i3-msg "workspace $workspace; move workspace to output $active_workspace_monitor" &
done

# Restart i3 to reload the config
sleep 1
i3-msg restart

# Send a notification
notify-send "Display" "Primary display set to $active_workspace_monitor"

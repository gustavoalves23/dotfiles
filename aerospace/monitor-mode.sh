#!/bin/bash
# Mirrors sway's display-principal.sh using BetterDisplay CLI
# Both active -> External only
# Only Built-in active -> External only
# Only External active -> Built-in only

BD=/opt/homebrew/bin/betterdisplaycli

# Built-in display (Color LCD = eDP-1) and External display (LC34G55T = DP-1)
BUILTIN="Color LCD"
EXT="LC34G55T"

builtin_state=$($BD get --originalName="$BUILTIN" --connected 2>/dev/null)
ext_state=$($BD get --originalName="$EXT" --connected 2>/dev/null)

if [[ "$builtin_state" == "on" && "$ext_state" == "on" ]]; then
    # Both Built-in and External are active -> disable Built-in, keep External
    $BD set --originalName="$EXT" --connected=on
    $BD set --originalName="$BUILTIN" --connected=off
    osascript -e 'display notification "External display only (LC34G55T)" with title "AeroSpace"'
elif [[ "$builtin_state" == "on" && "$ext_state" == "off" ]]; then
    # Only Built-in is active -> enable External and disable Built-in
    $BD set --originalName="$EXT" --connected=on
    sleep 1
    $BD set --originalName="$BUILTIN" --connected=off
    osascript -e 'display notification "External display only (LC34G55T)" with title "AeroSpace"'
elif [[ "$builtin_state" == "off" && "$ext_state" == "on" ]]; then
    # Only External is active -> enable Built-in and disable External
    $BD set --originalName="$BUILTIN" --connected=on
    sleep 1
    $BD set --originalName="$EXT" --connected=off
    osascript -e 'display notification "Built-in display only" with title "AeroSpace"'
else
    osascript -e 'display notification "No known outputs are active. Resetting" with title "AeroSpace"'
    $BD set --originalName="$EXT" --connected=on
    $BD set --originalName="$BUILTIN" --connected=on
fi

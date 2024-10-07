#!/bin/bash

CONFIG_FILE="$HOME/.config/waybar/config-hyprland"
STYLE_FILE="$HOME/.config/waybar/style-hyprland.css"
CONFIG_FILES="$CONFIG_FILE $STYLE_FILE"

trap "killall waybar" EXIT

while true; do
    waybar -c $CONFIG_FILE -s $STYLE_FILE &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done

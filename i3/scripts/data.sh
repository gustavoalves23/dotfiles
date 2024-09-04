#! /bin/bash

volume=$(pactl list sinks | grep "^[[:space:]]Volume:" | awk 'FNR ==4 {print $5}')

hora=$(date "+%H:%M")

data=$(date "+%d %B %Y %A")

bateria=$(cat /sys/class/power_supply/BAT0/capacity)%

echo "Vol" $volume "|" "Bateria" $bateria "|" "Hora" $hora "|" "Data" $data

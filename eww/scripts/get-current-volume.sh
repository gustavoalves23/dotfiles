pactl get-sink-volume @DEFAULT_SINK@ | grep 'Volume:' | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'

#!/bin/bash

pw-mon | grep --line-buffered 'mute' | while read -r line; do
    pactl get-sink-mute @DEFAULT_SINK@ | sed -e 's/Mute: //'
done



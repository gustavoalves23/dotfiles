#!/bin/bash

swaymsg opacity plus 0.01

if [ $? -eq 0 ]; then
        swaymsg opacity 1
else
        swaymsg opacity 0.7
fi

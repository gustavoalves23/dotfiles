#!/bin/bash

notify-send "Disabling screen" -t 1000

sleep 1

hyprctl dispatch dpms off

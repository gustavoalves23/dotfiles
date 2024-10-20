#!/bin/bash

playerctl --player=spotify metadata --format "{\
\"status\":\"{{ status }}\",\
\"progress_percentage\":\"{{ position / mpris:length * 100 }}\",\
\"artist\":\"{{ artist }}\",\
\"title\":\"{{ title }}\"\
}" --follow

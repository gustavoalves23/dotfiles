#!/bin/bash

playerctl --player=spotify metadata --format '{{ position / mpris:length * 100 }}' --follow

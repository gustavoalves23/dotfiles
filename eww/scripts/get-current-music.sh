#!/bin/bash

playerctl --player=spotify metadata --format '{{ artist }} - {{ title }} {{ duration(position) }}|{{ duration(mpris:length) }}' --follow

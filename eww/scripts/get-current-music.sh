#!/bin/bash

playerctl metadata --format '{{ artist }} - {{ title }} {{ duration(position) }}|{{ duration(mpris:length) }}' --follow

#!/bin/bash

playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}' --follow

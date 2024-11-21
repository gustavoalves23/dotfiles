#!/bin/bash

alacritty_socket=$(tmux showenv | grep ALACRITTY_SOCKET | sed "s/ALACRITTY_SOCKET=//")
alacritty_window_id=$(tmux showenv | grep ALACRITTY_WINDOW_ID | sed "s/ALACRITTY_WINDOW_ID=//")

echo "{\"alacritty_socket\": \"$alacritty_socket\", \"alacritty_window_id\": \"$alacritty_window_id\"}"

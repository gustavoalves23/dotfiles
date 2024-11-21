#!/bin/bash

declare -A env_vars

while IFS='=' read -r key value; do
    if [[ $key == "ALACRITTY_SOCKET" || $key == "ALACRITTY_WINDOW_ID" ]]; then
        env_vars[$key]=$value
    fi
done < <(tmux showenv)

echo "{\"alacritty_socket\": \"${env_vars[ALACRITTY_SOCKET]}\", \"alacritty_window_id\": \"${env_vars[ALACRITTY_WINDOW_ID]}\"}"

#!/bin/sh

socket=""
window_id=""

while IFS='=' read -r key value; do
    case "$key" in
        ALACRITTY_SOCKET) socket=$value ;;
        ALACRITTY_WINDOW_ID) window_id=$value ;;
    esac
done <<EOF
$(tmux showenv)
EOF

printf '{"alacritty_socket": "%s", "alacritty_window_id": "%s"}\n' "$socket" "$window_id"

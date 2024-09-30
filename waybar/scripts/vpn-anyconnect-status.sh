#!/bin/bash

IFACE=$(ifconfig | grep cscotun | awk '{print $1}')

if [[ "$IFACE" =~ ^cscotun.* ]]; then
    IP="󰱓 $(ifconfig cscotun0 | grep inet | awk '{print $2}' | cut -f2 -d ':')"
    echo "{\"text\":\"$IP\", \"class\":\"connected\"}"
else
    echo "{\"text\":\"󰅛 VPN\", \"class\":\"disconnected\"}"
fi

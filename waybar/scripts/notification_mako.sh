#!/bin/bash

IS_NOT_DISTURB=$(makoctl mode | grep -o "dnd")

if [[ "$IS_NOT_DISTURB" == "dnd" ]]; then
    echo "{\"text\":\" DND\", \"class\":\"disabled\"}"
else
    echo "{\"text\":\"\", \"class\":\"enabled\"}"
fi

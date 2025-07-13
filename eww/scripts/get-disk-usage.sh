#!/bin/bash

if [[ "$PC_DEVICE_KIND" == "personal_computer" ]]; then
    DISK="sda"
else
    DISK="sda"
fi

iostat -d -k 1 "$DISK" | awk -v dev="$DISK" '
BEGIN {
    skip_lines = 3;
}
NR <= skip_lines { next; }
$1 == dev {
    printf("{\"read\": %.1f, \"write\": %.1f}\n", $3, $4);
    fflush();
}'

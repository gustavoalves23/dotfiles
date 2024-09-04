#!/bin/bash

current_brightness=$(ddcutil getvcp 10 --display 1 | awk -F 'current value =' '{print $2}' | awk '{print $1}' | sed 's/,//g')

if [ $current_brightness -eq 100 ]; then
    ddcutil setvcp 10 80 --display 1
fi

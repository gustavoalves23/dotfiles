#!/bin/bash

pkill hyprsunset

sleep .1

nohup hyprsunset --temperature 3000 > /dev/null 2>&1 &

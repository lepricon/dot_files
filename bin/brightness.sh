#!/bin/bash

MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
ACTUAL_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/actual_brightness)

if [[ $# > 0 ]]; then
    BRIGHTNESS_PERCENT=$1
    sudo tee /sys/class/backlight/intel_backlight/brightness <<< $(echo "${BRIGHTNESS_PERCENT}*${MAX_BRIGHTNESS}/100" | bc) > /dev/null
else
   echo "${ACTUAL_BRIGHTNESS}*100/${MAX_BRIGHTNESS}" | bc
fi


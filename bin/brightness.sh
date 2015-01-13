#!/bin/bash

MAX_BRIGHTNESS=$(cat /sys/class/backlight/intel_backlight/max_brightness)
BRIGHTNESS_PERCENT=$1
sudo tee /sys/class/backlight/intel_backlight/brightness <<< $(echo "${BRIGHTNESS_PERCENT}*${MAX_BRIGHTNESS}/100" | bc) > /dev/null

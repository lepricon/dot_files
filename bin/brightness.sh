#!/bin/bash

BRIGHTNESS_PERCENT=$1
sudo tee /sys/class/backlight/intel_backlight/brightness <<< $(echo "${BRIGHTNESS_PERCENT}*3484/100" | bc) > /dev/null

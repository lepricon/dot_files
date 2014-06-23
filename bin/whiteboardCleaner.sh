#!/bin/bash
convert "$1" \( +clone -blur 0x20 \) -compose Divide_Src -composite -normalize -level 10%,90% -unsharp 0x5+2+0 "$2"

#!/bin/sh

case "$1" in
up) hyprctl dispatch 'hl.dsp.focus({ workspace = "r+1" })' ;;
down) hyprctl dispatch 'hl.dsp.focus({ workspace = "r-1" })' ;;
*) echo "Usage: $0 {up|down}" ;;
esac

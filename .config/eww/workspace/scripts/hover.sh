#!/bin/bash

ws=$1
preview="/tmp/.preview.png"
addr=$(hyprctl -j clients | jq -r --arg ws "$ws" '.[] | select(.workspace.id == ($ws | tonumber)and .visible == true) | .address')
if [ -n "$addr" ]; then
    grim -t png -l 0 -w "$addr" "$preview"
else
    preview="$HOME/.config/hypr/wallpaper/1.jpg"
fi

eww update img_path="$preview"

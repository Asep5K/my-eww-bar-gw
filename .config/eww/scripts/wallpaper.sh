#!/bin/bash
WALLPAPER_DIR="$HOME/.local/share/wallpaper/images/"
# Menggunakan array untuk menampung file
files=($(fd --type f --max-depth 1 --regex '\.(png|jpe?g|webp|gif)' "$WALLPAPER_DIR"))

json="["
first=true

for f in "${files[@]}"; do
    if [ "$first" = true ]; then
        first=false
    else
        json+=","
    fi
    
    json+="{\"path\": \"$f\", \"exec\": \"awww img --transition-type grow '$f' &\", \"name\": \"${f##*/}\"}"
done

json+="]"
printf "%s" "$json" > ~/.config/eww/wallpaper/files.json
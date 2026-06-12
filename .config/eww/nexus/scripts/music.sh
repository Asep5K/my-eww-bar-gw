#!/bin/bash

a() {
    printf '{"title": "%s", "artist": "%s", "thumbnail": "%s", "length": %d, "status": "%s"}\n' \
        "$USER" "$USER" "$HOME/.face" "10" "None"
    playerctl metadata --follow --format '{{artist}}|{{title}}|{{mpris:artUrl}}|{{mpris:length}}|{{status}}' |
        while IFS='|' read -r artist title arturl length status; do
            [ -z "$title" ] && continue
            if [[ -n "$length" && "$length" =~ ^[0-9]+$ ]]; then
                len_sec=$(((length + 500000) / 1000000))
                mins=$((len_sec / 60))
                secs=$((len_sec % 60))
                lengthStr=$(printf "%d:%02d" "$mins" "$secs")
            else
                len_sec=""
                lengthStr=""
            fi
            if [ -z "$arturl" ]; then
                arturl="$HOME/.face"
            elif [[ "$arturl" =~ ^file:// ]]; then
                arturl="${arturl#*//}"
            elif [[ "$arturl" =~ ^https?:// ]]; then
                curl -sL "$arturl" -o "/tmp/spotify.png" && arturl='/tmp/spotify.png' || arturl="$HOME/.face"
            fi
            printf '{"title": "%s", "artist": "%s", "thumbnail": "%s", "length": %d, "status": "%s"}\n' \
                "$title" "$artist" "$arturl" "$len_sec" "$status"
        done

}

b() {
    playerctl metadata -F -f '{{position}}|{{mpris:length}}' | while IFS='|' read -r position length; do
        pos_sec=$(((position + 500000) / 1000000))
        printf '{"position":%d,"positionStr":"%d:%02d"}\n' \
            "$pos_sec" $((pos_sec / 60)) $((pos_sec % 60))
    done
}

case $1 in
a) a ;;
b) b ;;
esac

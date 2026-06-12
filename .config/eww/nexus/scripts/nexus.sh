#!/bin/bash
set_layer_rule() {
    local namespace="$1" animation="$2"
    hyprctl eval "hl.layer_rule({
        match = { namespace = \"$namespace\" },
        animation = \"$animation\",
        blur = true,
        ignore_alpha = 0.5,
    })"
}

set_layer_rule "nexus-win" "slide"
if [[ "$(eww get nexus_rev)" == "true" ]]; then
    eww update nexus_rev=false
    eww close nexus_win
else
    eww update nexus_rev=true
    eww open nexus_win
fi

#!/bin/sh

func_name="${0##*/}"
func_name="${func_name%.*}"
hyprctl eval 'hl.layer_rule({ match= "gtk-layer-shell", animation="slide"})'
# calendar() {
#	if eww active-windows | grep -q 'calendar'; then
#		eww update calrev=false
#{ sleep 0.2 && eww close calendar; } &
#else
#	eww open calendar && eww update calrev=true

#fi
#}

right_menu() {
	if [[ "$(eww get open_rmenu)" == "true" ]]; then
		eww update open_rmenu=false
		eww close right_menu
	else
		eww update open_rmenu=true
		eww open right_menu
	fi
}

${func_name}

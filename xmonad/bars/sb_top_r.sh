#!/bin/zsh

source $HOME/.xmonad/bars/sb_env.sh

DZEN_XPOS=$DZEN_W
DZEN_YPOS=0

CONKYRC="$HOME/.xmonad/conky/conkyrc_top"

print_volume_info() {
	volume_percent=$(amixer get Master | grep "Mono:" | awk '{print $4}' | tr -d "[]%")

	echo -n "^fg($DZEN_FG2)^i($ICON_DIR/volume50.xbm)^fg() "
	echo -n "^fg($DZEN_FG1)$volume_percent%^fg()"
}

print_wireless_info() {
	echo -n "^fg($DZEN_FG2)^i($ICON_DIR/wireless5.xbm)^fg() "
	echo -n "^fg($DZEN_FG1)$wireless_essid^fg()"
}

print_battery_info() {
	read battery_status battery_percent <<< $battery_info
	battery_percent=$(echo $battery_percent | sed -e 's/\(^.*\)\(.$\)/\1/')

	if [[ "$battery_status" == "U" ]]; then
		# Battery is probably actually full, but just degrading
		battery_status="F"
		battery_percent=100
	fi

	if [[ "$battery_status" != "D" ]]; then
		battery_icon="$ICON_DIR/ac_01.xbm"
	elif [[ $battery_percent -lt 40 ]]; then
		battery_icon="$ICON_DIR/bat_low_01.xbm"
	else
		battery_icon="$ICON_DIR/bat_full_01.xbm"
	fi

	echo -n "^fg($DZEN_FG2)^i($battery_icon)^fg() "
	echo -n "^fg($DZEN_FG1)$battery_percent%^fg()"
}

print_cpu_info() {
	echo -n "^fg($DZEN_FG2)^i($ICON_DIR/cpu.xbm)^fg() "
	echo -n "^fg($DZEN_FG1)${cpu_frequency}GHz^fg()"
}

print_mem_info() {
	echo -n "^fg($DZEN_FG2)^i($ICON_DIR/mem.xbm)^fg() "
	echo -n "^fg($DZEN_FG1)$memory_used^fg()"
}

print_date_info() {
	echo -n "^fg($DZEN_FG2)^i($ICON_DIR/clock.xbm)^fg() "
	echo -n "^fg($DZEN_FG1)$dateinfo^fg()"
}

print_space() {
	echo -n " ^fg($DZEN_FG2)|^fg() "
}

print_bar() {
	while true; do
		IFS='|' read cpu_frequency memory_used battery_info \
			wireless_essid dateinfo
		print_volume_info
		print_space
		print_wireless_info
		print_space
		print_battery_info
		print_space
		print_cpu_info
		print_space
		print_mem_info
		print_space
		print_date_info
		echo
	done
	return
}

conky -c  $CONKYRC |
print_bar |
dzen2 -x $DZEN_XPOS -y $DZEN_YPOS ${DZEN_ARGS_R[@]}

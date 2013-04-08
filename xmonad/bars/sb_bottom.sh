#!/bin/zsh

source $HOME/.xmonad/bars/sb_env

# Left dzen bar
DZEN_XPOS_L=0
DZEN_YPOS=$(( $($HOME/.xmonad/misc/query_xres.sh y) - $DZEN_H ))
# Right dzen bar
DZEN_XPOS_R=$DZEN_W

CONKYRC_L="$HOME/.xmonad/conky/conkyrc_bl"
CONKYRC_R="$HOME/.xmonad/conky/conkyrc_br"

print_vol_info() {
	volperc=$(amixer get Master | grep "Mono:" | awk '{print $4}' | tr -d '[]%')
	mute_state=$(amixer get Master | grep "Mono:" | awk '{print $6}')
	echo -n "Volume "
	if [[ $mute_state == "[off]" ]]; then
		echo -n "$(echo $volperc | gdbar ${GDBAR_ARGS[@]}) "
	else
		echo -n "$(echo $volperc | gdbar ${GDBAR_ARGS[@]}) "
	fi
	echo -n "^fg($DZEN_FG2)$volperc%^fg()"
}

print_xmms2_info() {
	echo -n "XMMS2: ^fg($DZEN_FG2)$xmms2_status^fg()"
	if [[ $xmms2_status == "Playing" || $xmms2_status == "Paused" ]]; then
		print_space
		echo -n "^fg($DZEN_FG2)$xmms_info^fg()"
	fi
}

print_left_bar() {
	while true; do
		read xmms2_status xmms2_info
		print_vol_info
		print_space
		print_xmms2_info
		echo
	done
}

print_battery_info() {
	case "$battery_status" in
	"U")
		battery_status="Unknown"
		;;
	"F")
		battery_status="Full"
		;;
	"C")
		battery_status="Charging"
		;;
	"D")
		battery_status="Discharging"
		;;
	"N")
		battery_status="Not Present"
		;;
	"E")
		battery_status="Empty"
		;;
	esac

	# String trailing '%' from battery percentage
	battery_percent=$(echo $battery_percent | sed -e 's/\(^.*\)\(.$\)/\1/')

	if [[ "$battery_status" == "Unknown" && "$battery_percent" -ge "95" ]]; then
		# If battery percentage is "Unknown" and greater than 95, it probably
		# means that the battery is actually full (or at least as full as it will
		# get). The kernel doesn't do any kind of percentage metrics for
		# degrading batteries to determine if a battery is full.
		# 
		# See acpi_battery_is_charged() in drivers/acpi/battery.c for details.
		battery_status="Full"
	fi

	echo -n "Battery: "
	echo -n "^fg($DZEN_FG2)$battery_status^fg() "
	echo -n "$(echo $battery_percent | gdbar ${GDBAR_ARGS[@]}) "
	echo -n "^fg($DZEN_FG2)$(printf '%3s' $battery_percent)%^fg()"
}

print_wireless_info() {
	echo -n "WIFI: "
	echo -n "^fg($DZEN_FG2)$wireless_essid^fg() "

	if [[ "$wireless_perc" == "unk" ]]; then; wireless_perc="0"; fi
	echo -n "$(echo $wireless_perc | gdbar ${GDBAR_ARGS[@]}) "
	echo -n "^fg($DZEN_FG2)$(printf '%3s' $wireless_perc)%^fg()"
}
  

print_right_bar() {
	while true; do
		read battery_status battery_percent wireless_perc wireless_essid
		print_battery_info
		print_space
		print_wireless_info
		echo
	done
}

# Disable volume bar for now..
#
# conky -c $CONKYRC_L |
# print_left_bar |
dzen2 -x $DZEN_XPOS_L -y $DZEN_YPOS ${DZEN_ARGS_L[@]} &

conky -c $CONKYRC_R |
print_right_bar |
dzen2 -x $DZEN_XPOS_R -y $DZEN_YPOS ${DZEN_ARGS_R[@]}

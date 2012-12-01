#!/bin/zsh

source $HOME/.xmonad/bars/sb_env

# Left dzen bar
DZEN_XPOS_L=0
DZEN_YPOS_L=1026
# Right dzen bar
DZEN_XPOS_R=840
DZEN_YPOS_R=1026

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

print_brightness_info() {
  br_max=`cat /sys/class/backlight/acpi_video0/max_brightness`
  br_current=`cat /sys/class/backlight/acpi_video0/actual_brightness`
  br_perc=$(($br_current * 100 / $br_max))
  echo -n "Brightness: "
  echo -n "$(echo $br_perc | gdbar ${GDBAR_ARGS[@]}) "
  echo -n "^fg($DZEN_FG2)$br_perc%^fg()"
}

print_battery_info() {
  # /sys/class/power_supply/BAT0
  bat_status=`cat /sys/class/power_supply/BAT0/status`
  bat_current=`cat /sys/class/power_supply/BAT0/charge_now`
  bat_max=`cat /sys/class/power_supply/BAT0/charge_full`
  bat_perc=$(($bat_current * 100 / $bat_max))

  if [[ "$bat_status" == "Unknown" && "$bat_perc" -ge "95" ]]; then
    # If battery percentage is "Unknown" and greater than 95, it probably
    # means that the battery is actually full (or at least as full as it will
    # get). The kernel doesn't do any kind of percentage metrics for
    # degrading batteries to determine if a battery is full.
    # 
    # See acpi_battery_is_charged() in drivers/acpi/battery.c for details.
    bat_status="Full"
  fi

  echo -n "Battery: "
  echo -n "^fg($DZEN_FG2)$bat_status^fg() "
  echo -n "$(echo $bat_perc | gdbar ${GDBAR_ARGS[@]}) "
  echo -n "^fg($DZEN_FG2)$(printf '%3s' $bat_perc)%^fg()"
}

print_wireless_info() {
  echo -n "WIFI: "
  echo -n "^fg($DZEN_FG2)$wireless_essid^fg() "
  echo -n "$(echo $wireless_perc | gdbar ${GDBAR_ARGS[@]}) "
  echo -n "^fg($DZEN_FG2)$(printf '%3s' $wireless_perc)%^fg()"
}
  

print_right_bar() {
  while true; do
    read wireless_essid wireless_perc
    print_brightness_info
    print_space
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
dzen2 -x $DZEN_XPOS_L -y $DZEN_YPOS_L ${DZEN_ARGS_L[@]} &

conky -c $CONKYRC_R |
print_right_bar |
dzen2 -x $DZEN_XPOS_R -y $DZEN_YPOS_R ${DZEN_ARGS_R[@]}

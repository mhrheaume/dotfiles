#!/bin/zsh

source ${HOME}/.xmonad/sb_env

# Left dzen bar
DZEN_XPOS_L=0
DZEN_YPOS_L=1176
# Right dzen bar
DZEN_XPOS_R=960
DZEN_YPOS_R=1176

CONKYRC_L="${HOME}/.xmonad/conkyrc_bl"
CONKYRC_R="${HOME}/.xmonad/conkyrc_br"

print_vol_info() {
  volperc=$(amixer get Master | grep "Mono:" | awk '{print $4}' | tr -d '[]%')
  mute_state=$(amixer get Master | grep "Mono:" | awk '{print $6}')
  echo -n "Volume "
  if [[ $mute_state == "[off]" ]]; then
    echo -n "$(echo $volperc | gdbar -fg $GDBAR_FG2 -bg $GDBAR_BG -h $GDBAR_H -w $GDBAR_W -s o -ss 1 -sw 2 -nonl) "
  else
    echo -n "$(echo $volperc | gdbar -fg $GDBAR_FG -bg $GDBAR_BG -h $GDBAR_H -w $GDBAR_W -s o -ss 1 -sw 2 -nonl) "
  fi
  echo -n "^fg($DZEN_FG2)${volperc}%^fg()"
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
  # TODO
  echo -n "Brightness: "
  echo -n "^fg($DZEN_FG2)Unknown^fg()"
}

print_battery_info() {
  echo -n "Battery: "
  case $battery_status in
    'F')
      echo -n "^fg($DZEN_FG2)Full^fg() "
      ;;
    'N')
      echo -n "^fg($DZEN_FG2)Not Present^fg() "
      ;;
    'E')
      echo -n "^fg($DZEN_FG2)Empty^fg() "
      ;;
    'C')
      echo -n "^fg($DZEN_FG2)Charging ($battery_time)^fg() "
      ;;
    'D')
      echo -n "^fg($DZEN_FG2)Discharging ($battery_time)^fg() "
      ;;
    *)
      echo -n "^fg($DZEN_FG2)Unknown^fg() "
      ;;
  esac
  echo -n "$(echo $battery_perc | gdbar -fg $GDBAR_FG -bg $GDBAR_BG -h $GDBAR_H -w $GDBAR_W -s o -ss 1 -sw 2 -nonl) "
  echo -n "^fg($DZEN_FG2)${battery_perc}%^fg()"
}

print_wireless_info() {
  echo -n "WIFI: "
  echo -n "^fg($DZEN_FG2)$wireless_essid^fg() "
  echo -n "$(echo $wireless_perc | gdbar -fg $GDBAR_FB -bg $GDBAR_BG -h $GDBAR_H -w $GDBAR_W -s o -ss 1 -sw 2 -nonl) "
  echo -n "^fg($DZEN_FG2)${wireless_perc}%^fg()"
}
  

print_right_bar() {
  while true; do
    read battery_status battery_perc battery_time wireless_essid wireless_perc
    print_brightness_info
    print_space
    print_battery_info
    print_space
    print_wireless_info
    echo
  done
}

conky -c $CONKYRC_L | print_left_bar | dzen2 -x $DZEN_XPOS_L -y $DZEN_YPOS_L -w $DZEN_W -h $DZEN_H -bg $DZEN_BG -fg $DZEN_FG -fn $DZEN_FONT -ta l -p
conky -c $CONKYRC_R | print_right_bar | dzen2 -x $DZEN_XPOS_R -y $DZEN_YPOS_R -w $DZEN_W -h $DZEN_H -bg $DZEN_BG -fg $DZEN_FG -fn $DZEN_FONT -ta r -p

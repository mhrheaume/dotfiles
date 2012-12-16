#!/bin/zsh
#
# Script to increase brightness. Will increase the brightness by five percent
# each time this script is run.
#
###

BACKLIGHT_DIR=/sys/class/backlight/acpi_video0

br_min=0
br_max=$(cat ${BACKLIGHT_DIR}/max_brightness)
br_current=$(cat ${BACKLIGHT_DIR}/actual_brightness)

case $1 in
"down")
  br_new=$(($br_current - 1))
  ;;
"up")
  br_new=$(($br_current + 1))
  ;;
*)
  echo "Invalid operation."
  exit 1
  ;;
esac

if [[ $br_new -le $br_max && $br_new -ge $br_min ]]; then
  echo $br_new > $BACKLIGHT_DIR/brightness
fi

#!/bin/zsh
# /etc/acpi/default.sh
# Default acpi script that takes an entry for all actions

group=${1%%/*}
action=${1#*/}
device=$2
id=$3
value=$4

bl_device=/sys/class/backlight/acpi_video0
bl_max=$(cat $bl_device/max_brightness)

log_unhandled() {
	logger "ACPI event unhandled: $*"
}

case "$group" in
	button)
		case "$action" in
			power)
				/sbin/init 0
				;;

			# if your laptop doesnt turn on/off the display via hardware
			# switch and instead just generates an acpi event, you can force
			# X to turn off the display via dpms.  note you will have to run
			# 'xhost +local:0' so root can access the X DISPLAY.
			#lid)
			#	xset dpms force off
			#	;;
			lid)
				case "$id" in
					close)
						/usr/sbin/pm-suspend --quirk-vbe-post &
						DISPLAY=:0.0 su -c -l matt /usr/bin/slimlock
						;;
					*)	log_unhandled $* ;;
				esac
				;;

			*)	log_unhandled $* ;;
		esac
		;;

	ac_adapter)
		case "$value" in
			# Add code here to handle when the system is unplugged
			# (maybe change cpu scaling to powersave mode).  For
			# multicore systems, make sure you set powersave mode
			# for each core!
			#*0)
			#	cpufreq-set -g powersave
			#	;;
			*0)
				echo -n 0 > $bl_device/brightness
				
				echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
				for file in /sys/class/scsi_host/*; do
					echo min_power > $file/link_power_management_policy
				done

				ethtool -s eth0 wol d
				iwconfig wlan0 power on
				iwconfig wlan0 power timeout 500ms

				echo 1 > /sys/module/snd_hda_intel/parameters/power_save
				;;

			# Add code here to handle when the system is plugged in
			# (maybe change cpu scaling to performance mode).  For
			# multicore systems, make sure you set performance mode
			# for each core!
			#*1)
			#	cpufreq-set -g performance
			#	;;
			*1)
				echo -n $bl_max > $bl_device/brightness

				echo 500 > /proc/sys/vm/dirty_writeback_centisecs
				for file in /sys/class/scsi_host/*; do
					echo max_performance > $file/link_power_management_policy
				done

				ethtool -s eth0 wol g
				iwconfig wlan0 power off

				echo 0 > /sys/module/snd_hda_intel/parameters/power_save
				;;

			*)	log_unhandled $* ;;
		esac
		;;

#	video)
#		case "$action" in
#			brightnessup)
#				bl_new=$(($(cat $bl_device/brightness) + 1))
#				if [[ $bl_new -le $bl_max ]]; then
#					echo -n $bl_new > $bl_device/brightness
#				fi
#				;;
#			brightnessdown)
#				bl_new=$(($(cat $bl_device/brightness) - 1))
#				if [[ $bl_new -ge 0 ]]; then
#					echo -n $bl_new > $bl_device/brightness
#				fi
#				;;
#			*)	log_unhandled $* ;;
#		esac
#		;;

	*)	log_unhandled $* ;;
esac

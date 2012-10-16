#!/bin/zsh

source ${HOME}/.xmonad/bars/sb_env

DZEN_XPOS=960
DZEN_YPOS=0

CONKYRC="${HOME}/.xmonad/conky/conkyrc_top"

print_cpu_info() {
  echo -n "CPU: ^fg($DZEN_FG2)${cpufreq}GHz^fg() "
  echo -n "$(echo $cpuperc | gdbar -fg $GDBAR_FG -bg $GDBAR_BG -h $GDBAR_H -w $GDBAR_W -s o -ss 1 -sw 2 -nonl)"
}

print_mem_info() {
  echo -n "Mem: ^fg($DZEN_FG2)$memused/$memmax ^fg()"
  echo -n "$(echo $memperc | gdbar -fg $GDBAR_FG -bg $GDBAR_BG -h $GDBAR_H -w $GDBAR_W -s o -ss 1 -sw 2 -nonl)"
}

print_fs_info() {
  echo -n "FS: ^fg($DZEN_FG2)$fs_type $fs_used/$fs_size ^fg()"
  echo -n "$(echo $fs_perc | gdbar -fg $GDBAR_FG -bg $GDBAR_BG -h $GDBAR_H -w $GDBAR_W -s o -ss 1 -sw 2 -nonl)"
}

print_network_info() {
  echo -n "Net: ^fg($DZEN_FG2)$netdown/$netup^fg()"
}

print_date_info() {
  echo -n "$dateinfo"
}

print_space() {
  echo -n " ^fg($DZEN_FG2)|^fg() "
}

print_bar() {
  while true; do
    read cpuperc cpufreq memused memmax memperc fs_type fs_used fs_size fs_perc netdown netup dateinfo
    print_cpu_info
    print_space
    print_mem_info
    print_space
    print_fs_info
    print_space
    print_network_info
    print_space
    print_date_info
    echo
  done
  return
}

conky -c  $CONKYRC | print_bar | dzen2 -x $DZEN_XPOS -y $DZEN_YPOS -w $DZEN_W -h $DZEN_H -bg $DZEN_BG -fg $DZEN_FG -fn $DZEN_FONT -ta r -p

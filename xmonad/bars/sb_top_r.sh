#!/bin/zsh

source ${HOME}/.xmonad/bars/sb_env

DZEN_XPOS=840
DZEN_YPOS=0

CONKYRC="${HOME}/.xmonad/conky/conkyrc_top"

print_cpu_info() {
  echo -n "CPU: ^fg($DZEN_FG2)${cpufreq}GHz^fg() "
  echo -n "$(echo $cpuperc | gdbar ${GDBAR_ARGS[@]})"
}

print_mem_info() {
  echo -n "Mem: ^fg($DZEN_FG2)$memused/$memmax ^fg()"
  echo -n "$(echo $memperc | gdbar ${GDBAR_ARGS[@]})"
}

print_fs_info() {
  echo -n "FS: ^fg($DZEN_FG2)$fs_type $fs_used/$fs_size ^fg()"
  echo -n "$(echo $fs_perc | gdbar ${GDBAR_ARGS[@]})"
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
    read cpuperc cpufreq memused memmax memperc fs_type \
         fs_used fs_size fs_perc dateinfo
    print_cpu_info
    print_space
    print_mem_info
    print_space
    print_fs_info
    print_space
    # print_network_info
    # print_space
    print_date_info
    echo
  done
  return
}

conky -c  $CONKYRC |
print_bar |
dzen2 -x $DZEN_XPOS -y $DZEN_YPOS ${DZEN_ARGS_R[@]}

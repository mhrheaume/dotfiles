#!/bin/zsh

export DZEN_FG="#ffffff"
export DZEN_FG2="#3475aa"
export DZEN_BG="#1a1a1a"
export DZEN_W=$(( $($HOME/.xmonad/misc/query_xres.sh x) / 2 ))
export DZEN_H=24
export DZEN_FONT="Monospace-8"

DZEN_ARGS_L=(-w $DZEN_W -h $DZEN_H -bg $DZEN_BG -fg $DZEN_FG)
DZEN_ARGS_L=(${DZEN_ARGS_L[@]} -fn $DZEN_FONT -ta l -p)
export DZEN_ARGS_L

DZEN_ARGS_R=(-w $DZEN_W -h $DZEN_H -bg $DZEN_BG -fg $DZEN_FG)
DZEN_ARGS_R=(${DZEN_ARGS_R[@]} -fn $DZEN_FONT -ta r -p)
export DZEN_ARGS_R

export ICON_DIR="$HOME/.xmonad/icons"

print_space() {
	echo -n " ^fg($DZEN_FG2)|^fg() "
}


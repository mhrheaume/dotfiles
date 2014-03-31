#!/bin/zsh

source $HOME/.xmonad/bars/sb_env.sh

DZEN_XPOS=0
DZEN_YPOS=0

dzen2 -x $DZEN_XPOS -y $DZEN_YPOS ${DZEN_ARGS_L[@]}

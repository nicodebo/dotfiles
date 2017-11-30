#!/usr/bin/env bash

# uncomment for debugging purpose
# set -x

# autostart script
# start common application at startup
# desktop
# 0: main
# 1: dev
# 2: mail
# 3: monitor
# 4: log

# Don't run a program if it is already running
function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

function main {

  wmctrl -s 1
  termite -t media -e 'zsh -c "tmuxinator start at_startup"'&
  sleep 1

  # wmctrl -s 0
  # run termite -t reminder -e 'zsh -c "remind ~/.config/remind/remind; exec zsh"'
  # sleep 1

  wmctrl -s 0
  run qutebrowser
  sleep 2

}

main

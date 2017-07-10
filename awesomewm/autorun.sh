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

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

function main {

  # sleep 1
  wmctrl -s 2
  run termite -t rss -e 'zsh -c "newsbeuter; exec zsh"'
  sleep 1

  wmctrl -s 0
  run termite -t reminder -e 'zsh -c "remind ~/.config/remind/remind; exec zsh"'
  sleep 1

  wmctrl -s 1
  run qutebrowser --backend webengine
  sleep 2

  wmctrl -s 2
  run termite -t mail -e 'zsh -c "offlineimap && mutt; exec zsh"'
  sleep 1
  wmctrl -s 0
}

main

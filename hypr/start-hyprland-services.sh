#!/bin/bash

start_service() {
  if pgrep -x $1 >/dev/null; then
    echo "$1 already running! Killing..."
    pkill $1
  fi

  echo "Starting $1..."
  $1 &> ~/.local/share/$1.log & disown
}

start_service pipewire
start_service pipewire-pulse
start_service wireplumber

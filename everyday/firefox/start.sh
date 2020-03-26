#!/bin/bash
set -eux
cd "$(dirname "$0")"
sudo systemd-nspawn -D bootstrap -u c -M firefox --setenv=DISPLAY=$DISPLAY --bind-ro=/tmp/.X11-unix --bind-ro=$XDG_RUNTIME_DIR/pulse:/container$XDG_RUNTIME_DIR/pulse --setenv=PULSE_SERVER=/container/$XDG_RUNTIME_DIR/pulse/native firefox

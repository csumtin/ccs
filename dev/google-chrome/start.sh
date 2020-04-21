#!/bin/bash
set -eux
cd "$(dirname "$0")"
sudo systemd-nspawn -D bootstrap -u c -M google-chrome --setenv=DISPLAY=$DISPLAY --bind-ro=/tmp/.X11-unix --bind-ro=/dev/dri/card0 google-chrome

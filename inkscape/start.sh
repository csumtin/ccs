#!/bin/bash
set -eux

sudo systemd-nspawn -D bootstrap -u c -M inkscape --setenv=DISPLAY=$DISPLAY --bind-ro=/tmp/.X11-unix

#!/bin/bash
set -eux

sudo systemd-nspawn -D bootstrap -M android-shell --bind=/dev/fuse --bind=/dev/bus/usb --property='DeviceAllow=/dev/bus/usb/003/002 rw'

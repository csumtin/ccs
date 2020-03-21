#!/bin/bash
set -eux
cd "$(dirname "$0")"
sudo systemd-nspawn -D bootstrap -u c -M android-mtp --bind=/dev/fuse --bind=/dev/bus/usb --property='DeviceAllow=/dev/bus/usb/003/003 rw'

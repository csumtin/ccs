#!/bin/bash
set -eux
cd "$(dirname "$0")"
sudo systemd-nspawn -b -D bootstrap -M printer

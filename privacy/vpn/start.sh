#!/bin/bash
set -eux
cd "$(dirname "$0")"
sudo systemd-nspawn -D bootstrap -M vpn --capability=CAP_NET_ADMIN
